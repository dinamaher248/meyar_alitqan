import 'package:flutter/material.dart';
import 'package:meayar_alitqan/l10n/app_localizations.dart';
import '../../../../core/helper/responsive_size.dart';
import '../../../../core/utils/colors_manager.dart';
class VideoCallInfoSection extends StatelessWidget {
  const VideoCallInfoSection({
    super.key,
    this.onRequestVideoCall,
  });

  final VoidCallback? onRequestVideoCall;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Container(
      padding: EdgeInsets.all(RS.size(context, 16)),
      decoration: BoxDecoration(
        color: ColorsManager.primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(RS.radius(context, 12)),
        border: Border.all(
          color: ColorsManager.primaryColor.withOpacity(0.3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(RS.size(context, 10)),
            decoration: BoxDecoration(
              color: ColorsManager.primaryColor.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.video_call,
              color: ColorsManager.primaryColor,
              size: RS.size(context, 26),
            ),
          ),
          SizedBox(width: RS.size(context, 12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.videoCallRequestTitle,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: RS.font(context, 15),
                      ),
                ),
                SizedBox(height: RS.size(context, 6)),
                Text(
                  t.videoCallRequestDescription,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: RS.font(context, 13),
                        color: Colors.black.withOpacity(0.7),
                      ),
                ),
                if (onRequestVideoCall != null) ...[
                  SizedBox(height: RS.size(context, 10)),
                  GestureDetector(
                    onTap: onRequestVideoCall,
                    child: Text(
                      t.requestVideoCall,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: ColorsManager.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: RS.font(context, 13),
                          ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
