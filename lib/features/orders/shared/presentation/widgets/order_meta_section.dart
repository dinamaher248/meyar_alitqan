import 'package:flutter/cupertino.dart';
import 'package:meayar_alitqan/core/extensions/request_priority.dart';

import '../../../../../core/enums/request_priority.dart';
import '../../../../../core/helper/responsive_size.dart';
import '../../../../../core/utils/assets_manager.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../customer/presentation/widgets/order_service_info.dart';

class OrderMetaSection extends StatelessWidget {
  final String serviceName;
  final String serviceDate;
  final RequestPriority serviceType; 
  final bool isTechnician;

  const OrderMetaSection({
    super.key,
    required this.serviceName,
    required this.serviceDate,
    required this.serviceType,
    this.isTechnician = false,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final itemWidth = (constraints.maxWidth - RS.size(context, 24)) / 3;

        return Wrap(
          alignment: WrapAlignment.center,
          spacing: RS.size(context, 12),
          runSpacing: RS.size(context, 12),
          children: [
            _item(
              context,
              AssetsManager.work,
              AppLocalizations.of(context)!.serviceName,
              serviceName,
              itemWidth,
            ),
            _item(
              context,
              AssetsManager.calendar,
              AppLocalizations.of(context)!.serviceDate,
              serviceDate,
              itemWidth,
            ),
            _item(
              context,
              AssetsManager.work,
              AppLocalizations.of(context)!.serviceType,
              serviceType.localized(context),
              itemWidth,
            ),
          ],
        );

      },
    );
  }
  Widget _item(
      BuildContext context,
      String icon,
      String label,
      String value,
      double width,
      ) {
    return SizedBox(
      width: width,
      child: OrderServiceInfo(
        icon: icon,
        label: label,
        value: value,
      ),
    );
  }


}
