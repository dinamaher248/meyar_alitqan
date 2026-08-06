import 'package:flutter/material.dart';

import '../../../../../core/helper/responsive_size.dart';
import '../../../../../l10n/app_localizations.dart';

class CancelOrderButton extends StatelessWidget {
  final VoidCallback onTap;

  const CancelOrderButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xffE0442A),
          padding: EdgeInsets.symmetric(vertical: RS.size(context, 10)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(RS.radius(context, 10)),
          ),
        ),
        child: Text(
          AppLocalizations.of(context)!.cancelOrder,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: RS.font(context, 13),
              ),
        ),
      ),
    );
  }
}