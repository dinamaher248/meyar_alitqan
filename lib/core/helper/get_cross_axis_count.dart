import 'package:flutter/cupertino.dart';

int getCrossAxisCount(BuildContext context) {
  final width = MediaQuery.of(context).size.width;

  if (width > 1200) return 6;
  if (width > 800) return 4;
  return 3;
}