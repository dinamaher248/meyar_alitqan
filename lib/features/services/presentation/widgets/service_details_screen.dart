import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meayar_alitqan/core/utils/assets_manager.dart';

import '../../../../core/helper/responsive_size.dart';
import '../../../../core/utils/colors_manager.dart';
import '../../../../l10n/app_localizations.dart';

/// Accent color used for stars / check icons in this screen.
/// Move this into ColorsManager if you already have a matching brand color.
const Color _kAccentOrange = Color(0xFFFFA824);
const Color _kReviewCardBg = Color(0xFFF6F7FB);
const Color _kSoftShadow = Color(0x14000000);

/// ---------------------------------------------------------------------
/// MODELS
/// ---------------------------------------------------------------------
class ServiceFeature {
  final String text;
  const ServiceFeature(this.text);
}

class ServiceReview {
  final String reviewerName;
  final String date;
  final String reviewText;
  final int starsCount;
  final String avatarInitials;

  const ServiceReview({
    required this.reviewerName,
    required this.date,
    required this.reviewText,
    required this.starsCount,
    required this.avatarInitials,
  });
}

/// ---------------------------------------------------------------------
/// SCREEN
/// ---------------------------------------------------------------------
class ServiceDetailsScreen extends StatelessWidget {
  /// Header image (network URL). Pass an asset path instead and swap
  /// [Image.network] for [Image.asset] below if needed.
  final String imageUrl;

  final String title;
  final String description;
  final double rating;
  final int reviewsCount;

  /// e.g. "الخدمة تشمل" or "العرض يشمل"
  final String includesTitle;
  final List<ServiceFeature> features;

  final List<ServiceReview> reviews;

  /// Fully formatted price text, e.g. "300-400 دينار" or "200 دينار"
  final String priceText;

  /// e.g. "اطلب الخدمة" or "اطلب العرض"
  final String ctaLabel;
  final VoidCallback onCtaPressed;

  const ServiceDetailsScreen({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.rating,
    required this.reviewsCount,
    required this.includesTitle,
    required this.features,
    required this.reviews,
    required this.priceText,
    required this.ctaLabel,
    required this.onCtaPressed,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: ColorsManager.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _HeaderImage(imageUrl: imageUrl),
            Transform.translate(
              offset: Offset(0, -RS.size(context, 22)),
              child: Container(
                decoration: BoxDecoration(
                  color: ColorsManager.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(RS.radius(context, 24)),
                    topRight: Radius.circular(RS.radius(context, 24)),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: _kSoftShadow,
                      blurRadius: 12,
                      offset: Offset(0, -4),
                    ),
                  ],
                ),
                padding: EdgeInsets.fromLTRB(
                  RS.size(context, 18),
                  RS.size(context, 22),
                  RS.size(context, 18),
                  RS.size(context, 12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: RS.font(context, 17),
                        fontWeight: FontWeight.bold,
                        color: ColorsManager.primaryTextDarkColor,
                      ),
                    ),
                    SizedBox(height: RS.size(context, 8)),
                    Text(
                      description,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: RS.font(context, 13),
                        color: ColorsManager.secondaryTextDarkColor,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: RS.size(context, 10)),

                    /// ===== Rating row (kept LTR so 4.5 / star / count
                    /// always render in the same fixed visual order) =====
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      textDirection: TextDirection.ltr,
                      children: [
                        Text(
                          rating.toString(),
                          style: TextStyle(
                            fontSize: RS.font(context, 13),
                            fontWeight: FontWeight.bold,
                            color: ColorsManager.primaryTextDarkColor,
                          ),
                        ),
                        SizedBox(width: RS.size(context, 4)),
                        _Icon(asset: AssetsManager.star, size: 14, color: _kAccentOrange),
                        SizedBox(width: RS.size(context, 4)),
                        Text(
                          '(${reviewsCount} ${t.reviewsCount})',
                          style: TextStyle(
                            fontSize: RS.font(context, 12),
                            color: ColorsManager.secondaryTextDarkColor,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: RS.size(context, 16)),
                    Divider(color: ColorsManager.grey.withValues(alpha: 0.4), height: 1),
                    SizedBox(height: RS.size(context, 16)),

                    /// ===== Includes section =====
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        includesTitle,
                        style: TextStyle(
                          fontSize: RS.font(context, 15),
                          fontWeight: FontWeight.bold,
                          color: ColorsManager.primaryTextDarkColor,
                        ),
                      ),
                    ),
                    SizedBox(height: RS.size(context, 12)),
                    ...features.map(
                      (f) => Padding(
                        padding: EdgeInsets.only(bottom: RS.size(context, 12)),
                        child: _FeatureRow(feature: f),
                      ),
                    ),

                    SizedBox(height: RS.size(context, 8)),

                    /// ===== Reviews section =====
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        t.customerReviews,
                        style: TextStyle(
                          fontSize: RS.font(context, 15),
                          fontWeight: FontWeight.bold,
                          color: ColorsManager.primaryTextDarkColor,
                        ),
                      ),
                    ),
                    SizedBox(height: RS.size(context, 12)),
                    SizedBox(
                      height: RS.size(context, 150),
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        clipBehavior: Clip.none,
                        itemCount: reviews.length,
                        separatorBuilder: (_, __) => SizedBox(width: RS.size(context, 10)),
                        itemBuilder: (context, index) => _ReviewCard(review: reviews[index]),
                      ),
                    ),
                    SizedBox(height: RS.size(context, 8)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _BottomBar(
        priceText: priceText,
        ctaLabel: ctaLabel,
        onPressed: onCtaPressed,
      ),
    );
  }
}

/// ---------------------------------------------------------------------
/// HEADER IMAGE + carousel arrow
/// ---------------------------------------------------------------------
class _HeaderImage extends StatelessWidget {
  final String imageUrl;
  const _HeaderImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: RS.size(context, 260),
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            imageUrl,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return Container(
                color: ColorsManager.grey.withValues(alpha: 0.2),
                child: const Center(child: CircularProgressIndicator()),
              );
            },
            errorBuilder: (context, error, stack) => Container(
              color: ColorsManager.grey.withValues(alpha: 0.2),
              child: const Icon(Icons.image_not_supported_outlined),
            ),
          ),
          Positioned(
            top: RS.size(context, 16),
            right: RS.size(context, 16),
            child: Container(
              width: RS.size(context, 32),
              height: RS.size(context, 32),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorsManager.white.withValues(alpha: 0.85),
              ),
              child: Icon(
                Icons.chevron_right,
                size: RS.size(context, 20),
                color: ColorsManager.primaryTextDarkColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------------
/// FEATURE ROW ( text ------- check )
/// ---------------------------------------------------------------------
class _FeatureRow extends StatelessWidget {
  final ServiceFeature feature;
  const _FeatureRow({required this.feature});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            feature.text,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: RS.font(context, 13),
              color: ColorsManager.primaryTextDarkColor,
            ),
          ),
        ),
        SizedBox(width: RS.size(context, 8)),
        _Icon(asset: AssetsManager.done, size: 18, color: _kAccentOrange),
      ],
    );
  }
}

/// ---------------------------------------------------------------------
/// REVIEW CARD
/// ---------------------------------------------------------------------
class _ReviewCard extends StatelessWidget {
  final ServiceReview review;
  const _ReviewCard({required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: RS.size(context, 210),
      padding: EdgeInsets.all(RS.size(context, 12)),
      decoration: BoxDecoration(
        color: _kReviewCardBg,
        borderRadius: BorderRadius.circular(RS.radius(context, 14)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: List.generate(
              review.starsCount,
              (i) => Padding(
                padding: EdgeInsets.only(left: RS.size(context, 2)),
                child: _Icon(asset: AssetsManager.star, size: 12, color: _kAccentOrange),
              ),
            ),
          ),
          SizedBox(height: RS.size(context, 8)),
          Expanded(
            child: Text(
              review.reviewText,
              textAlign: TextAlign.start,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: RS.font(context, 11.5),
                color: ColorsManager.secondaryTextDarkColor,
                height: 1.4,
              ),
            ),
          ),
          SizedBox(height: RS.size(context, 8)),
          Row(
            children: [
              Container(
                width: RS.size(context, 28),
                height: RS.size(context, 28),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorsManager.primaryColor.withValues(alpha: 0.15),
                ),
                child: Text(
                  review.avatarInitials,
                  style: TextStyle(
                    fontSize: RS.font(context, 10),
                    fontWeight: FontWeight.bold,
                    color: ColorsManager.primaryColor,
                  ),
                ),
              ),
              SizedBox(width: RS.size(context, 8)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.reviewerName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: RS.font(context, 11),
                        fontWeight: FontWeight.bold,
                        color: ColorsManager.primaryTextDarkColor,
                      ),
                    ),
                    Text(
                      review.date,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: RS.font(context, 9.5),
                        color: ColorsManager.secondaryTextDarkColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------------
/// BOTTOM BAR ( price ---- CTA button )
/// ---------------------------------------------------------------------
class _BottomBar extends StatelessWidget {
  final String priceText;
  final String ctaLabel;
  final VoidCallback onPressed;

  const _BottomBar({
    required this.priceText,
    required this.ctaLabel,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: RS.size(context, 18),
          vertical: RS.size(context, 12),
        ),
        decoration: BoxDecoration(
          color: ColorsManager.white,
          boxShadow: const [
            BoxShadow(color: _kSoftShadow, blurRadius: 10, offset: Offset(0, -2)),
          ],
        ),
        child: Row(
          children: [
            Text(
              priceText,
              style: TextStyle(
                fontSize: RS.font(context, 14),
                fontWeight: FontWeight.bold,
                color: ColorsManager.primaryTextDarkColor,
              ),
            ),
            SizedBox(width: RS.size(context, 14)),
            Expanded(
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManager.primaryColor,
                  foregroundColor: ColorsManager.white,
                  padding: EdgeInsets.symmetric(vertical: RS.size(context, 14)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(RS.radius(context, 12)),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  ctaLabel,
                  style: TextStyle(
                    fontSize: RS.font(context, 14),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ---------------------------------------------------------------------
/// SMALL SVG ICON HELPER (guards against broken/oversized svg assets)
/// ---------------------------------------------------------------------
class _Icon extends StatelessWidget {
  final String asset;
  final double size;
  final Color color;
  const _Icon({required this.asset, required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      asset,
      width: RS.size(context, size),
      height: RS.size(context, size),
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}