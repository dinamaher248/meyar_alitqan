import 'package:flutter/material.dart';

import '../../../../../core/helper/responsive_size.dart';


class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        fontSize: RS.font(context, 14),
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
