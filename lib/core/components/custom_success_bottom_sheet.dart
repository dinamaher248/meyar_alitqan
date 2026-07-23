import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meayar_alitqan/core/components/custom_button.dart';
import 'package:meayar_alitqan/core/helper/responsive_size.dart';
import 'package:meayar_alitqan/core/utils/assets_manager.dart';
import 'package:meayar_alitqan/l10n/app_localizations.dart';

void CustomSuccessBottomSheet({
  required BuildContext context,
  required AppLocalizations t,
  String? description,
  String? title,
  String? buttonText,
  VoidCallback? onPressed,
  String? image,
}) {
  showModalBottomSheet(
    context: context,
    isDismissible: false,
    enableDrag: false,
    builder: (_) => Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            image ?? AssetsManager.done,
            width: 60,
            height: 60,
            color: Colors.green,
          ),
          const SizedBox(height: 16),
          Text(
            title ?? t.requestSentTitle,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: RS.font(context, 16),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description ?? t.requestSentDescription,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontSize: RS.font(context, 14)),
          ),
          const SizedBox(height: 24),
          CustomButton(
            text: buttonText ?? t.goToHome,
            onPressed: () {
              Navigator.pop(context);
              Navigator.popUntil(context, (r) => r.isFirst);
            },
          ),
        ],
      ),
    ),
  );
}
