import 'dart:ui';

String timeAgo(
    DateTime date,
    Locale locale,
    ) {
  final now = DateTime.now();
  final difference = now.difference(date);

  final isArabic = locale.languageCode == 'ar';

  if (difference.inSeconds < 60) {
    return isArabic ? 'منذ لحظات' : 'Just now';
  } else if (difference.inMinutes < 2) {
    return isArabic ? 'منذ دقيقة' : '1 minute ago';
  } else if (difference.inMinutes < 60) {
    return isArabic
        ? 'منذ ${difference.inMinutes} دقائق'
        : '${difference.inMinutes} minutes ago';
  } else if (difference.inHours < 2) {
    return isArabic ? 'منذ ساعة' : '1 hour ago';
  } else if (difference.inHours < 24) {
    return isArabic
        ? 'منذ ${difference.inHours} ساعات'
        : '${difference.inHours} hours ago';
  } else if (difference.inDays < 2) {
    return isArabic ? 'أمس' : 'Yesterday';
  } else if (difference.inDays < 7) {
    return isArabic
        ? 'منذ ${difference.inDays} أيام'
        : '${difference.inDays} days ago';
  } else {
    return isArabic
        ? '${date.day}/${date.month}/${date.year}'
        : '${date.month}/${date.day}/${date.year}';
  }
}
