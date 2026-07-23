import 'package:flutter/material.dart';

import '../../../../core/helper/responsive_size.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../l10n/app_localizations.dart';
import 'info_row.dart';

class ServiceDetails extends StatelessWidget {
  final String title;
  final String numberOfPeople;
  final String averageRating;

  const ServiceDetails({super.key, 
    required this.title,
    required this.numberOfPeople,
    required this.averageRating,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: RS.font(context, 16),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: RS.size(context, 6)),
        InfoTextRow(
          icon: AssetsManager.people,
          title:  AppLocalizations.of(context)!.numberOfCustomers,
          value: numberOfPeople,
        ),
        SizedBox(height: RS.size(context, 6)),
        RatingRow(
          icon: AssetsManager.star,
          rating: averageRating,
        ),
      ],
    );

  }
}
