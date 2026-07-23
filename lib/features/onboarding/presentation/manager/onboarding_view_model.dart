import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/core/cache/shared_preferences.dart';
@injectable
class OnboardingViewModel extends Cubit<int> {
  OnboardingViewModel() : super(0);

  final PageController pageController = PageController();

  void onPageChanged(int index) {
    emit(index);
  }

  void nextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void previousPage() {
    pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  Future<void> finishOnboarding() async {
    await SharedPrefHelper.setBool("onboarding_skipped", true);
  }
}
