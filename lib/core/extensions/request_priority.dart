import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../enums/request_priority.dart';

extension RequestPriorityX on RequestPriority {
  String localized(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    switch (this) {
      case RequestPriority.scheduled:
        return loc.request_priority_scheduled;
      case RequestPriority.urgent:
        return loc.request_priority_urgent;
      case RequestPriority.emergency:
        return loc.request_priority_emergency;
    }
  }
}
