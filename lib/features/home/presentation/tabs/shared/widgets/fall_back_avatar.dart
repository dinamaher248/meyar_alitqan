  import 'package:flutter/material.dart';

Widget fallbackAvatar(BuildContext context, double size,  final String? name) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.5),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        name != null && name!.isNotEmpty ? name![0].toUpperCase() : 'G',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontSize: size * 0.45,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }