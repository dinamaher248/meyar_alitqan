import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class WebMaxWidth extends StatelessWidget {
  final Widget child;
  const WebMaxWidth({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (kIsWeb && width > 900) {
      return Center(child: SizedBox(width: width * 0.9, child: child));
    }

    return child;
  }
}
