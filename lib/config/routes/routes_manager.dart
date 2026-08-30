import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meayar_alitqan/core/components/full_screen_image_view.dart';
import 'package:meayar_alitqan/features/auth/presentation/views/forget_password_view.dart';
import 'package:meayar_alitqan/features/auth/presentation/views/otp_view.dart';
import 'package:meayar_alitqan/features/profile/shared/presentation/views/contact_us_view.dart';
import 'package:meayar_alitqan/features/profile/shared/presentation/views/privacy_policy_view.dart';
import '../../features/auth/presentation/views/complete_profile_view.dart';
import '../../features/auth/presentation/views/login_view.dart';
import '../../features/auth/presentation/views/register_view.dart';
import '../../features/auth/presentation/views/reset_password_view.dart';
import '../../features/auth/presentation/views/role_selection_view.dart';
import '../../features/home/presentation/tabs/technician/report/presentation/view/technician_reports_view.dart';
import '../../features/home/presentation/views/customer_home_view.dart';
import '../../features/home/presentation/views/home_view.dart';
import '../../features/home/presentation/views/technician_home_view.dart';
import '../../features/notifications/presentation/views/notifications_view.dart';
import '../../features/onboarding/presentation/views/onboarding_view.dart';
import '../../features/orders/shared/domain/entities/order_entity/order_entity.dart';
import '../../features/orders/technician/presentation/views/order_details_view.dart';
import '../../features/profile/shared/presentation/views/account_settings_view.dart';
import '../../features/profile/shared/presentation/views/app_language_view.dart';
import '../../features/profile/shared/presentation/views/faq_view.dart';
import '../../features/profile/shared/presentation/views/terms_and_conditions_view.dart';
import '../../features/services/presentation/views/service_request_details_view.dart';
import '../../features/services/presentation/views/sub_services_view.dart';
import '../../features/services/presentation/views/sub_categories_view.dart';
import '../../features/services/presentation/widgets/sub_services_view_body.dart';
import '../../features/splash/presentation/views/splash_view.dart';

class RoutesManager {
  static const String splash = "/";
  static const String onBoarding = "/onBoarding";
  static const String login = "/login";
  static const String register = "/register";
  static const String roleSelection = "/roleSelection";
  static const String customerHome = "/customerHome";
  static const String homeView = "/home";
  static const String servicesSubCategorySelectionView =
      "/servicesSubCategorySelectionView";
  static const String serviceRequestDetailsView = "/serviceRequestDetailsView";
  static const String subCategoriesView = "/subCategoriesView";
  static const String accountSettingsView = "/accountSettingsView";
  static const String appLanguageView = "/appLanguageView";
  static const String termsAndConditionsView = "/termsAndConditionsView";
  static const String privacyPolicyView = "/privacyPolicyView";
  static const String reportView = "/reportView";

  static const String technicianHomeView = "/technicianHomeView";
  static const String orderDetailsView = "/orderDetailsView";
  static const String faqView = "/faqView";
  static const String notificationsView = "/notificationsView";
  static const String completeProfileView = "/completeProfileView";
  static const String forgotPasswordView = "/forgot-password";
  static const String resetPasswordView = "/reset-password";
  static const String contactUs = "/contactUs";
  static const String otpView = "/otpView";

  static const fullScreenImage = 'fullScreenImage';

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        if (kIsWeb) {
          return MaterialPageRoute(builder: (_) => const CustomerHomeView());
        }
        return MaterialPageRoute(builder: (_) => const SplashView());

      case onBoarding:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      case login:
        final role = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => LoginView(role: role));
      case register:
        final role = settings.arguments as String;

        return MaterialPageRoute(builder: (_) => RegisterView(role: role));
      case roleSelection:
        return MaterialPageRoute(builder: (_) => const RoleSelectionView());
      case technicianHomeView:
        return MaterialPageRoute(builder: (_) => const TechnicianHomeView());
      case customerHome:
        return MaterialPageRoute(builder: (_) => const CustomerHomeView());
      case homeView:
        return MaterialPageRoute(builder: (_) => HomeView());
      case servicesSubCategorySelectionView:
        final args = settings.arguments as Map<String, String>;
        return MaterialPageRoute(
          builder: (_) => SubServicesView(
            categoryId: args["categoryId"]!,
            title: args["title"]!,
            mainCategoryId: args["mainCategoryId"]!,
          ),
        );
      case serviceRequestDetailsView:
        final args = settings.arguments as ServiceRequestDetailsArgs;

        return MaterialPageRoute(
          builder: (_) => ServiceRequestDetailsView(
            mainCategoryId: args.mainCategoryId,
            categoryId: args.categoryId,
            subserviceId: args.subserviceId,
            title: args.title,
          ),
        );

      case subCategoriesView:
        final args = settings.arguments as Map<String, String>;

        return MaterialPageRoute(
          builder: (_) => SubCategoriesView(
            title: args["title"]!,
            categoryId: args["categoryId"]!,
          ),
        );
      case accountSettingsView:
        return MaterialPageRoute(builder: (_) => const AccountSettingsView());
      
      case reportView:
        return MaterialPageRoute(builder: (_) => const TechnicianReportsView());
      
      // case appLanguageView:
      //   return MaterialPageRoute(builder: (_) => const AppLanguageView());
      case termsAndConditionsView:
        return MaterialPageRoute(
          builder: (_) => const TermsAndConditionsView(),
        );
      case orderDetailsView:
        final args = settings.arguments as OrderEntity;
        return MaterialPageRoute(builder: (_) => OrderDetailsView(order: args));
      case faqView:
        return MaterialPageRoute(builder: (_) => const FaqView());
      case notificationsView:
        return MaterialPageRoute(builder: (_) => const NotificationsView());
      case completeProfileView:
        return MaterialPageRoute(builder: (_) => const CompleteProfileView());
      case forgotPasswordView:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordView());
      case resetPasswordView:
        return MaterialPageRoute(builder: (_) => const ResetPasswordView());
      case privacyPolicyView:
        return MaterialPageRoute(builder: (_) => const PrivacyPolicyView());
      case RoutesManager.fullScreenImage:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => FullScreenImageView(
            imageUrl: args['imageUrl'],
            heroTag: args['heroTag'],
          ),
        );

      case contactUs:
        return MaterialPageRoute(builder: (_) => const ContactUsView());

      default:
        return MaterialPageRoute(builder: (_) => const Placeholder());
    }
  }
}
