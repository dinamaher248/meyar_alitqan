import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/helper/responsive_size.dart';
import '../../../../../core/utils/assets_manager.dart';
import '../../../../../l10n/app_localizations.dart';


class RatingWidget extends StatelessWidget {
  final int rating;  

  const RatingWidget({
    super.key,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              AssetsManager.star,
              width: RS.size(context, 14),
              height: RS.size(context, 14),
            ),
            SizedBox(width: RS.size(context, 4)),
            Text(
              loc.rating,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: RS.font(context, 13),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: RS.size(context, 4)),
        Row(
          children: List.generate(
            rating,
                (_) => Padding(
              padding: EdgeInsets.only(right: RS.size(context, 2)),
              child: SvgPicture.asset(
                AssetsManager.star,
                width: RS.size(context, 12),
                height: RS.size(context, 12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
