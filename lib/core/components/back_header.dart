import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../helper/responsive_size.dart';
import '../utils/assets_manager.dart';

class BackHeader extends StatelessWidget {
  final String title;

  const BackHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          AssetsManager.angleLeft,
          width: RS.size(context, 16),
          height: RS.size(context, 16),
        ),
        SizedBox(width: RS.size(context, 4)),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            fontSize: RS.font(context, 16),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}