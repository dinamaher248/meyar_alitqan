import 'dart:async';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import '../../../../core/helper/responsive_size.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/colors_manager.dart';

class BannerSection extends StatefulWidget {
  const BannerSection({
    super.key,
    required this.images,

    /// التحكم
    this.hideDots = false,
    this.disableAutoPlay = false,
    this.useContain = false,
    this.useFill = false,

    /// 🆕 Fade animation بدل السحب
    this.useFadeAnimation = false,
  });

  final List<String> images;
  final bool hideDots;
  final bool disableAutoPlay;
  final bool useContain;
  final bool useFill;
  final bool useFadeAnimation;

  @override
  State<BannerSection> createState() => _BannerSectionState();
}

class _BannerSectionState extends State<BannerSection> {
  int _currentIndex = 0;
  Timer? _timer;

  BoxFit _resolveFit() {
    if (widget.useContain) return BoxFit.contain;
    if (widget.useFill) return BoxFit.fill;
    return BoxFit.cover;
  }

  @override
  void initState() {
    super.initState();

    /// Auto play للـ fade
    if (widget.useFadeAnimation &&
        !widget.disableAutoPlay &&
        widget.images.length > 1) {
      _timer = Timer.periodic(const Duration(seconds: 5), (_) {
        if (!mounted) return;
        setState(() {
          _currentIndex =
              (_currentIndex + 1) % widget.images.length;
        });
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 16 / 5, // 👈 أقل شوية من قبل
          child: widget.useFadeAnimation
              ? _buildFadeBanner()
              : _buildCarousel(),
        ),

        if (!widget.hideDots) ...[
          SizedBox(height: RS.size(context, 8)),
          _buildDots(),
        ],
      ],
    );
  }

  /// ================= FADE BANNER =================
  Widget _buildFadeBanner() {
    final banner = widget.images[_currentIndex];
    final fit = _resolveFit();

    return ClipRRect(
      borderRadius: BorderRadius.circular(RS.radius(context, 12)),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 700),
        transitionBuilder: (child, animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: Stack(
          key: ValueKey(banner),
          fit: StackFit.expand,
          children: [
            if (widget.useContain) ...[
              CachedNetworkImage(
                imageUrl: banner,
                fit: BoxFit.cover,
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                child: Container(
                  color: Colors.black.withOpacity(0.2),
                ),
              ),
            ],
            CachedNetworkImage(
              imageUrl: banner,
              fit: fit,
              placeholder: (_, __) =>
                  Container(color: Colors.black12),
              errorWidget: (_, __, ___) => Image.asset(
                AssetsManager.bannerImage,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ================= CAROUSEL =================
  Widget _buildCarousel() {
    return CarouselSlider.builder(
      itemCount: widget.images.length,
      itemBuilder: (context, index, realIndex) {
        final banner = widget.images[index];
        final fit = _resolveFit();

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: RS.size(context, 8)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(RS.radius(context, 12)),
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (widget.useContain) ...[
                  CachedNetworkImage(
                    imageUrl: banner,
                    fit: BoxFit.cover,
                  ),
                  BackdropFilter(
                    filter:
                    ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                    child: Container(
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ),
                ],
                CachedNetworkImage(
                  imageUrl: banner,
                  fit: fit,
                  placeholder: (_, __) =>
                      Container(color: Colors.black12),
                  errorWidget: (_, __, ___) => Image.asset(
                    AssetsManager.bannerImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      options: CarouselOptions(
        viewportFraction: 1,
        autoPlay: !widget.disableAutoPlay,
        autoPlayInterval: const Duration(seconds: 5),
        autoPlayAnimationDuration:
        const Duration(milliseconds: 800),
        autoPlayCurve: Curves.easeInOut,
        enlargeCenterPage: false,
        onPageChanged: (index, _) {
          setState(() => _currentIndex = index);
        },
      ),
    );
  }

  /// ================= DOTS =================
  Widget _buildDots() {
    return DotsIndicator(
      dotsCount: widget.images.isNotEmpty ? widget.images.length : 1,
      position: _currentIndex.toDouble(),
      decorator: DotsDecorator(
        activeColor: ColorsManager.primaryColor,
        color: Colors.grey.shade400,
        size: Size(RS.size(context, 8), RS.size(context, 8)),
        activeSize:
        Size(RS.size(context, 12), RS.size(context, 12)),
        activeShape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(RS.radius(context, 4)),
        ),
      ),
    );
  }
}
