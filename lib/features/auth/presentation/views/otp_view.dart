import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meayar_alitqan/features/auth/presentation/widgets/login_header.dart';

import '../../../../config/routes/routes_manager.dart';
import '../../../../core/cubit/app_user/app_user_cubit.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/helper/responsive_size.dart';
import '../../../../core/utils/colors_manager.dart';
import '../../../../l10n/app_localizations.dart';
import '../manager/register_view_model/register_view_model_states.dart';
import '../manager/verify_otp_view_model/verify_otp_view_model.dart';
import '../manager/verify_otp_view_model/verify_otp_view_model_states.dart';

class OtpView extends StatefulWidget {
  final String email;

  const OtpView({super.key, required this.email});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  late final List<TextEditingController> _otpControllers;
  late final List<FocusNode> _focusNodes;

  int _resendTimeout = 60;
  Timer? _resendTimer;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _startResendTimer();
  }

  void _initializeControllers() {
    _otpControllers = List.generate(6, (_) => TextEditingController());
    _focusNodes = List.generate(6, (_) => FocusNode());

    for (int i = 0; i < 5; i++) {
      _otpControllers[i].addListener(() {
        if (_otpControllers[i].text.length == 1) {
          _focusNodes[i + 1].requestFocus();
        }
      });
    }
  }

  void _startResendTimer() {
    _canResend = false;
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendTimeout > 0) {
        setState(() => _resendTimeout--);
      } else {
        setState(() => _canResend = true);
        timer.cancel();
      }
    });
  }

  String get _enteredOtp => _otpControllers.map((c) => c.text).join();

  bool get _isOtpComplete => _enteredOtp.length == 6;

  void _clearOtp() {
    for (var controller in _otpControllers) {
      controller.clear();
    }
    _focusNodes[0].requestFocus();
  }

  @override
  void dispose() {
    _resendTimer?.cancel();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
          final loc = AppLocalizations.of(context)!;

    return BlocConsumer<VerifyOtpViewModel, VerifyOtpStates>(
      listener: (context, state) async {
        if (state is VerifyOtpSuccess) {
          context.read<AppUserCubit>().setUser(state.profile);

          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesManager.homeView,
            (_) => false,
          );
        }

        if (state is VerifyOtpError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
          _clearOtp();
        }
      },
      builder: (context, state) {
        final isLoading = state is RegisterViewModelStatesLoading;

        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ColorsManager.gradientStart,
                  ColorsManager.gradientEnd,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  const AuthHeader(),

                  Image.asset(AssetsManager.logo, height: RS.size(context, 100)),
                              SizedBox(height: RS.size(context, 120)),

                  Expanded(
                    child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: RS.size(context, 24),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(height: RS.size(context, 32)),
                      
                              Text(
                                "ادخال الرمز التعريفي",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      fontSize: RS.font(context, 20),
                                      color: ColorsManager.primaryColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                      
                              SizedBox(height: RS.size(context, 8)),
                      
                              Text(
                                "أدخل الرمز الذي وصلك على بريدك الإلكتروني",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      fontSize: RS.font(context, 13),
                                      color: ColorsManager.secondaryTextDarkColor,
                                    ),
                              ),
                      
                              SizedBox(height: RS.size(context, 32)),
                      
                              /// OTP Fields
                              Directionality(
                                textDirection: TextDirection.ltr,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: List.generate(
                                    6,
                                    (index) => _buildOtpField(index, isLoading),
                                  ),
                                ),
                              ),
                      
                              SizedBox(height: RS.size(context, 20)),
                      
                              /// Resend
                              _canResend
                                  ? GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _resendTimeout = 60;
                                          _canResend = false;
                                          _startResendTimer();
                                        });
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text("تم إعادة إرسال الرمز بنجاح!"),
                                            backgroundColor: Colors.green,
                                          ),
                                        );
                                      },
                                      child: Text(
                                        "اعد ارسال الرمز التعريفي؟",
                                        style: TextStyle(
                                          color: ColorsManager.primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: RS.font(context, 14),
                                        ),
                                      ),
                                    )
                                  : Text(
                                      "اعد ارسال الرمز التعريفي بعد $_resendTimeout ثانية",
                                      style: TextStyle(
                                        color: ColorsManager.secondaryTextDarkColor,
                                        fontSize: RS.font(context, 13),
                                      ),
                                    ),
                      
                              SizedBox(height: RS.size(context, 32)),
                      
                              /// Confirm Button
                              SizedBox(
                                width: double.infinity,
                                height: RS.size(context, 56),
                                child: ElevatedButton(
                                  onPressed: (_isOtpComplete && !isLoading)
                                      ? () {
                                          context
                                              .read<VerifyOtpViewModel>()
                                              .verifyOtp(
                                                email: widget.email,
                                                otp: _enteredOtp,
                                              );
                                        }
                                      : null,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorsManager.primaryColor,
                                    disabledBackgroundColor:
                                        ColorsManager.primaryColor.withOpacity(0.5),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                  ),
                                  child: isLoading
                                      ? const SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2.5,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              Colors.white,
                                            ),
                                          ),
                                        )
                                      : Text(
                                          "تأكيد",
                                          style: TextStyle(
                                            fontSize: RS.font(context, 16),
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                ),
                              ),
                      
                              SizedBox(height: RS.size(context, 24)),
                      
                              /// Continue as guest
                              GestureDetector(
                                onTap: () {
                                  context.read<AppUserCubit>().setGuest();
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    RoutesManager.customerHome,
                                    (_) => false,
                                  );
                                },
                                child: Text(
                                  loc.continueAsGuest,
                                  style: TextStyle(
                                    color: ColorsManager.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: RS.font(context, 13),
                                  ),
                                ),
                              ),
                      
                              SizedBox(height: RS.size(context, 32)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildOtpField(int index, bool isLoading) {
    return SizedBox(
      width: RS.size(context, 45),
      height: RS.size(context, 55),
      child: TextField(
        controller: _otpControllers[index],
        focusNode: _focusNodes[index],
        enabled: !isLoading,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: TextStyle(
          fontSize: RS.font(context, 20),
          fontWeight: FontWeight.bold,
          color: ColorsManager.primaryTextDarkColor,
        ),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: ColorsManager.lightGrey,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: ColorsManager.primaryColor,
              width: 2,
            ),
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < 5) {
            _focusNodes[index + 1].requestFocus();
          } else if (value.isEmpty && index > 0) {
            _focusNodes[index - 1].requestFocus();
          }
          setState(() {});
        },
      ),
    );
  }
}