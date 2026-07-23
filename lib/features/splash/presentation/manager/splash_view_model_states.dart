abstract class SplashViewModelStates {}

class SplashInitial extends SplashViewModelStates {}

class SplashError extends SplashViewModelStates {
  final String message;

  SplashError(this.message);
}

class SplashGoToLogin extends SplashViewModelStates {}

class SplashGoToCustomerHome extends SplashViewModelStates {}

class SplashGoToTechnicianHome extends SplashViewModelStates {}

class SplashGoToOnboarding extends SplashViewModelStates {}
