import 'package:flutter/material.dart';

class RS {
  static double _scaleForWidth(double width) {
    if (width < 600) {
      return 1.0; 
    } else if (width < 1000) {
      return 1.15;  
    } else {
      return 1.0;  
    }

  }

  static double size(BuildContext context, double value) {
    final width = MediaQuery.of(context).size.width;
    final scale = _scaleForWidth(width);

    // منع التضخيم على الويب
    return (value * scale).clamp(value, value * 1.3);
  }

  static double font(BuildContext context, double value) {
    final width = MediaQuery.of(context).size.width;

    if (width >= 1000) {
      // الويب: حجم ثابت
      return value;
    }

    final scale = _scaleForWidth(width);
    return (value * scale).clamp(value, value * 1.4);
  }

  static double radius(BuildContext context, double value) {
    final width = MediaQuery.of(context).size.width;

    if (width >= 1000) {
      return value; // radius ثابت على الويب
    }

    final scale = _scaleForWidth(width);
    return value * scale;
  }
}
