import 'package:flutter/material.dart';
import 'package:meayar_alitqan/features/orders/customer/presentation/widgets/rating_widget.dart';

import '../../../../../core/helper/responsive_size.dart';
import '../../../../../core/utils/assets_manager.dart' show AssetsManager;
import '../../../../../l10n/app_localizations.dart';

class OrderTechnicianSection extends StatelessWidget {
  const OrderTechnicianSection({
    super.key,
    required this.technicianName,
    required this.technicianAvatar,
    required this.rating,
    required this.onTap
  });

  final String technicianName;
  final String? technicianAvatar;
  final int rating;
  final VoidCallback onTap ;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          AppLocalizations.of(context)!.serviceProvider,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: RS.font(context, 14),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: RS.size(context, 12)),
        Row(
          children: [
            CircleAvatar(
              radius: RS.radius(context, 20),
              backgroundImage: technicianAvatar != null
                  ? NetworkImage(technicianAvatar!)
                  :  AssetImage(AssetsManager.userAvatar),
            ),
            SizedBox(width: RS.size(context, 10)),
            Text(
              technicianName,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: RS.font(context, 14),
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            GestureDetector(
                onTap: onTap,
                child: RatingWidget(rating: rating)),
          ],
        ),
      ],
    );
  }
}
