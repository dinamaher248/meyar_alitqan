import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../config/routes/routes_manager.dart';
class AppEntry extends StatefulWidget {
  const AppEntry({super.key});

  @override
  State<AppEntry> createState() => _AppEntryState();
}

class _AppEntryState extends State<AppEntry> {
  @override
  void initState() {
    super.initState();

    Future.microtask(_route);
  }

  void _route() {
    final uri = Uri.base;

    /// 🔥 Reset Password له أولوية
    if (kIsWeb && uri.fragment.startsWith('/reset-password')) {
      Navigator.of(context).pushReplacementNamed(
        RoutesManager.resetPasswordView,
      );
      return;
    }

    /// باقي الحالات
    Navigator.of(context).pushReplacementNamed(
      RoutesManager.splash,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
