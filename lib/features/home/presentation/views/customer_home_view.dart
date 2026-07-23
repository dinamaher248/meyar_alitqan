import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'mobile/views/customer_home_mobile_scaffold.dart';
import 'web/views/customer_home_web_scaffold.dart';
import '../tabs/shared/widgets/web_language_floating_button.dart';

class CustomerHomeView extends StatelessWidget {
  const CustomerHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        kIsWeb
            ? const CustomerHomeWebScaffold()
            : const CustomerHomeMobileScaffold(),

        if (kIsWeb) const WebLanguageFloatingButton(),
      ],
    );
  }
}
