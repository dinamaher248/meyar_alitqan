import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/helper/responsive_size.dart';
import '../../../../core/utils/colors_manager.dart';

class SubServiceItemCard extends StatelessWidget {
  final String title;
  final String image;
  final bool isSelected;
  final VoidCallback onTap;

  const SubServiceItemCard({
    super.key,
    required this.title,
    required this.image,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: RS.size(context, 12),
          vertical: RS.size(context, 16),
        ),
        decoration: BoxDecoration(
          color: ColorsManager.white,
          borderRadius: BorderRadius.circular(RS.radius(context, 10)),
          border: Border.all(
            color: isSelected ? ColorsManager.primaryColor : ColorsManager.grey,
            width: RS.size(context, 2),
          ),
        ),
        child: Row(
          children: [
            _IconCircle(image: image,title: title),
            SizedBox(width: RS.size(context, 16)),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: RS.font(context, 16),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _SelectionIndicator(isSelected: isSelected),
          ],
        ),
      ),
    );
  }
}

class _IconCircle extends StatelessWidget {
  final String image;
  final String title;

  const _IconCircle({required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(RS.size(context, 8)),
      decoration: BoxDecoration(
        color: ColorsManager.grey.withOpacity(0.2),
        shape: BoxShape.circle,
        border: Border.all(color: ColorsManager.grey),
      ),
      child: CachedNetworkImage(
        imageUrl: image,
        width: RS.size(context, 24),
        height: RS.size(context, 24),
        placeholder: (context, url) =>
            const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => Center(
          child: Text(
            title[0],
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: RS.font(context, 16),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class _SelectionIndicator extends StatelessWidget {
  final bool isSelected;

  const _SelectionIndicator({required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: RS.size(context, 22),
      height: RS.size(context, 22),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? ColorsManager.primaryColor : ColorsManager.grey,
          width: RS.size(context, 2),
        ),
      ),
      child: isSelected
          ? Center(
              child: Container(
                width: RS.size(context, 10),
                height: RS.size(context, 10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorsManager.primaryColor,
                ),
              ),
            )
          : null,
    );
  }
}
