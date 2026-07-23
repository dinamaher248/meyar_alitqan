import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meayar_alitqan/features/banners/presentation/manager/get_banners_view_model/get_banners_view_model.dart';
import 'package:meayar_alitqan/features/services/presentation/manager/get_main_categories_view_model/get_main_categories_view_model.dart';

import '../../../../config/routes/routes_manager.dart';
import '../../../../core/di/di.dart';
import '../../../../core/enums/user_role.dart';
import '../../../../core/utils/colors_manager.dart';
import '../manager/splash_view_model.dart';
import '../manager/splash_view_model_states.dart';
import '../widgets/splash_view_body.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();

    context.read<GetMainCategoriesViewModel>().getMainCategories();
    context.read<GetBannersViewModel>().getBanners();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SplashViewModel>()..start(),
      child: const _SplashViewContent(),
    );
  }
}

class _SplashViewContent extends StatelessWidget {
  const _SplashViewContent();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashViewModel, SplashViewModelStates>(
      listener: (context, state) {
        if (state is SplashGoToOnboarding) {
          Navigator.pushReplacementNamed(context, RoutesManager.onBoarding);
        }

        if (state is SplashGoToLogin) {
          Navigator.pushReplacementNamed(context, RoutesManager.roleSelection);
        }

        if (state is SplashGoToCustomerHome) {
          Navigator.pushReplacementNamed(
            context,
            RoutesManager.homeView,
            arguments: UserRole.customer,
          );
        }

        if (state is SplashGoToTechnicianHome) {
          Navigator.pushReplacementNamed(
            context,
            RoutesManager.homeView,
            arguments: UserRole.technician,
          );
        }
      },
      child: const Scaffold(
        backgroundColor: ColorsManager.primaryColor,
        body: SplashViewBody(),
      ),
    );
  }
}
