import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../tabs/shared/widgets/web_language_floating_button.dart';
import 'mobile/views/technician_home_mobile_scaffold.dart';
import 'web/views/technician_home_web_scaffold.dart';

class TechnicianHomeView extends StatelessWidget {
  const TechnicianHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        kIsWeb
            ? const TechnicianHomeWebScaffold()
            : const TechnicianHomeMobileScaffold(),
        if (kIsWeb) const WebLanguageFloatingButton(),
      ],
    );
  }
}
