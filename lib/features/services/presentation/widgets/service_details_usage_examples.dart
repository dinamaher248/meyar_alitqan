import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:meayar_alitqan/l10n/app_localizations.dart';
import 'service_details_screen.dart';

// Example 1 — matches screenshot 1 (تركيب المفاتيح والمقابس)
Widget buildElectricianServiceExample(BuildContext context) {
  final loc = AppLocalizations.of(context)!;
  return ServiceDetailsScreen(
    imageUrl: 'https://your-cdn.com/electrician.jpg',
    title: 'تركيب المفاتيح والمقابس',
    description:
        'خدمة تركيب وصيانة المفاتيح والمقابس الكهربائية في المنازل والمكاتب، بسرعة وأمان على يد فنيين متخصصين',
    rating: 4.5,
    reviewsCount: 79,
    includesTitle: 'الخدمة تشمل',
    features: const [
      ServiceFeature('تركيب مفاتيح الإضاءة والمقابس الجديدة'),
      ServiceFeature('استبدال المفاتيح والمقابس التالفة أو القديمة'),
      ServiceFeature('فحص التوصيلات الكهربائية لضمان السلامة'),
    ],
    reviews: const [
      ServiceReview(
        reviewerName: 'احمد محمد',
        date: '12 يونيو 2026',
        reviewText:
            'خدمة ممتازة وسريعة، الفني كان محترف وحل المشكلة في وقت قصير',
        starsCount: 4,
        avatarInitials: 'AM',
      ),
      ServiceReview(
        reviewerName: 'احمد محمد',
        date: '12 يونيو 2026',
        reviewText: 'خدمة ممتازة وسريعة، الفني وصل وحل المشكلة في وقت قصير',
        starsCount: 4,
        avatarInitials: 'AM',
      ),
    ],
    priceText: '300-400 ${loc.currencyDinar}',
    ctaLabel: 'اطلب الخدمة',
    onCtaPressed: () {},
  );
}

// Example 2 — matches screenshot 2 (باقة التنظيف الشاملة)
Widget buildCleaningOfferExample(BuildContext context) {
  final loc = AppLocalizations.of(context)!;
  return ServiceDetailsScreen(
    imageUrl: 'https://your-cdn.com/cleaning.jpg',
    title: 'باقة التنظيف الشاملة',
    description:
        'خدمة تنظيف متكاملة مقدمة من فريق صيانية متخصصين في نظافة البيوت',
    rating: 4.5,
    reviewsCount: 79,
    includesTitle: 'العرض يشمل',
    features: const [
      ServiceFeature('تنظيف الأرضيات والسجاد بمواد آمنة'),
      ServiceFeature('غسل وتعقيم الحمامات والمطابخ'),
      ServiceFeature('تلميع الزجاج والأثاث'),
    ],
    reviews: const [
      ServiceReview(
        reviewerName: 'احمد محمد',
        date: '12 يونيو 2026',
        reviewText:
            'خدمة ممتازة وسريعة، الفني كان محترف وحل المشكلة في وقت قصير',
        starsCount: 4,
        avatarInitials: 'AM',
      ),
    ],
    priceText: '200 ${loc.currencyDinar}',
    ctaLabel: 'اطلب العرض',
    onCtaPressed: () {},
  );
}
