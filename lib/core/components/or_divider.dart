import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../helper/responsive_size.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(thickness: 1, color: Colors.grey)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: RS.size(context, 17)),
          child: Text(
            AppLocalizations.of(context)!.or,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: RS.font(context, 16),
              fontWeight: FontWeight.bold,
              color: Colors.grey,

            ),
          ),
        ),
        const Expanded(child: Divider(thickness: 1, color: Colors.grey)),
      ],
    );
  }
}
