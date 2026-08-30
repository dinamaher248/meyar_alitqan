import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/helper/responsive_size.dart';
import '../../../../core/utils/colors_manager.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/service_offer_entity.dart';

class ServiceOfferCard extends StatelessWidget {
  const ServiceOfferCard({
    super.key,
    required this.offer,
    required this.onTap,
    required this.onBookNow,
    this.isOffer = false,
  });

  final ServiceOfferEntity offer;
  final VoidCallback onTap;
  final VoidCallback onBookNow;
  final bool isOffer;

  @override
  Widget build(BuildContext context) {
        final loc = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(RS.radius(context, 12)),
          border: Border.all(color: ColorsManager.grey, width: 1),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisSize: MainAxisSize.min, // الكارت ياخد بالظبط ارتفاع محتواه، مش أكتر
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 16 / 11,
              child: CachedNetworkImage(
                imageUrl: offer.imageUrl,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(color: Colors.grey.shade100),
                errorWidget: (_, __, ___) => Container(
                  color: Colors.grey.shade100,
                  child: const Icon(Icons.image_not_supported_outlined),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(RS.size(context, 10)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    offer.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: RS.font(context, 16),
                          color: ColorsManager.primaryTextDarkColor,
                        ),
                  ),
                  SizedBox(height: RS.size(context, 4)),
                  Row(
                    children: [
                      Text(
                        offer.rating.toStringAsFixed(1),
                        style: TextStyle(
                          fontSize: RS.font(context, 12),
                          fontWeight: FontWeight.w500,
                          color: ColorsManager.secondaryTextDarkColor,
                        ),
                      ),
                      SizedBox(width: RS.size(context, 4)),
                      Icon(Icons.star, color: Colors.amber, size: RS.size(context, 15)),
                      SizedBox(width: RS.size(context, 4)),
                      Expanded(
                        child: Text(
                          "${loc.by} ${offer.satisfiedCustomersCount} ${loc.satisfiedCustomers}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: RS.font(context, 11),
                            color: ColorsManager.secondaryTextDarkColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: RS.size(context, 10)),
                  isOffer == true
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerLeft,
                                child: ElevatedButton(
                                  onPressed: onBookNow,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorsManager.primaryColor,
                                    foregroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: RS.size(context, 14),
                                      vertical: RS.size(context, 8),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(RS.radius(context, 8)),
                                    ),
                                  ),
                                  child: Text(
                                    loc.bookNow,
                                    style: TextStyle(
                                      fontSize: RS.font(context, 14),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: RS.size(context, 8)),
                            Flexible(
                              child: Text(
                                offer.price != null
                                    ? "${offer.price!.toStringAsFixed(0)} ${loc.currencyDinar}"
                                    : "0",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontSize: RS.font(context, 16),
                                  fontWeight: FontWeight.w500,
                                  color: ColorsManager.secondaryColor,
                                ),
                              ),
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}