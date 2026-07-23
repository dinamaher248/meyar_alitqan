import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/helper/responsive_size.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/colors_manager.dart';
import '../../../../l10n/app_localizations.dart';
class InfoTextRow extends StatelessWidget {
  final String icon;
  final String title;
  final String value;

  const InfoTextRow({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyMedium?.copyWith(
      fontSize: RS.font(context, 13),
      color: ColorsManager.black.withOpacity(0.6),
      fontWeight: FontWeight.bold,
    );

    return Row(
      children: [
        SvgPicture.asset(icon, width: RS.size(context, 10)),
        SizedBox(width: RS.size(context, 6)),
        Text('$title: ', style: style?.copyWith(fontWeight: FontWeight.bold)),
        Text(value, style: style),
      ],
    );
  }
}
class RatingRow extends StatelessWidget {
  final String icon;
  final String rating;

  const RatingRow({
    super.key,
    required this.icon,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyMedium?.copyWith(
      fontSize: RS.font(context, 13),
      color: ColorsManager.black.withOpacity(0.6),
      fontWeight: FontWeight.bold,
    );

    return Row(
      children: [
        SvgPicture.asset(icon, width: RS.size(context, 10)),
        SizedBox(width: RS.size(context, 6)),
        Text( "${AppLocalizations.of(context)!.averageRating}: ", style: style?.copyWith(fontWeight: FontWeight.bold)),
        Text('($rating)', style: style),
        SizedBox(width: RS.size(context, 4)),
        SvgPicture.asset(
          AssetsManager.star,
          width: RS.size(context, 10),
          height: RS.size(context, 10),
        ),
      ],
    );
  }
}
