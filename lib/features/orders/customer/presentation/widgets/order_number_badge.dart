import 'package:flutter/material.dart';

import '../../../../../core/helper/responsive_size.dart';

class OrderNumberBadge extends StatelessWidget {
  final String orderNumber;

  const OrderNumberBadge({super.key, required this.orderNumber});


  @override
  Widget build(BuildContext context) {
    return Container(
      height: RS.size(context, 30),
      width: RS.size(context, 30),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadiusDirectional.only(
          bottomEnd: Radius.circular(RS.radius(context, 60)),
        )

      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          orderNumber,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: RS.font(context, 12),
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
