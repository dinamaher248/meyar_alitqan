import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'customer_home_mobile_layout.dart';
import 'customer_home_web_layout.dart';

class CustomerHomeTabViewBody extends StatelessWidget {
  const CustomerHomeTabViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? const CustomerHomeWebLayout()
        : const CustomerHomeMobileLayout();
  }
}
