import 'package:flutter/material.dart';

import '../../../../../core/helper/responsive_size.dart';
import '../../../../../l10n/app_localizations.dart';

class CancelOrderButton extends StatelessWidget {
  final VoidCallback onTap;

  const CancelOrderButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: RS.size(context, 420),
        ),
        child: InkWell(
          onTap: onTap,
          child: Container(
            height: RS.size(context, 40),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(RS.radius(context, 10)),
              border: Border.all(color: Colors.red, width: RS.size(context, 2)),
            ),
            padding: EdgeInsets.all(RS.size(context, 8)),
            child: Center(
              child: Text(
                AppLocalizations.of(context)!.cancelOrder,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: RS.font(context, 14),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
