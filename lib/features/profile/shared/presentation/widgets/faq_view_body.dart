import 'package:flutter/material.dart';

import '../../../../../core/helper/responsive_size.dart';
import '../../../../../core/utils/colors_manager.dart';
import '../../../../../l10n/app_localizations.dart';
import 'faq_item.dart';
import 'faq_tile.dart';

class FaqViewBody extends StatefulWidget {
  const FaqViewBody({super.key});

  @override
  State<FaqViewBody> createState() => _FaqViewBodyState();
}

class _FaqViewBodyState extends State<FaqViewBody> {
  final searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final allItems = faqItems(context);

    final filtered = allItems
        .where((item) => item.question
            .toLowerCase()
            .contains(searchController.text.toLowerCase()))
        .toList();

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(RS.size(context, 16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// ===== Search =====
                TextField(
                  controller: searchController,
                  onChanged: (_) => setState(() {}),
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    hintText: loc.faqSearchHint,
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: RS.size(context, 12),
                      horizontal: RS.size(context, 12),
                    ),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(RS.radius(context, 10)),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(RS.radius(context, 10)),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(RS.radius(context, 10)),
                      borderSide: BorderSide(color: ColorsManager.primaryColor),
                    ),
                  ),
                ),

                SizedBox(height: RS.size(context, 16)),

                ...filtered.map((item) => FaqTile(item: item)),
              ],
            ),
          ),
        ),

        /// ===== Add Question Button =====
        Padding(
          padding: EdgeInsets.all(RS.size(context, 16)),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsManager.primaryColor,
                padding: EdgeInsets.symmetric(vertical: RS.size(context, 14)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(RS.radius(context, 10)),
                ),
              ),
              onPressed: () => _showAddQuestionSheet(context),
              child: Text(
                loc.addQuestion,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: RS.font(context, 15),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showAddQuestionSheet(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final questionController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (sheetContext, setSheetState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
              ),
              child: Container(
                padding: EdgeInsets.all(RS.size(context, 16)),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: RS.size(context, 48),
                      height: RS.size(context, 48),
                      decoration: BoxDecoration(
                        color: ColorsManager.primaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.help_outline,
                        color: ColorsManager.primaryColor,
                      ),
                    ),
                    SizedBox(height: RS.size(context, 12)),
                    Text(
                      loc.addQuestionSheetTitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: RS.font(context, 16),
                      ),
                    ),
                    SizedBox(height: RS.size(context, 4)),
                    Text(
                      loc.addQuestionSheetDescription,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: RS.font(context, 12),
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: RS.size(context, 16)),
                    TextField(
                      controller: questionController,
                      maxLines: 4,
                      maxLength: 500,
                      textAlign: TextAlign.start,
                      onChanged: (_) => setSheetState(() {}),
                      decoration: InputDecoration(
                        hintText: loc.writeYourQuestionHint,
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(RS.radius(context, 10)),
                        ),
                      ),
                    ),
                    SizedBox(height: RS.size(context, 12)),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsManager.primaryColor,
                          padding: EdgeInsets.symmetric(
                            vertical: RS.size(context, 14),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(RS.radius(context, 10)),
                          ),
                        ),
                        onPressed: () {
                          // ⚠️ TODO: مفيش UseCase/ViewModel حقيقي لإرسال السؤال دلوقتي
                          Navigator.pop(sheetContext);
                        },
                        child: Text(
                          loc.sendButton,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: RS.font(context, 14),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
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