import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/helper/responsive_size.dart';
import '../../../../core/utils/colors_manager.dart';
import '../../domain/entities/service_offer_entity.dart';

class ServiceOfferCard extends StatelessWidget {
   ServiceOfferCard({
    super.key,
    required this.offer,
    required this.onTap,
    required this.onBookNow,
    this.isOffer,
  });

  final ServiceOfferEntity offer;
  final VoidCallback onTap;
  final VoidCallback onBookNow;
   bool? isOffer = false;

  @override
  Widget build(BuildContext context) {
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
                          "بواسطع ${offer.satisfiedCustomersCount} عميل راضي",
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
                 isOffer==true? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       ElevatedButton(
                        onPressed: onBookNow,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsManager.primaryColor,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: RS.size(context, 14),
                            vertical: RS.size(context, 8),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(RS.radius(context, 8)),
                          ),
                        ),
                        child: Text("احجز الان", style: TextStyle(fontSize: RS.font(context, 14),fontWeight: FontWeight.w500)),
                      ),
                      Text(
                        offer.price != null
                            ? "${offer.price!.toStringAsFixed(0)} دينار"
                            : "0",
                        style: TextStyle(
                          fontSize: RS.font(context, 16),
                          fontWeight: FontWeight.w500,
                          color: ColorsManager.secondaryColor,
                        ),
                      ),
                     
                    ],
                  ):SizedBox.shrink(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}