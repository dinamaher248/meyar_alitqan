import 'package:flutter/cupertino.dart';

import '../../../../../../../../core/utils/assets_manager.dart';
class WebAboutImageSlider extends StatefulWidget {
  const WebAboutImageSlider({super.key});

  @override
  State<WebAboutImageSlider> createState() => _WebAboutImageSliderState();
}

class _WebAboutImageSliderState extends State<WebAboutImageSlider> {
  int _index = 0;

  final images = [
    AssetsManager.aboutImage,
    AssetsManager.aboutImage2,
    AssetsManager.aboutImage3,
  ];

  @override
  void initState() {
    super.initState();
    _startAutoSwitch();
  }

  void _startAutoSwitch() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 10));
      if (!mounted) return false;
      setState(() {
        _index = (_index + 1) % images.length;
      });
      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      height: 260,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 600),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.08, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          },
          child: Image.asset(
            images[_index],
            key: ValueKey(images[_index]),
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover, // 🔥 أهم سطر
          ),
        ),
      ),
    );
  }
}
