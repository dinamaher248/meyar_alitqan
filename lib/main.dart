// import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'features/auth/presentation/views/login_view.dart';
import 'features/home/presentation/views/customer_home_view.dart';
import 'features/home/presentation/views/technician_home_view.dart';
import 'features/orders/customer/presentation/manager/get_customer_orders_view_model/get_customer_orders_view_model.dart';
import 'features/splash/presentation/views/splash_view.dart';
import 'firebase_options.dart';
import 'config/routes/routes_manager.dart';
import 'config/theme/app_theme.dart';
import 'core/cache/shared_preferences.dart';
import 'core/cubit/app_user/app_user_cubit.dart';
import 'core/di/di.dart';
import 'core/enums/user_role.dart';
import 'core/utils/constants_manager.dart';
import 'features/banners/presentation/manager/get_banners_view_model/get_banners_view_model.dart';
import 'features/services/presentation/manager/get_main_categories_view_model/get_main_categories_view_model.dart';
import 'features/profile/shared/domain/use_cases/get_current_user_usecase/get_current_user_usecase.dart';
import 'features/profile/shared/presentation/manager/language_view_model/language_view_model.dart';
import 'l10n/app_localizations.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

await Supabase.initialize(
  url: ConstantsManager.supabaseUrl,
  anonKey: ConstantsManager.supabaseAnonKey,
  authOptions: const FlutterAuthClientOptions(
    detectSessionInUri: true,
  ),
);

final supabase = Supabase.instance.client;
 


  await configureDependencies();
  await SharedPrefHelper.init();

  Session? session = supabase.auth.currentSession;

  if (session?.refreshToken != null) {
    final authState = await supabase.auth.refreshSession();
    session = authState.session;
  }

  if (session != null) {
    try {
      final result = await getIt<GetCurrentUserUseCase>().getCurrentUser(
        accessToken: session.accessToken,
      );

      result.fold(
        (_) => getIt<AppUserCubit>().setGuest(),
        (profile) => getIt<AppUserCubit>().setUser(profile),
      );
    } catch (_) {
      getIt<AppUserCubit>().setGuest();
    }
  } else {
    getIt<AppUserCubit>().setGuest();
  }

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<AppUserCubit>()),
        BlocProvider(create: (_) => getIt<LanguageCubit>()),
        BlocProvider(create: (_) => getIt<GetMainCategoriesViewModel>()),
        BlocProvider(create: (_) => getIt<GetBannersViewModel>()),
        BlocProvider(
          create: (context) => getIt<GetCustomerOrdersViewModel>()..getCustomerOrders(),
        ),
      ],
      child: const MeayarAlitqan(),
    ),
  );
}

class MeayarAlitqan extends StatefulWidget {
  const MeayarAlitqan({super.key});

  @override
  State<MeayarAlitqan> createState() => _MeayarAlitqanState();
}

class _MeayarAlitqanState extends State<MeayarAlitqan> {
  @override
  void initState() {
    super.initState();

    Supabase.instance.client.auth.onAuthStateChange.listen((data) async {
      final session = data.session;

      if (data.event == AuthChangeEvent.signedIn && session != null) {
        debugPrint("✅ WEB LOGIN SUCCESS");

        final result = await getIt<GetCurrentUserUseCase>().getCurrentUser(
          accessToken: session.accessToken,
        );

        result.fold(
              (_) => getIt<AppUserCubit>().setGuest(),
              (profile) => getIt<AppUserCubit>().setUser(profile),
        );

        await Supabase.instance.client.functions.invoke(
          'google_auth',
          body: {
            'role': 'customer',
            'fcm_token': null,
            'platform': 'web',
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          locale: context.watch<LanguageCubit>().state,
          supportedLocales: const [
            Locale('en'),
            Locale('ar'),
          ],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          onGenerateRoute: RoutesManager.onGenerateRoute,
          home: const AppRoot(),
        );
      },
    );
  }
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AppUserCubit>().state;

    /// ✅ Mobile
    if (!kIsWeb) {
      return const SplashView();
    }

    /// 🌐 Web Guest
    if (user == null) {
      return const CustomerHomeView();
    }

    /// 🌐 Web Customer
    if (user.role == UserRole.customer.name) {
      return const CustomerHomeView();
    }

    /// 🌐 Web Technician
    if (user.role == UserRole.technician.name) {
      return const TechnicianHomeView();
    }

    return const CustomerHomeView();
  }
}

// Future<void> handleAuthRedirect() async {
//   final uri = Uri.base;
//
//   if (uri.queryParameters.containsKey('code')) {
//     try {
//       debugPrint("🔁 Exchanging code...");
//
//       final res = await Supabase.instance.client.auth.exchangeCodeForSession(
//         uri.queryParameters['code']!,
//       );
//
//       if (res.session != null) {
//         debugPrint("✅ Session created");
//
//
//         final clean = uri.replace(queryParameters: {});
//         html.window.history.replaceState(null, '', clean.toString());
//       }
//     } catch (e) {
//       debugPrint("🔥 Exchange error: $e");
//     }
//   }
// }