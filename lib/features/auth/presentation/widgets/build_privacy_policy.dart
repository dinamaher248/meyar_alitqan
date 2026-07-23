import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../core/helper/responsive_size.dart';
import '../../../../core/utils/colors_manager.dart';
import '../../../../l10n/app_localizations.dart';

class PrivacyPolicyWithCheck extends FormField<bool> {
  PrivacyPolicyWithCheck({
    super.key,
    required BuildContext context,
    void Function(bool)? onPrivacyPolicyTap,
    void Function(bool)? onTermsTap,
  }) : super(
         initialValue: false,
         validator: (value) {
           if (value != true) {
             return AppLocalizations.of(context)!.mustAcceptTerms;
           }
           return null;
         },
         builder: (state) {
           final context = state.context;

           return Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Row(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   Checkbox(
                     value: state.value ?? false,
                     activeColor: ColorsManager.primaryColor,
                     materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                     side: BorderSide(
                       color: state.hasError ? Colors.red : Colors.grey,
                       width: 1.5,
                     ),
                     onChanged: (value) {
                       state.didChange(value);
                     },
                   ),
                   const SizedBox(width: 8),

                   /// Text
                   Expanded(
                     child: Text.rich(
                       TextSpan(
                         children: [
                           TextSpan(
                             text: AppLocalizations.of(
                               context,
                             )!.privacyPolicyAgreement,
                             style: TextStyle(
                               fontSize: RS.font(context, 14),
                               fontWeight: FontWeight.w500,
                               color: ColorsManager.black,
                             ),
                           ),

                           /// Privacy Policy
                           TextSpan(
                             text: AppLocalizations.of(context)!.privacyPolicy,
                             style: TextStyle(
                               fontSize: RS.font(context, 14),
                               fontWeight: FontWeight.w600,
                               color: ColorsManager.primaryColor,
                             ),
                             recognizer: TapGestureRecognizer()
                               ..onTap = () {
                                 onPrivacyPolicyTap?.call(state.value ?? false);
                               },
                           ),

                           TextSpan(
                             text: AppLocalizations.of(context)!.termsAgreement,
                             style: TextStyle(
                               fontSize: RS.font(context, 14),
                               fontWeight: FontWeight.w500,
                               color: ColorsManager.black,
                             ),
                           ),

                           /// Terms of Use
                           TextSpan(
                             text: AppLocalizations.of(context)!.termsOfUse,
                             style: TextStyle(
                               fontSize: RS.font(context, 14),
                               fontWeight: FontWeight.w600,
                               color: ColorsManager.primaryColor,
                             ),
                             recognizer: TapGestureRecognizer()
                               ..onTap = () {
                                 onTermsTap?.call(state.value ?? false);
                               },
                           ),
                         ],
                       ),
                     ),
                   ),
                 ],
               ),

               /// Error
               if (state.hasError)
                 Padding(
                   padding: const EdgeInsets.only(top: 6, left: 12),
                   child: Text(
                     state.errorText!,
                     style: TextStyle(
                       color: Colors.red,
                       fontSize: RS.font(context, 12),
                       fontWeight: FontWeight.w500,
                     ),
                   ),
                 ),
             ],
           );
         },
       );
}
