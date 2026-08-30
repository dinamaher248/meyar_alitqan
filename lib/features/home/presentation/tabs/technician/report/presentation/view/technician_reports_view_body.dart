import 'package:flutter/material.dart';
import 'package:meayar_alitqan/features/home/presentation/tabs/technician/report/presentation/widgets/daily_profits_chart.dart';
import 'package:meayar_alitqan/features/home/presentation/tabs/technician/report/presentation/widgets/service_profit_row.dart';
import 'package:meayar_alitqan/features/home/presentation/tabs/technician/report/presentation/widgets/service_summary_tile.dart';
import 'package:meayar_alitqan/features/home/presentation/tabs/technician/report/presentation/widgets/weekly_profit_header.dart';

import '../../../../../../../../core/helper/responsive_size.dart';
import '../../../../../../../../core/utils/colors_manager.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import 'technician_report_detail_view.dart';

/// ⚠️ بيانات Static بالكامل — مفيش ViewModel/API متاح دلوقتي.
class TechnicianReportsViewBody extends StatelessWidget {
  const TechnicianReportsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: RS.size(context, 16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: RS.size(context, 12)),

          /// ===== كارت الإجمالي الأسبوعي =====
          const WeeklyProfitHeader(
            totalAmount: "40,500",
            increasePercent: "12%",
          ),

          SizedBox(height: RS.size(context, 20)),

          /// ===== الأرباح اليومية (Chart) =====
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(RS.size(context, 16)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(RS.radius(context, 14)),
              border: Border.all(color: ColorsManager.grey),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  loc.dailyProfits,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: RS.font(context, 15),
                      ),
                ),
                SizedBox(height: RS.size(context, 16)),
                 DailyProfitsChart(
                  /// Static: قيم نسبية تمثيلية بس
                  values: [0.15, 1.0, 0.55, 0.75, 0.4, 0.6, 0.35],
                  dayLabels: [
                    
                   "${loc.saturday}", "${loc.saturday}", "${loc.saturday}", "${loc.saturday}", "${loc.saturday}", "${loc.saturday}", "${loc.saturday}",
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: RS.size(context, 20)),

          /// ===== الأرباح حسب نوع الخدمة =====
          Text(
            loc.profitsByServiceType,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: RS.font(context, 16),
                ),
          ),
          SizedBox(height: RS.size(context, 12)),

           ServiceProfitRow(
            serviceName: "تركيب كاميرات",
            amount: "2,100 ${loc.currencyDinar}",
            progress: 0.75,
          ),
          SizedBox(height: RS.size(context, 12)),
           ServiceProfitRow(
            serviceName: "صيانه اللوحات الكهربائيه",
            amount: "2,100 ${loc.currencyDinar}",
            progress: 0.65,
          ),
          SizedBox(height: RS.size(context, 12)),
           ServiceProfitRow(
            serviceName: "تركيب كاميرات",
            amount: "2,100 ${loc.currencyDinar}",
            progress: 0.5,
          ),

          SizedBox(height: RS.size(context, 24)),

          /// ===== تفاصيل الخدمات =====
          Text(
            loc.serviceDetails,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: RS.font(context, 16),
                ),
          ),
          SizedBox(height: RS.size(context, 12)),

          ServiceSummaryTile(
            title: "تركيب كاميرات مراقبه",
            orderNumber: "#1220-129-01",
            date: "11 مايو",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const TechnicianReportDetailView(),
                ),
              );
            },
          ),
          SizedBox(height: RS.size(context, 10)),
          ServiceSummaryTile(
            title: "تركيب نظام انزار",
            orderNumber: "#1220-129-01",
            date: "11 مايو",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const TechnicianReportDetailView(),
                ),
              );
            },
          ),

          SizedBox(height: RS.size(context, 24)),
        ],
      ),
    );
  }
}