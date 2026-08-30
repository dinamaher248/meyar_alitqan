import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Meayar Alitqan'**
  String get appName;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome 👋'**
  String get welcome;

  /// No description provided for @onboarding_service_title.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Service'**
  String get onboarding_service_title;

  /// No description provided for @onboarding_service_desc.
  ///
  /// In en, this message translates to:
  /// **'Easily select the service you need from multiple categories in just a few simple steps'**
  String get onboarding_service_desc;

  /// No description provided for @onboarding_technician_title.
  ///
  /// In en, this message translates to:
  /// **'Fast Execution'**
  String get onboarding_technician_title;

  /// No description provided for @onboarding_technician_desc.
  ///
  /// In en, this message translates to:
  /// **'Get your service done quickly by skilled technicians with efficient response'**
  String get onboarding_technician_desc;

  /// No description provided for @onboarding_track_title.
  ///
  /// In en, this message translates to:
  /// **'Track Your Order'**
  String get onboarding_track_title;

  /// No description provided for @onboarding_track_desc.
  ///
  /// In en, this message translates to:
  /// **'Follow your order status in real time from request to completion'**
  String get onboarding_track_desc;

  /// No description provided for @onboarding_quality_title.
  ///
  /// In en, this message translates to:
  /// **'Quality Guaranteed'**
  String get onboarding_quality_title;

  /// No description provided for @onboarding_quality_desc.
  ///
  /// In en, this message translates to:
  /// **'Enjoy reliable maintenance services with guaranteed quality and care'**
  String get onboarding_quality_desc;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'skip'**
  String get skip;

  /// No description provided for @onboardingContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get onboardingContinue;

  /// No description provided for @onboarding_quality_check1.
  ///
  /// In en, this message translates to:
  /// **'Certified technicians'**
  String get onboarding_quality_check1;

  /// No description provided for @onboarding_quality_check2.
  ///
  /// In en, this message translates to:
  /// **'All services under one roof'**
  String get onboarding_quality_check2;

  /// No description provided for @onboarding_quality_check3.
  ///
  /// In en, this message translates to:
  /// **'Fast execution, guaranteed quality'**
  String get onboarding_quality_check3;

  /// No description provided for @onboarding_service_check1.
  ///
  /// In en, this message translates to:
  /// **'Emergency for immediate response'**
  String get onboarding_service_check1;

  /// No description provided for @onboarding_service_check2.
  ///
  /// In en, this message translates to:
  /// **'Urgent within hours'**
  String get onboarding_service_check2;

  /// No description provided for @onboarding_service_check3.
  ///
  /// In en, this message translates to:
  /// **'Scheduled at the time that suits you'**
  String get onboarding_service_check3;

  /// No description provided for @onboarding_technician_check1.
  ///
  /// In en, this message translates to:
  /// **'Live tracking of your request status'**
  String get onboarding_technician_check1;

  /// No description provided for @onboarding_technician_check2.
  ///
  /// In en, this message translates to:
  /// **'Receive updates and photos during work'**
  String get onboarding_technician_check2;

  /// No description provided for @onboarding_technician_check3.
  ///
  /// In en, this message translates to:
  /// **'Ratings and e-invoice after completion'**
  String get onboarding_technician_check3;

  /// No description provided for @onboarding_page1_title.
  ///
  /// In en, this message translates to:
  /// **'One team for all your home needs'**
  String get onboarding_page1_title;

  /// No description provided for @onboarding_page2_title.
  ///
  /// In en, this message translates to:
  /// **'Your time matters.. choose the right request type'**
  String get onboarding_page2_title;

  /// No description provided for @onboarding_page3_title.
  ///
  /// In en, this message translates to:
  /// **'Stay assured.. track your request moment by moment'**
  String get onboarding_page3_title;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// No description provided for @orLoginWith.
  ///
  /// In en, this message translates to:
  /// **'Or sign in with'**
  String get orLoginWith;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Login to continue using the app'**
  String get loginSubtitle;

  /// No description provided for @continueAsGuestDescription.
  ///
  /// In en, this message translates to:
  /// **'Browse services without creating an account'**
  String get continueAsGuestDescription;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phone;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get loginTitle;

  /// No description provided for @registerTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get registerTitle;

  /// No description provided for @registerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign up to get started'**
  String get registerSubtitle;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @emergencyBannerMessage.
  ///
  /// In en, this message translates to:
  /// **'Choosing the request type helps us provide the best technician at the right time.'**
  String get emergencyBannerMessage;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @createNewAccount.
  ///
  /// In en, this message translates to:
  /// **'Create New Account'**
  String get createNewAccount;

  /// No description provided for @continueText.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueText;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginButton;

  /// No description provided for @registerButton.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get registerButton;

  /// No description provided for @orContinueWith.
  ///
  /// In en, this message translates to:
  /// **'Or continue with'**
  String get orContinueWith;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'Or'**
  String get or;

  /// No description provided for @continueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogle;

  /// No description provided for @google.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get google;

  /// No description provided for @privacyPolicyAgreement.
  ///
  /// In en, this message translates to:
  /// **'By creating an account you agree to the '**
  String get privacyPolicyAgreement;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'privacy policy'**
  String get privacyPolicy;

  /// No description provided for @termsAgreement.
  ///
  /// In en, this message translates to:
  /// **' and to the '**
  String get termsAgreement;

  /// No description provided for @termsOfUse.
  ///
  /// In en, this message translates to:
  /// **'terms of use'**
  String get termsOfUse;

  /// No description provided for @selectRoleTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Account'**
  String get selectRoleTitle;

  /// No description provided for @selectRoleDescription.
  ///
  /// In en, this message translates to:
  /// **'Select your account type to continue'**
  String get selectRoleDescription;

  /// No description provided for @customer.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get customer;

  /// No description provided for @technician.
  ///
  /// In en, this message translates to:
  /// **'Technician'**
  String get technician;

  /// No description provided for @customerDesc.
  ///
  /// In en, this message translates to:
  /// **'Request maintenance servicesRR'**
  String get customerDesc;

  /// No description provided for @technicianDesc.
  ///
  /// In en, this message translates to:
  /// **'Provide maintenance services'**
  String get technicianDesc;

  /// No description provided for @noInternet.
  ///
  /// In en, this message translates to:
  /// **'No Internet Connection'**
  String get noInternet;

  /// No description provided for @requiredField.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get requiredField;

  /// No description provided for @fullNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Full name is required'**
  String get fullNameRequired;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailRequired;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get invalidEmail;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// No description provided for @invalidPassword.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get invalidPassword;

  /// No description provided for @confirmPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Confirm password is required'**
  String get confirmPasswordRequired;

  /// No description provided for @passwordNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordNotMatch;

  /// No description provided for @phoneRequired.
  ///
  /// In en, this message translates to:
  /// **'Phone number is required'**
  String get phoneRequired;

  /// No description provided for @invalidPhone.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid phone number'**
  String get invalidPhone;

  /// No description provided for @mustAcceptTerms.
  ///
  /// In en, this message translates to:
  /// **'You must agree to the terms and conditions before continuing'**
  String get mustAcceptTerms;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @pleaseWait.
  ///
  /// In en, this message translates to:
  /// **'Please wait'**
  String get pleaseWait;

  /// No description provided for @loginSuccess.
  ///
  /// In en, this message translates to:
  /// **'Logged in successfully'**
  String get loginSuccess;

  /// No description provided for @registerSuccess.
  ///
  /// In en, this message translates to:
  /// **'Account created successfully'**
  String get registerSuccess;

  /// No description provided for @logoutSuccess.
  ///
  /// In en, this message translates to:
  /// **'Logged out successfully'**
  String get logoutSuccess;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong, please try again'**
  String get somethingWentWrong;

  /// No description provided for @userNotFound.
  ///
  /// In en, this message translates to:
  /// **'User not found'**
  String get userNotFound;

  /// No description provided for @wrongPassword.
  ///
  /// In en, this message translates to:
  /// **'Wrong password'**
  String get wrongPassword;

  /// No description provided for @emailAlreadyInUse.
  ///
  /// In en, this message translates to:
  /// **'Email is already in use'**
  String get emailAlreadyInUse;

  /// No description provided for @startNow.
  ///
  /// In en, this message translates to:
  /// **'Start Now'**
  String get startNow;

  /// No description provided for @orders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get orders;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search for services.....'**
  String get search;

  /// No description provided for @chooseSuitableService.
  ///
  /// In en, this message translates to:
  /// **'Choose the service that suits you'**
  String get chooseSuitableService;

  /// No description provided for @currencyDinar.
  ///
  /// In en, this message translates to:
  /// **'Dinar'**
  String get currencyDinar;

  /// No description provided for @satisfiedCustomers.
  ///
  /// In en, this message translates to:
  /// **'satisfied customers'**
  String get satisfiedCustomers;

  /// No description provided for @by.
  ///
  /// In en, this message translates to:
  /// **'By'**
  String get by;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @orderType.
  ///
  /// In en, this message translates to:
  /// **'Order Type'**
  String get orderType;

  /// No description provided for @booking.
  ///
  /// In en, this message translates to:
  /// **'Booking'**
  String get booking;

  /// No description provided for @confirmation.
  ///
  /// In en, this message translates to:
  /// **'Confirmation'**
  String get confirmation;

  /// No description provided for @createOrder.
  ///
  /// In en, this message translates to:
  /// **'Create Order'**
  String get createOrder;

  /// No description provided for @orderSection.
  ///
  /// In en, this message translates to:
  /// **'Order Section'**
  String get orderSection;

  /// No description provided for @addMedia.
  ///
  /// In en, this message translates to:
  /// **'Add images or videos showing the issue (Optional)'**
  String get addMedia;

  /// No description provided for @january.
  ///
  /// In en, this message translates to:
  /// **'January'**
  String get january;

  /// No description provided for @february.
  ///
  /// In en, this message translates to:
  /// **'February'**
  String get february;

  /// No description provided for @march.
  ///
  /// In en, this message translates to:
  /// **'March'**
  String get march;

  /// No description provided for @april.
  ///
  /// In en, this message translates to:
  /// **'April'**
  String get april;

  /// No description provided for @may.
  ///
  /// In en, this message translates to:
  /// **'May'**
  String get may;

  /// No description provided for @june.
  ///
  /// In en, this message translates to:
  /// **'June'**
  String get june;

  /// No description provided for @july.
  ///
  /// In en, this message translates to:
  /// **'July'**
  String get july;

  /// No description provided for @august.
  ///
  /// In en, this message translates to:
  /// **'August'**
  String get august;

  /// No description provided for @september.
  ///
  /// In en, this message translates to:
  /// **'September'**
  String get september;

  /// No description provided for @october.
  ///
  /// In en, this message translates to:
  /// **'October'**
  String get october;

  /// No description provided for @november.
  ///
  /// In en, this message translates to:
  /// **'November'**
  String get november;

  /// No description provided for @december.
  ///
  /// In en, this message translates to:
  /// **'December'**
  String get december;

  /// No description provided for @chooseTime.
  ///
  /// In en, this message translates to:
  /// **'Choose Time'**
  String get chooseTime;

  /// No description provided for @saturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get saturday;

  /// No description provided for @sunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get sunday;

  /// No description provided for @monday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get monday;

  /// No description provided for @tuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get tuesday;

  /// No description provided for @wednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get wednesday;

  /// No description provided for @thursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get thursday;

  /// No description provided for @friday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get friday;

  /// No description provided for @am.
  ///
  /// In en, this message translates to:
  /// **'AM'**
  String get am;

  /// No description provided for @pm.
  ///
  /// In en, this message translates to:
  /// **'PM'**
  String get pm;

  /// No description provided for @editOrder.
  ///
  /// In en, this message translates to:
  /// **'Edit Order'**
  String get editOrder;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @costSummary.
  ///
  /// In en, this message translates to:
  /// **'Cost Summary'**
  String get costSummary;

  /// No description provided for @urgentOrderFee.
  ///
  /// In en, this message translates to:
  /// **'Urgent Order Fee'**
  String get urgentOrderFee;

  /// No description provided for @expectedTotal.
  ///
  /// In en, this message translates to:
  /// **'Estimated Total'**
  String get expectedTotal;

  /// No description provided for @uploadedMedia.
  ///
  /// In en, this message translates to:
  /// **'uploaded'**
  String get uploadedMedia;

  /// No description provided for @images.
  ///
  /// In en, this message translates to:
  /// **'images'**
  String get images;

  /// No description provided for @video.
  ///
  /// In en, this message translates to:
  /// **'videos'**
  String get video;

  /// No description provided for @and.
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get and;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Services Section'**
  String get categories;

  /// No description provided for @completeData.
  ///
  /// In en, this message translates to:
  /// **'Complete data'**
  String get completeData;

  /// No description provided for @addServiceRequestDetails.
  ///
  /// In en, this message translates to:
  /// **'Service Request Details'**
  String get addServiceRequestDetails;

  /// No description provided for @writeRequestDetailsHint.
  ///
  /// In en, this message translates to:
  /// **'Describe the issue clearly to help us serve you better.'**
  String get writeRequestDetailsHint;

  /// No description provided for @addPhotosForYourProblem.
  ///
  /// In en, this message translates to:
  /// **'Add Photos of the Issue'**
  String get addPhotosForYourProblem;

  /// No description provided for @selectRequestType.
  ///
  /// In en, this message translates to:
  /// **'Select Request Priority'**
  String get selectRequestType;

  /// No description provided for @requestType.
  ///
  /// In en, this message translates to:
  /// **'Request Priority'**
  String get requestType;

  /// No description provided for @scheduled.
  ///
  /// In en, this message translates to:
  /// **'Scheduled'**
  String get scheduled;

  /// No description provided for @scheduledSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Best price · Service within 1–2 days'**
  String get scheduledSubtitle;

  /// No description provided for @urgent.
  ///
  /// In en, this message translates to:
  /// **'Urgent'**
  String get urgent;

  /// No description provided for @urgentSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Service within 4–6 hours'**
  String get urgentSubtitle;

  /// No description provided for @emergency.
  ///
  /// In en, this message translates to:
  /// **'Emergency'**
  String get emergency;

  /// No description provided for @emergencySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Immediate response within 1–2 hours'**
  String get emergencySubtitle;

  /// No description provided for @addVideosForYourProblem.
  ///
  /// In en, this message translates to:
  /// **'Add a Video (Optional)'**
  String get addVideosForYourProblem;

  /// No description provided for @maximumOneVideo.
  ///
  /// In en, this message translates to:
  /// **'Up to 1 video'**
  String get maximumOneVideo;

  /// No description provided for @submitRequest.
  ///
  /// In en, this message translates to:
  /// **'Submit Request'**
  String get submitRequest;

  /// No description provided for @serviceTitle.
  ///
  /// In en, this message translates to:
  /// **'Service Details'**
  String get serviceTitle;

  /// No description provided for @numberOfCustomers.
  ///
  /// In en, this message translates to:
  /// **'Number of customers'**
  String get numberOfCustomers;

  /// No description provided for @averageRating.
  ///
  /// In en, this message translates to:
  /// **'Average rating'**
  String get averageRating;

  /// No description provided for @ratingValue.
  ///
  /// In en, this message translates to:
  /// **'({rating})'**
  String ratingValue(Object rating);

  /// No description provided for @currentServices.
  ///
  /// In en, this message translates to:
  /// **'Current Services'**
  String get currentServices;

  /// No description provided for @previousServices.
  ///
  /// In en, this message translates to:
  /// **'Previous Services'**
  String get previousServices;

  /// No description provided for @publicDetails.
  ///
  /// In en, this message translates to:
  /// **'Public Details'**
  String get publicDetails;

  /// No description provided for @orderStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get orderStatusPending;

  /// No description provided for @orderStatusInProgress.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get orderStatusInProgress;

  /// No description provided for @orderStatusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get orderStatusCompleted;

  /// No description provided for @orderStatusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get orderStatusCancelled;

  /// No description provided for @orderName.
  ///
  /// In en, this message translates to:
  /// **'Order Name'**
  String get orderName;

  /// No description provided for @serviceName.
  ///
  /// In en, this message translates to:
  /// **'Service'**
  String get serviceName;

  /// No description provided for @serviceDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get serviceDate;

  /// No description provided for @serviceTime.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get serviceTime;

  /// No description provided for @uploadedPhotos.
  ///
  /// In en, this message translates to:
  /// **'Uploaded Photos'**
  String get uploadedPhotos;

  /// No description provided for @uploadedVideos.
  ///
  /// In en, this message translates to:
  /// **'Uploaded Videos'**
  String get uploadedVideos;

  /// No description provided for @viewOrder.
  ///
  /// In en, this message translates to:
  /// **'View Order'**
  String get viewOrder;

  /// No description provided for @cancelOrder.
  ///
  /// In en, this message translates to:
  /// **'Cancel Order'**
  String get cancelOrder;

  /// No description provided for @serviceProvider.
  ///
  /// In en, this message translates to:
  /// **'Assigned Technician & Service Rating'**
  String get serviceProvider;

  /// No description provided for @uploadingWithProgress.
  ///
  /// In en, this message translates to:
  /// **'Uploading {progress}%'**
  String uploadingWithProgress(Object progress);

  /// No description provided for @uploadingVideoHint.
  ///
  /// In en, this message translates to:
  /// **'Please wait while the video is being uploaded, this may take a few minutes'**
  String get uploadingVideoHint;

  /// No description provided for @videoUploadedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Video uploaded successfully'**
  String get videoUploadedSuccessfully;

  /// Number of uploaded photos
  ///
  /// In en, this message translates to:
  /// **'{count} photos added'**
  String photosCount(int count);

  /// No description provided for @personalFile.
  ///
  /// In en, this message translates to:
  /// **'Personal File'**
  String get personalFile;

  /// No description provided for @ourMainLocation.
  ///
  /// In en, this message translates to:
  /// **'ourMainLocation: '**
  String get ourMainLocation;

  /// No description provided for @youCanContactUsBy.
  ///
  /// In en, this message translates to:
  /// **'You Can Contact Us By: '**
  String get youCanContactUsBy;

  /// No description provided for @accountSettings.
  ///
  /// In en, this message translates to:
  /// **'Account Settings'**
  String get accountSettings;

  /// No description provided for @appLanguage.
  ///
  /// In en, this message translates to:
  /// **'App Language'**
  String get appLanguage;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get termsAndConditions;

  /// No description provided for @faq.
  ///
  /// In en, this message translates to:
  /// **'FAQ'**
  String get faq;

  /// No description provided for @problemDescriptionValidation.
  ///
  /// In en, this message translates to:
  /// **'Please enter a clear problem description (at least 10 characters)'**
  String get problemDescriptionValidation;

  /// No description provided for @imagesUploading.
  ///
  /// In en, this message translates to:
  /// **'Please wait until images upload is finished'**
  String get imagesUploading;

  /// No description provided for @videoUploading.
  ///
  /// In en, this message translates to:
  /// **'Please wait until video upload is finished'**
  String get videoUploading;

  /// No description provided for @requestSentTitle.
  ///
  /// In en, this message translates to:
  /// **'Request Sent Successfully'**
  String get requestSentTitle;

  /// No description provided for @requestSentDescription.
  ///
  /// In en, this message translates to:
  /// **'Your request has been received. A specialized technician will contact you shortly.\nYou can track the request status and you will receive notifications for any updates.'**
  String get requestSentDescription;

  /// No description provided for @goToHome.
  ///
  /// In en, this message translates to:
  /// **'Go to Home'**
  String get goToHome;

  /// No description provided for @selectScheduledDate.
  ///
  /// In en, this message translates to:
  /// **'Service Date'**
  String get selectScheduledDate;

  /// No description provided for @chooseDate.
  ///
  /// In en, this message translates to:
  /// **'Select date'**
  String get chooseDate;

  /// No description provided for @scheduledDateRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select a scheduled date'**
  String get scheduledDateRequired;

  /// No description provided for @noTechnicianAssigned.
  ///
  /// In en, this message translates to:
  /// **'No technician assigned'**
  String get noTechnicianAssigned;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @deleteAccountDescription.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your account? This action cannot be undone.'**
  String get deleteAccountDescription;

  /// No description provided for @serviceType.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get serviceType;

  /// No description provided for @faqSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search for your question'**
  String get faqSearchHint;

  /// No description provided for @addQuestion.
  ///
  /// In en, this message translates to:
  /// **'Add your question'**
  String get addQuestion;

  /// No description provided for @addQuestionSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Add your question'**
  String get addQuestionSheetTitle;

  /// No description provided for @addQuestionSheetDescription.
  ///
  /// In en, this message translates to:
  /// **'Write your question and we\'ll reply within 24 hours'**
  String get addQuestionSheetDescription;

  /// No description provided for @writeYourQuestionHint.
  ///
  /// In en, this message translates to:
  /// **'Write your question here...'**
  String get writeYourQuestionHint;

  /// No description provided for @orderStatus.
  ///
  /// In en, this message translates to:
  /// **'Order Status'**
  String get orderStatus;

  /// No description provided for @requestDetails.
  ///
  /// In en, this message translates to:
  /// **'Request Details'**
  String get requestDetails;

  /// No description provided for @sendButton.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get sendButton;

  /// No description provided for @expectedPrice.
  ///
  /// In en, this message translates to:
  /// **'Expected Price'**
  String get expectedPrice;

  /// No description provided for @completedOrders.
  ///
  /// In en, this message translates to:
  /// **'Completed Orders'**
  String get completedOrders;

  /// No description provided for @canceledOrder.
  ///
  /// In en, this message translates to:
  /// **'Canceled Orders'**
  String get canceledOrder;

  /// No description provided for @newOrders.
  ///
  /// In en, this message translates to:
  /// **'New Orders'**
  String get newOrders;

  /// No description provided for @recentOrders.
  ///
  /// In en, this message translates to:
  /// **'Recent Orders'**
  String get recentOrders;

  /// No description provided for @oldOrders.
  ///
  /// In en, this message translates to:
  /// **'Old Orders'**
  String get oldOrders;

  /// No description provided for @poweredBy.
  ///
  /// In en, this message translates to:
  /// **'Powered by'**
  String get poweredBy;

  /// No description provided for @order_status_pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get order_status_pending;

  /// No description provided for @order_status_assigned.
  ///
  /// In en, this message translates to:
  /// **'Assigned'**
  String get order_status_assigned;

  /// No description provided for @order_status_onTheWay.
  ///
  /// In en, this message translates to:
  /// **'On the way'**
  String get order_status_onTheWay;

  /// No description provided for @order_status_arrived.
  ///
  /// In en, this message translates to:
  /// **'Arrived'**
  String get order_status_arrived;

  /// No description provided for @todaySummary.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Summary'**
  String get todaySummary;

  /// No description provided for @completedLabel.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completedLabel;

  /// No description provided for @todayOrdersLabel.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Orders'**
  String get todayOrdersLabel;

  /// No description provided for @profitLabel.
  ///
  /// In en, this message translates to:
  /// **'Profit'**
  String get profitLabel;

  /// No description provided for @noOrdersDescription.
  ///
  /// In en, this message translates to:
  /// **'You\'ll be notified when a new order arrives'**
  String get noOrdersDescription;

  /// No description provided for @browseNewOrders.
  ///
  /// In en, this message translates to:
  /// **'Browse New Orders'**
  String get browseNewOrders;

  /// No description provided for @upcomingOrders.
  ///
  /// In en, this message translates to:
  /// **'Upcoming Orders'**
  String get upcomingOrders;

  /// No description provided for @order_status_inProgress.
  ///
  /// In en, this message translates to:
  /// **'In progress'**
  String get order_status_inProgress;

  /// No description provided for @order_status_completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get order_status_completed;

  /// No description provided for @order_status_canceled.
  ///
  /// In en, this message translates to:
  /// **'Canceled'**
  String get order_status_canceled;

  /// No description provided for @request_priority_scheduled.
  ///
  /// In en, this message translates to:
  /// **'Scheduled'**
  String get request_priority_scheduled;

  /// No description provided for @request_priority_urgent.
  ///
  /// In en, this message translates to:
  /// **'Urgent'**
  String get request_priority_urgent;

  /// No description provided for @request_priority_emergency.
  ///
  /// In en, this message translates to:
  /// **'Emergency'**
  String get request_priority_emergency;

  /// No description provided for @totalPrice.
  ///
  /// In en, this message translates to:
  /// **'Total Price'**
  String get totalPrice;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @viewDetails.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get viewDetails;

  /// No description provided for @addLocation.
  ///
  /// In en, this message translates to:
  /// **'Add Location'**
  String get addLocation;

  /// No description provided for @addLocationHint.
  ///
  /// In en, this message translates to:
  /// **'Add location in details.'**
  String get addLocationHint;

  /// No description provided for @invalidLocation.
  ///
  /// In en, this message translates to:
  /// **'Invalid location , please enter your location'**
  String get invalidLocation;

  /// No description provided for @fetchingLocation.
  ///
  /// In en, this message translates to:
  /// **'Fetching location...'**
  String get fetchingLocation;

  /// No description provided for @displayCustomerLocation.
  ///
  /// In en, this message translates to:
  /// **'Display the customer\'s location'**
  String get displayCustomerLocation;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @serviceNumber.
  ///
  /// In en, this message translates to:
  /// **'Service Number'**
  String get serviceNumber;

  /// No description provided for @recentDailyTasks.
  ///
  /// In en, this message translates to:
  /// **'Your recent daily tasks'**
  String get recentDailyTasks;

  /// No description provided for @emailNotVerified.
  ///
  /// In en, this message translates to:
  /// **'Please verify your email before logging in'**
  String get emailNotVerified;

  /// No description provided for @accountDisabled.
  ///
  /// In en, this message translates to:
  /// **'This account has been disabled'**
  String get accountDisabled;

  /// No description provided for @invalidLoginData.
  ///
  /// In en, this message translates to:
  /// **'Invalid login credentials'**
  String get invalidLoginData;

  /// No description provided for @tooManyLoginAttempts.
  ///
  /// In en, this message translates to:
  /// **'Too many login attempts, please try again later'**
  String get tooManyLoginAttempts;

  /// No description provided for @noCurrentOrders.
  ///
  /// In en, this message translates to:
  /// **'No current orders'**
  String get noCurrentOrders;

  /// No description provided for @noPreviousOrders.
  ///
  /// In en, this message translates to:
  /// **'No previous orders'**
  String get noPreviousOrders;

  /// No description provided for @ourServiceOffers.
  ///
  /// In en, this message translates to:
  /// **'Available services'**
  String get ourServiceOffers;

  /// No description provided for @aboutUsInfo.
  ///
  /// In en, this message translates to:
  /// **'What you need to know about us'**
  String get aboutUsInfo;

  /// No description provided for @orderCancelledSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Order cancelled successfully'**
  String get orderCancelledSuccessfully;

  /// No description provided for @faq_title_warranty.
  ///
  /// In en, this message translates to:
  /// **'Warranty & Quality'**
  String get faq_title_warranty;

  /// No description provided for @faq_title_pricing.
  ///
  /// In en, this message translates to:
  /// **'Pricing & Fees'**
  String get faq_title_pricing;

  /// No description provided for @faq_title_booking.
  ///
  /// In en, this message translates to:
  /// **'Booking & Technicians'**
  String get faq_title_booking;

  /// No description provided for @serviceDetails.
  ///
  /// In en, this message translates to:
  /// **'Service Details'**
  String get serviceDetails;

  /// No description provided for @problemDetails.
  ///
  /// In en, this message translates to:
  /// **'Problem Details'**
  String get problemDetails;

  /// No description provided for @scheduleDate.
  ///
  /// In en, this message translates to:
  /// **'Service Execution Date'**
  String get scheduleDate;

  /// No description provided for @faq_q_warranty_duration.
  ///
  /// In en, this message translates to:
  /// **'What is the warranty period for services?'**
  String get faq_q_warranty_duration;

  /// No description provided for @faq_a_warranty_duration.
  ///
  /// In en, this message translates to:
  /// **'We provide a written warranty ranging from 30 days up to one full year depending on the service type. You can find the warranty duration in each service details inside the app.'**
  String get faq_a_warranty_duration;

  /// No description provided for @faq_q_warranty_coverage.
  ///
  /// In en, this message translates to:
  /// **'What does the quality warranty cover?'**
  String get faq_q_warranty_coverage;

  /// No description provided for @faq_a_warranty_coverage.
  ///
  /// In en, this message translates to:
  /// **'The warranty covers workmanship defects and issues caused by poor execution. If the same issue occurs again within the warranty period, it will be fixed free of charge.'**
  String get faq_a_warranty_coverage;

  /// No description provided for @faq_q_post_service_followup.
  ///
  /// In en, this message translates to:
  /// **'Is there a follow-up after the service is completed?'**
  String get faq_q_post_service_followup;

  /// No description provided for @faq_a_post_service_followup.
  ///
  /// In en, this message translates to:
  /// **'Yes, we contact you by phone within 24 hours after closing the request to ensure your satisfaction, resolve any remaining issues, and remind you of the warranty.'**
  String get faq_a_post_service_followup;

  /// No description provided for @faq_q_pricing_difference.
  ///
  /// In en, this message translates to:
  /// **'Why do service prices vary?'**
  String get faq_q_pricing_difference;

  /// No description provided for @faq_a_pricing_difference.
  ///
  /// In en, this message translates to:
  /// **'Prices vary based on the service type (scheduled, urgent, emergency) and the nature of the issue. Prices shown in the app are estimates and the final cost is confirmed after technician diagnosis.'**
  String get faq_a_pricing_difference;

  /// No description provided for @faq_q_emergency_fee.
  ///
  /// In en, this message translates to:
  /// **'What is the emergency service fee?'**
  String get faq_q_emergency_fee;

  /// No description provided for @faq_a_emergency_fee.
  ///
  /// In en, this message translates to:
  /// **'It is a fixed fee added to emergency requests (within 1–2 hours) to ensure immediate response and cover off-hours operational costs, guaranteeing the fastest possible technician arrival.'**
  String get faq_a_emergency_fee;

  /// No description provided for @faq_q_cost_confirmation.
  ///
  /// In en, this message translates to:
  /// **'How can I confirm the cost before work starts?'**
  String get faq_q_cost_confirmation;

  /// No description provided for @faq_a_cost_confirmation.
  ///
  /// In en, this message translates to:
  /// **'You receive a cost estimate after the initial diagnosis, and the technician will not start work without your explicit approval.'**
  String get faq_a_cost_confirmation;

  /// No description provided for @faq_q_video_call.
  ///
  /// In en, this message translates to:
  /// **'What is the benefit of a video call before the visit?'**
  String get faq_q_video_call;

  /// No description provided for @faq_a_video_call.
  ///
  /// In en, this message translates to:
  /// **'The video call allows the technician to assess the issue in advance and prepare tools and spare parts, reducing on-site time and improving diagnostic accuracy.'**
  String get faq_a_video_call;

  /// No description provided for @faq_q_trust_technician.
  ///
  /// In en, this message translates to:
  /// **'How can I trust the technician coming to my home?'**
  String get faq_q_trust_technician;

  /// No description provided for @faq_a_trust_technician.
  ///
  /// In en, this message translates to:
  /// **'All technicians are verified and registered. The technician’s name, photo, and contact details are shared before arrival, with live location tracking available.'**
  String get faq_a_trust_technician;

  /// No description provided for @faq_q_cancel_booking.
  ///
  /// In en, this message translates to:
  /// **'Can I cancel the request after confirmation?'**
  String get faq_q_cancel_booking;

  /// No description provided for @faq_a_cancel_booking.
  ///
  /// In en, this message translates to:
  /// **'Yes, you can cancel the request before a specified time prior to the visit without fees. Please review the cancellation policy inside the app.'**
  String get faq_a_cancel_booking;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @profileUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get profileUpdatedSuccessfully;

  /// No description provided for @logoutMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get logoutMessage;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @rating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get rating;

  /// No description provided for @areYouSureYouWantToCancelThisOrder.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to cancel this order?'**
  String get areYouSureYouWantToCancelThisOrder;

  /// No description provided for @noOrders.
  ///
  /// In en, this message translates to:
  /// **'No Orders Yet'**
  String get noOrders;

  /// No description provided for @noNotifications.
  ///
  /// In en, this message translates to:
  /// **'No Notifications Yet'**
  String get noNotifications;

  /// No description provided for @noServices.
  ///
  /// In en, this message translates to:
  /// **'No Services Available Yet'**
  String get noServices;

  /// No description provided for @accountDeletedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Account deleted successfully'**
  String get accountDeletedSuccessfully;

  /// No description provided for @areYouSureYouWantToDeleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your account?'**
  String get areYouSureYouWantToDeleteAccount;

  /// No description provided for @locationDetectingTitle.
  ///
  /// In en, this message translates to:
  /// **'Detecting your location'**
  String get locationDetectingTitle;

  /// No description provided for @locationDetectingDescription.
  ///
  /// In en, this message translates to:
  /// **'Please wait while we detect your location accurately.'**
  String get locationDetectingDescription;

  /// No description provided for @locationPermissionRequiredTitle.
  ///
  /// In en, this message translates to:
  /// **'Location Required'**
  String get locationPermissionRequiredTitle;

  /// No description provided for @locationPermissionRequiredDescription.
  ///
  /// In en, this message translates to:
  /// **'You need to allow location access to continue.'**
  String get locationPermissionRequiredDescription;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// No description provided for @locationLoadingInline.
  ///
  /// In en, this message translates to:
  /// **'Detecting your location…'**
  String get locationLoadingInline;

  /// No description provided for @locationDetectedFallback.
  ///
  /// In en, this message translates to:
  /// **'Your location has been detected based on your current position'**
  String get locationDetectedFallback;

  /// No description provided for @locationDescription.
  ///
  /// In en, this message translates to:
  /// **'Your location details'**
  String get locationDescription;

  /// No description provided for @locationDescriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Example: 3rd floor, near Al Noor pharmacy, building with blue gate'**
  String get locationDescriptionHint;

  /// No description provided for @yourLocation.
  ///
  /// In en, this message translates to:
  /// **'Your current location on map (optional)'**
  String get yourLocation;

  /// No description provided for @completeProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Complete Profile'**
  String get completeProfileTitle;

  /// No description provided for @phoneRequiredMessage.
  ///
  /// In en, this message translates to:
  /// **'Please enter your phone number to complete your account'**
  String get phoneRequiredMessage;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @useMyLocation.
  ///
  /// In en, this message translates to:
  /// **'Use my location'**
  String get useMyLocation;

  /// No description provided for @forgotPasswordDesc.
  ///
  /// In en, this message translates to:
  /// **'Enter your email and we’ll send you a reset link'**
  String get forgotPasswordDesc;

  /// No description provided for @sendResetLink.
  ///
  /// In en, this message translates to:
  /// **'Send reset link'**
  String get sendResetLink;

  /// No description provided for @backToLogin.
  ///
  /// In en, this message translates to:
  /// **'Back to login'**
  String get backToLogin;

  /// No description provided for @resetPasswordDesc.
  ///
  /// In en, this message translates to:
  /// **'Enter your new password'**
  String get resetPasswordDesc;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @savePassword.
  ///
  /// In en, this message translates to:
  /// **'Save Password'**
  String get savePassword;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password is too short'**
  String get passwordTooShort;

  /// No description provided for @resetLinkSent.
  ///
  /// In en, this message translates to:
  /// **'Reset password link has been sent to your email'**
  String get resetLinkSent;

  /// No description provided for @passwordChangedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Password changed successfully'**
  String get passwordChangedSuccessfully;

  /// No description provided for @locationHint.
  ///
  /// In en, this message translates to:
  /// **'Select your location between the options'**
  String get locationHint;

  /// No description provided for @videoCallRequestTitle.
  ///
  /// In en, this message translates to:
  /// **'Request a Video Call'**
  String get videoCallRequestTitle;

  /// No description provided for @videoCallRequestDescription.
  ///
  /// In en, this message translates to:
  /// **'You can request a video call to better explain the issue. The request will be sent to the app administration via WhatsApp to coordinate with you.'**
  String get videoCallRequestDescription;

  /// No description provided for @requestVideoCall.
  ///
  /// In en, this message translates to:
  /// **'Request Video Call'**
  String get requestVideoCall;

  /// No description provided for @continueAsGuest.
  ///
  /// In en, this message translates to:
  /// **'Continue as Guest'**
  String get continueAsGuest;

  /// No description provided for @loginToViewOrders.
  ///
  /// In en, this message translates to:
  /// **'Login to view your orders'**
  String get loginToViewOrders;

  /// No description provided for @loginToContinue.
  ///
  /// In en, this message translates to:
  /// **'Please login to view your current and previous orders'**
  String get loginToContinue;

  /// No description provided for @guestModeMessage.
  ///
  /// In en, this message translates to:
  /// **'You are using the app as a guest. Some settings are unavailable.'**
  String get guestModeMessage;

  /// No description provided for @guestActionNotAllowed.
  ///
  /// In en, this message translates to:
  /// **'Please login first to use this feature'**
  String get guestActionNotAllowed;

  /// No description provided for @loginRequired.
  ///
  /// In en, this message translates to:
  /// **'Login Required'**
  String get loginRequired;

  /// No description provided for @loginToCreateOrder.
  ///
  /// In en, this message translates to:
  /// **'Please login to create a new service request'**
  String get loginToCreateOrder;

  /// No description provided for @guest.
  ///
  /// In en, this message translates to:
  /// **'Guest'**
  String get guest;

  /// No description provided for @reviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Your opinion matters to us and helps improve your next experience'**
  String get reviewTitle;

  /// No description provided for @reviewSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Please rate honestly both the technician and the service'**
  String get reviewSubtitle;

  /// No description provided for @reviewWriteLabel.
  ///
  /// In en, this message translates to:
  /// **'Leave your feedback'**
  String get reviewWriteLabel;

  /// No description provided for @reviewHint.
  ///
  /// In en, this message translates to:
  /// **'Write your opinion about the technician and the service'**
  String get reviewHint;

  /// No description provided for @reviewSubmit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get reviewSubmit;

  /// No description provided for @alreadyReviewed.
  ///
  /// In en, this message translates to:
  /// **'You have already reviewed this order'**
  String get alreadyReviewed;

  /// No description provided for @spareParts.
  ///
  /// In en, this message translates to:
  /// **'Spare Parts'**
  String get spareParts;

  /// No description provided for @sparePartName.
  ///
  /// In en, this message translates to:
  /// **'Spare part name'**
  String get sparePartName;

  /// No description provided for @addSparePart.
  ///
  /// In en, this message translates to:
  /// **'Add spare part'**
  String get addSparePart;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Estimated price'**
  String get price;

  /// No description provided for @approvedPrice.
  ///
  /// In en, this message translates to:
  /// **'Approved price'**
  String get approvedPrice;

  /// No description provided for @quantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantity;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @deleteAccountAction.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccountAction;

  /// No description provided for @deleteAccountConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your account?'**
  String get deleteAccountConfirmMessage;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @customerReviews.
  ///
  /// In en, this message translates to:
  /// **'Customer Reviews'**
  String get customerReviews;

  /// No description provided for @reviewsCount.
  ///
  /// In en, this message translates to:
  /// **'reviews'**
  String get reviewsCount;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @approved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get approved;

  /// No description provided for @rejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get rejected;

  /// No description provided for @reports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get reports;

  /// No description provided for @totalProfitsThisWeek.
  ///
  /// In en, this message translates to:
  /// **'Total profits this week'**
  String get totalProfitsThisWeek;

  /// No description provided for @week.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get week;

  /// No description provided for @increaseFromLastWeek.
  ///
  /// In en, this message translates to:
  /// **'Increase from last week'**
  String get increaseFromLastWeek;

  /// No description provided for @dailyProfits.
  ///
  /// In en, this message translates to:
  /// **'Daily Profits'**
  String get dailyProfits;

  /// No description provided for @profitsByServiceType.
  ///
  /// In en, this message translates to:
  /// **'Profits by Service Type'**
  String get profitsByServiceType;

  /// No description provided for @attachedReport.
  ///
  /// In en, this message translates to:
  /// **'Attached Report'**
  String get attachedReport;

  /// No description provided for @serviceReport.
  ///
  /// In en, this message translates to:
  /// **'Service Report'**
  String get serviceReport;

  /// No description provided for @showMore.
  ///
  /// In en, this message translates to:
  /// **'show more'**
  String get showMore;

  /// No description provided for @thereIsNoResult.
  ///
  /// In en, this message translates to:
  /// **'There\'s no result'**
  String get thereIsNoResult;

  /// No description provided for @financialDetails.
  ///
  /// In en, this message translates to:
  /// **'Financial Details'**
  String get financialDetails;

  /// No description provided for @servicePrice.
  ///
  /// In en, this message translates to:
  /// **'Service Price'**
  String get servicePrice;

  /// No description provided for @companyCommission.
  ///
  /// In en, this message translates to:
  /// **'Company Commission'**
  String get companyCommission;

  /// No description provided for @netProfit.
  ///
  /// In en, this message translates to:
  /// **'Net Profit'**
  String get netProfit;

  /// No description provided for @reportDetails.
  ///
  /// In en, this message translates to:
  /// **'Report Details'**
  String get reportDetails;

  /// No description provided for @whatWasDone.
  ///
  /// In en, this message translates to:
  /// **'What was done'**
  String get whatWasDone;

  /// No description provided for @totalCost.
  ///
  /// In en, this message translates to:
  /// **'Total Cost'**
  String get totalCost;

  /// No description provided for @photosAfterExecution.
  ///
  /// In en, this message translates to:
  /// **'Photos after execution'**
  String get photosAfterExecution;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get done;

  /// No description provided for @purchased.
  ///
  /// In en, this message translates to:
  /// **'Purchased'**
  String get purchased;

  /// No description provided for @sparePartNameValidation.
  ///
  /// In en, this message translates to:
  /// **'Please enter spare part name'**
  String get sparePartNameValidation;

  /// No description provided for @descriptionValidation.
  ///
  /// In en, this message translates to:
  /// **'Please enter description'**
  String get descriptionValidation;

  /// No description provided for @quantityValidation.
  ///
  /// In en, this message translates to:
  /// **'Please enter quantity'**
  String get quantityValidation;

  /// No description provided for @printInvoice.
  ///
  /// In en, this message translates to:
  /// **'Print Invoice'**
  String get printInvoice;

  /// No description provided for @resetLinkSentTitle.
  ///
  /// In en, this message translates to:
  /// **'Message Sent'**
  String get resetLinkSentTitle;

  /// No description provided for @resendAfterSeconds.
  ///
  /// In en, this message translates to:
  /// **'Resend after {seconds} seconds'**
  String resendAfterSeconds(Object seconds);

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @contact_info_title.
  ///
  /// In en, this message translates to:
  /// **'Contact Information'**
  String get contact_info_title;

  /// No description provided for @contact_info_description.
  ///
  /// In en, this message translates to:
  /// **'We are available 24/7 to answer your inquiries'**
  String get contact_info_description;

  /// No description provided for @contact_location.
  ///
  /// In en, this message translates to:
  /// **'📍 Amman – Jordan'**
  String get contact_location;

  /// No description provided for @contact_whatsapp_title.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp'**
  String get contact_whatsapp_title;

  /// No description provided for @contact_whatsapp_number.
  ///
  /// In en, this message translates to:
  /// **'+962 781319003'**
  String get contact_whatsapp_number;

  /// No description provided for @contact_email_title.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get contact_email_title;

  /// No description provided for @contact_email_address.
  ///
  /// In en, this message translates to:
  /// **'meyar.alitqan@gmail.com'**
  String get contact_email_address;

  /// No description provided for @webHeroSubtitle.
  ///
  /// In en, this message translates to:
  /// **'High-quality home maintenance services delivered with professionalism and speed. Choose your service and leave the rest to us.'**
  String get webHeroSubtitle;

  /// No description provided for @exploreServices.
  ///
  /// In en, this message translates to:
  /// **'Browse Services'**
  String get exploreServices;

  /// No description provided for @aboutServicesGeneral.
  ///
  /// In en, this message translates to:
  /// **'General Maintenance'**
  String get aboutServicesGeneral;

  /// No description provided for @aboutServicesElectrical.
  ///
  /// In en, this message translates to:
  /// **'Electrical Works'**
  String get aboutServicesElectrical;

  /// No description provided for @aboutServicesPlumbing.
  ///
  /// In en, this message translates to:
  /// **'Plumbing Works'**
  String get aboutServicesPlumbing;

  /// No description provided for @aboutServicesCarpentry.
  ///
  /// In en, this message translates to:
  /// **'Carpentry & Wood Works'**
  String get aboutServicesCarpentry;

  /// No description provided for @aboutServicesPainting.
  ///
  /// In en, this message translates to:
  /// **'Painting & Finishing'**
  String get aboutServicesPainting;

  /// No description provided for @aboutServicesInterior.
  ///
  /// In en, this message translates to:
  /// **'Interior Fit-Out Support'**
  String get aboutServicesInterior;

  /// No description provided for @aboutUs.
  ///
  /// In en, this message translates to:
  /// **'About Meyar Al-Itqan'**
  String get aboutUs;

  /// No description provided for @services.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get services;

  /// No description provided for @howItWorks.
  ///
  /// In en, this message translates to:
  /// **'How It Works'**
  String get howItWorks;

  /// No description provided for @aboutLabel.
  ///
  /// In en, this message translates to:
  /// **'ENGINEERING & MAINTENANCE BRIEF'**
  String get aboutLabel;

  /// No description provided for @aboutTitle.
  ///
  /// In en, this message translates to:
  /// **'Meyar Al-Itqan\nMaintenance & Interior Design'**
  String get aboutTitle;

  /// No description provided for @aboutDescription.
  ///
  /// In en, this message translates to:
  /// **'Meyar Al-Itqan is a maintenance and interior works company operating with a structured engineering-based approach focused on execution accuracy, site discipline, and clear scope definition.'**
  String get aboutDescription;

  /// No description provided for @aboutScopeTitle.
  ///
  /// In en, this message translates to:
  /// **'Company Scope'**
  String get aboutScopeTitle;

  /// No description provided for @aboutScopeDescription.
  ///
  /// In en, this message translates to:
  /// **'We provide maintenance and interior works for residential, commercial, and office environments with emphasis on durability, compliance, and clean handover.'**
  String get aboutScopeDescription;

  /// No description provided for @aboutMethodologyTitle.
  ///
  /// In en, this message translates to:
  /// **'Execution Methodology'**
  String get aboutMethodologyTitle;

  /// No description provided for @aboutMethodologyDescription.
  ///
  /// In en, this message translates to:
  /// **'Site inspection, scope confirmation, clear execution planning, professional on-site work, followed by quality checks and clean handover.'**
  String get aboutMethodologyDescription;

  /// No description provided for @aboutQualityTitle.
  ///
  /// In en, this message translates to:
  /// **'Quality & Control'**
  String get aboutQualityTitle;

  /// No description provided for @aboutQualityDescription.
  ///
  /// In en, this message translates to:
  /// **'All works are executed following clear technical procedures with continuous monitoring to ensure quality, safety, and client satisfaction.'**
  String get aboutQualityDescription;

  /// No description provided for @aboutServicesTitle.
  ///
  /// In en, this message translates to:
  /// **'Our Services'**
  String get aboutServicesTitle;

  /// No description provided for @serviceGeneral.
  ///
  /// In en, this message translates to:
  /// **'General Maintenance'**
  String get serviceGeneral;

  /// No description provided for @serviceElectrical.
  ///
  /// In en, this message translates to:
  /// **'Electrical Works'**
  String get serviceElectrical;

  /// No description provided for @servicePlumbing.
  ///
  /// In en, this message translates to:
  /// **'Plumbing Works'**
  String get servicePlumbing;

  /// No description provided for @serviceCarpentry.
  ///
  /// In en, this message translates to:
  /// **'Carpentry & Wood Works'**
  String get serviceCarpentry;

  /// No description provided for @servicePainting.
  ///
  /// In en, this message translates to:
  /// **'Painting & Finishing'**
  String get servicePainting;

  /// No description provided for @serviceInterior.
  ///
  /// In en, this message translates to:
  /// **'Interior Fit-Out'**
  String get serviceInterior;

  /// No description provided for @servicePreventive.
  ///
  /// In en, this message translates to:
  /// **'Corrective & Preventive Maintenance'**
  String get servicePreventive;

  /// No description provided for @aboutContactButton.
  ///
  /// In en, this message translates to:
  /// **'Contact Us via WhatsApp'**
  String get aboutContactButton;

  /// No description provided for @aboutWhatsappMessage.
  ///
  /// In en, this message translates to:
  /// **'Hello, I would like to inquire about your maintenance services.'**
  String get aboutWhatsappMessage;

  /// No description provided for @loginOrRegister.
  ///
  /// In en, this message translates to:
  /// **'Login / Sign Up'**
  String get loginOrRegister;

  /// No description provided for @storeGetItOn.
  ///
  /// In en, this message translates to:
  /// **'Get it on'**
  String get storeGetItOn;

  /// No description provided for @storeGooglePlay.
  ///
  /// In en, this message translates to:
  /// **'Google Play'**
  String get storeGooglePlay;

  /// No description provided for @storeDownloadOn.
  ///
  /// In en, this message translates to:
  /// **'Download on the'**
  String get storeDownloadOn;

  /// No description provided for @storeAppStore.
  ///
  /// In en, this message translates to:
  /// **'App Store'**
  String get storeAppStore;

  /// No description provided for @hero_title.
  ///
  /// In en, this message translates to:
  /// **'Professional maintenance services\nwith Miyar Al-Itqan'**
  String get hero_title;

  /// No description provided for @hero_description.
  ///
  /// In en, this message translates to:
  /// **'Miyar Al-Itqan is a smart application that provides professional home maintenance services with ease and reliability.\n\nRequest certified technicians, track your service step by step, and enjoy fast, accurate service at competitive prices.\n\nStart your experience now and enjoy maintenance with high standards and trusted quality.'**
  String get hero_description;

  /// No description provided for @contact_title_small.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contact_title_small;

  /// No description provided for @contact_title_main.
  ///
  /// In en, this message translates to:
  /// **'Get in touch for any inquiry'**
  String get contact_title_main;

  /// No description provided for @contact_description.
  ///
  /// In en, this message translates to:
  /// **'We are here to help you and answer all your questions about our services. Feel free to contact us.'**
  String get contact_description;

  /// No description provided for @contact_name_hint.
  ///
  /// In en, this message translates to:
  /// **'Your name'**
  String get contact_name_hint;

  /// No description provided for @contact_whatsapp_hint.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp number'**
  String get contact_whatsapp_hint;

  /// No description provided for @contact_service_hint.
  ///
  /// In en, this message translates to:
  /// **'Select service'**
  String get contact_service_hint;

  /// No description provided for @contact_message_hint.
  ///
  /// In en, this message translates to:
  /// **'Your message'**
  String get contact_message_hint;

  /// No description provided for @contact_send_button.
  ///
  /// In en, this message translates to:
  /// **'Send Message'**
  String get contact_send_button;

  /// No description provided for @maintenanceBannerTitle.
  ///
  /// In en, this message translates to:
  /// **'Quality work.. comfort at home'**
  String get maintenanceBannerTitle;

  /// No description provided for @maintenanceBannerDescription.
  ///
  /// In en, this message translates to:
  /// **'Request the best certified technicians\nfor your home maintenance, guaranteed by Meayar Al-Itqan.'**
  String get maintenanceBannerDescription;

  /// No description provided for @bookNow.
  ///
  /// In en, this message translates to:
  /// **'Book Now'**
  String get bookNow;

  /// No description provided for @contact_email.
  ///
  /// In en, this message translates to:
  /// **'Email Us'**
  String get contact_email;

  /// No description provided for @contact_phone_title.
  ///
  /// In en, this message translates to:
  /// **'Call Us'**
  String get contact_phone_title;

  /// No description provided for @contact_address_title.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get contact_address_title;

  /// No description provided for @contact_address_value.
  ///
  /// In en, this message translates to:
  /// **'Tanta, Egypt'**
  String get contact_address_value;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
