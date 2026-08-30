import 'package:flutter/material.dart';

import '../../../../../../../../core/components/custom_app_bar.dart';
import '../../../../../../../../core/helper/responsive_size.dart';
import '../../../../../../../../core/utils/colors_manager.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import '../widgets/report_details_sheet.dart';

class TechnicianReportDetailView extends StatelessWidget {
  const TechnicianReportDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: CustomAppBar(title: loc.serviceDetails, centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(RS.size(context, 16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ===== كارت تفاصيل الخدمة =====
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(RS.size(context, 14)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(RS.radius(context, 12)),
                  border: Border.all(color: ColorsManager.grey),
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "تركيب كاميرات مراقبه",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: RS.font(context, 14),
                          ),
                        ),
                        SizedBox(height: RS.size(context, 4)),
                        Text(
                          "#1220-129-01",
                          style: TextStyle(
                            fontSize: RS.font(context, 11),
                            color: ColorsManager.secondaryTextDarkColor,
                          ),
                        ),
                        SizedBox(height: RS.size(context, 4)),
                        SizedBox(height: RS.size(context, 8)),
                        _infoLine(
                          context,
                          Icons.calendar_today_outlined,
                          "11 مايو-2026 3:00م",
                        ),
                        SizedBox(height: RS.size(context, 6)),
                        _infoLine(
                          context,
                          Icons.location_on_outlined,
                          "عبدون، شارع زهران",
                        ),
                      ],
                    ),
                    const Spacer(),

                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: RS.size(context, 8),
                        vertical: RS.size(context, 4),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(
                          RS.radius(context, 20),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 14,
                          ),
                          const SizedBox(width: 4),

                          Text(
                            loc.done,
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: RS.font(context, 11),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: RS.size(context, 24)),

              Text(
                loc.attachedReport,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: RS.font(context, 16),
                ),
              ),
              SizedBox(height: RS.size(context, 12)),

              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (_) => const ReportDetailsSheet(),
                  );
                },
                borderRadius: BorderRadius.circular(RS.radius(context, 12)),
                child: Container(
                  padding: EdgeInsets.all(RS.size(context, 12)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(RS.radius(context, 12)),
                    border: Border.all(color: ColorsManager.grey),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(RS.size(context, 8)),
                        decoration: BoxDecoration(
                          color: ColorsManager.primaryColor.withValues(
                            alpha: 0.1,
                          ),
                          borderRadius: BorderRadius.circular(
                            RS.radius(context, 8),
                          ),
                        ),
                        child: Icon(
                          Icons.bar_chart,
                          color: ColorsManager.primaryColor,
                          size: RS.size(context, 18),
                        ),
                      ),
                      SizedBox(width: RS.size(context, 8)),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              loc.serviceReport,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: RS.font(context, 14),
                              ),
                            ),
                            SizedBox(height: RS.size(context, 4)),
                            Text(
                              "#1220-129-01",
                              style: TextStyle(
                                fontSize: RS.font(context, 11),
                                color: ColorsManager.secondaryTextDarkColor,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Icon(
                        Icons.chevron_right,
                        color: ColorsManager.secondaryTextDarkColor,
                        size: RS.size(context, 18),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: RS.size(context, 24)),

              Text(
                loc.financialDetails,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: RS.font(context, 16),
                ),
              ),
              SizedBox(height: RS.size(context, 12)),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(RS.size(context, 16)),
                decoration: BoxDecoration(
                  color: ColorsManager.primaryColor.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(RS.radius(context, 12)),
                ),
                child: Column(
                  children: [
                    _financialRow(context, loc.servicePrice, "400 ${loc.currencyDinar}"),
                    SizedBox(height: RS.size(context, 10)),
                    _financialRow(
                      context,
                      loc.companyCommission,
                      "-100 ${loc.currencyDinar}",
                      valueColor: Colors.red,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: RS.size(context, 10),
                      ),
                      child: Divider(color: ColorsManager.grey),
                    ),
                    _financialRow(
                      context,
                      loc.netProfit,
                      "300 ${loc.currencyDinar}",
                      isBold: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoLine(BuildContext context, IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: RS.size(context, 14),
          color: ColorsManager.secondaryTextDarkColor,
        ),
        SizedBox(width: RS.size(context, 6)),
        Text(
          text,
          style: TextStyle(
            fontSize: RS.font(context, 12),
            color: ColorsManager.secondaryTextDarkColor,
          ),
        ),
      ],
    );
  }

  Widget _financialRow(
    BuildContext context,
    String label,
    String value, {
    Color? valueColor,
    bool isBold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: RS.font(context, isBold ? 14 : 13),
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: ColorsManager.primaryTextDarkColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: RS.font(context, isBold ? 15 : 13),
            fontWeight: FontWeight.bold,
            color: valueColor ?? ColorsManager.primaryTextDarkColor,
          ),
        ),
      ],
    );
  }
}
