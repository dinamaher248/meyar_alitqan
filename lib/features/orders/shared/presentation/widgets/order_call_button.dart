import 'package:flutter/material.dart';
import 'package:meayar_alitqan/core/helper/format_jordan_phone.dart';
import 'package:meayar_alitqan/core/helper/responsive_size.dart';
import 'package:meayar_alitqan/core/services/call_service.dart';

class OrderDetailsCallButton extends StatelessWidget {
  final String phone;

  const OrderDetailsCallButton({
    super.key,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    if (phone.isEmpty) return const SizedBox.shrink();

    final formattedPhone = formatJordanPhone(phone);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => CallService.makeCall(formattedPhone),
        child: Container(
          height: RS.size(context, 40),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [Colors.green.shade600, Colors.green.shade400],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.green.withOpacity(0.3),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.call, color: Colors.white),
              SizedBox(width: RS.size(context, 8)),
              Text(
                formattedPhone,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}