import 'package:flutter/cupertino.dart';

import '../../../../../l10n/app_localizations.dart';
import 'faq_item.dart';
import 'faq_tile.dart';

class FaqViewBody extends StatelessWidget {
  const FaqViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: faqItems(context)
            .map((item) => FaqTile(item: item))
            .toList(),
      )

    );
  }
}
List<FaqItem> faqItems(BuildContext context) => [
  // ===== Warranty & Quality =====
  FaqItem(
    question: AppLocalizations.of(context)!.faq_q_warranty_duration,
    answer: AppLocalizations.of(context)!.faq_a_warranty_duration,
  ),
  FaqItem(
    question: AppLocalizations.of(context)!.faq_q_warranty_coverage,
    answer: AppLocalizations.of(context)!.faq_a_warranty_coverage,
  ),
  FaqItem(
    question: AppLocalizations.of(context)!.faq_q_post_service_followup,
    answer: AppLocalizations.of(context)!.faq_a_post_service_followup,
  ),

  // ===== Pricing & Fees =====
  FaqItem(
    question: AppLocalizations.of(context)!.faq_q_pricing_difference,
    answer: AppLocalizations.of(context)!.faq_a_pricing_difference,
  ),
  FaqItem(
    question: AppLocalizations.of(context)!.faq_q_emergency_fee,
    answer: AppLocalizations.of(context)!.faq_a_emergency_fee,
  ),
  FaqItem(
    question: AppLocalizations.of(context)!.faq_q_cost_confirmation,
    answer: AppLocalizations.of(context)!.faq_a_cost_confirmation,
  ),

  // ===== Booking & Technicians =====
  FaqItem(
    question: AppLocalizations.of(context)!.faq_q_video_call,
    answer: AppLocalizations.of(context)!.faq_a_video_call,
  ),
  FaqItem(
    question: AppLocalizations.of(context)!.faq_q_trust_technician,
    answer: AppLocalizations.of(context)!.faq_a_trust_technician,
  ),
  FaqItem(
    question: AppLocalizations.of(context)!.faq_q_cancel_booking,
    answer: AppLocalizations.of(context)!.faq_a_cancel_booking,
  ),
];
