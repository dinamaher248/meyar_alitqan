import 'package:flutter/material.dart';
import 'package:meayar_alitqan/core/utils/colors_manager.dart';

class GuestLockedCard extends StatelessWidget {
  const GuestLockedCard({super.key, 
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onLogin,
  });

  final String title;
  final String description;
  final String buttonText;
  final VoidCallback onLogin;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.lock_outline,
              size: 48,
              color:  ColorsManager.primaryColor,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onLogin,
              child: Text(buttonText,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white
                      )),
            ),
          ],
        ),
      ),
    );
  }
}
