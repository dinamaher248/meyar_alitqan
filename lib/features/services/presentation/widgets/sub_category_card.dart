import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../core/helper/responsive_size.dart';
import '../../../../core/utils/colors_manager.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final String image;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: kIsWeb
          ? _WebCategoryCard(image: image, title: title)
          : _MobileCategoryCard(image: image, title: title),
    );
  }
}

/// ===================== MOBILE =====================
class _MobileCategoryCard extends StatelessWidget {
  const _MobileCategoryCard({
    required this.image,
    required this.title,
  });

  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(RS.radius(context, 10)),
        border: Border.all(
          color: ColorsManager.grey,
          width: 1,
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: RS.size(context, 12),
        horizontal: RS.size(context, 8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: RS.size(context, 32),
            height: RS.size(context, 32),
            child: CachedNetworkImage(
              imageUrl: image,
              fit: BoxFit.contain,
              placeholder: (_, __) => const Center(
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              errorWidget: (_, __, ___) => Center(
                child: Text(
                  title.isNotEmpty ? title[0] : '?',
                  style: TextStyle(
                    fontSize: RS.font(context, 18),
                    fontWeight: FontWeight.bold,
                    color: ColorsManager.primaryColor,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: RS.size(context, 8)),

          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: RS.font(context, 13),
              color: ColorsManager.primaryTextDarkColor,
            ),
          ),
        ],
      ),
    );
  }
}

/// ===================== WEB WITH HOVER =====================
class _WebCategoryCard extends StatefulWidget {
  const _WebCategoryCard({
    required this.image,
    required this.title,
  });

  final String image;
  final String title;

  @override
  State<_WebCategoryCard> createState() => _WebCategoryCardState();
}

class _WebCategoryCardState extends State<_WebCategoryCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(
          0,
          _hovered ? -10 : 0,
          0,
        ),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: _hovered
                ? const [Color(0xFF7A4EE0), Color(0xFF9F7BFF)]
                : const [Color(0xFF2D0B52), Color(0xFF7A4EE0)],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(_hovered ? 0.25 : 0.15),
              blurRadius: _hovered ? 28 : 16,
              offset: Offset(0, _hovered ? 18 : 10),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _hovered
                    ? const Color(0xFFFFC89B)
                    : const Color(0xFFFFA36C),
              ),
              child: Center(
                child: CachedNetworkImage(
                  imageUrl: widget.image,
                  width: 34,
                  height: 34,
                  color: Colors.black,
                  errorWidget: (_, __, ___) => const Icon(
                    Icons.build,
                    size: 30,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              widget.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}