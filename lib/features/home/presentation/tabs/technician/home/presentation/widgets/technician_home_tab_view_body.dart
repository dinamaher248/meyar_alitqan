import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meayar_alitqan/core/helper/web_max_width.dart';
import 'package:meayar_alitqan/features/orders/shared/presentation/widgets/order_details_list.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../../config/routes/routes_manager.dart';
import '../../../../../../../../core/helper/responsive_size.dart';
import '../../../../../../../../core/utils/assets_manager.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import '../../../../../../../orders/customer/presentation/widgets/order_details_list_shimmer.dart';
import '../../../../../../../orders/technician/presentation/manager/get_technician_orders_view_model/get_technician_orders_view_model.dart';
import '../../../../../../../orders/technician/presentation/manager/get_technician_orders_view_model/get_technician_orders_view_model_states.dart';
import '../../../../shared/widgets/home_header.dart';
import 'technician_no_orders_placeholder.dart';
import 'technician_today_summary_section.dart';

class TechnicianHomeTabViewBody extends StatefulWidget {
  const TechnicianHomeTabViewBody({super.key});

  @override
  State<TechnicianHomeTabViewBody> createState() =>
      _TechnicianHomeTabViewBodyState();
}

class _TechnicianHomeTabViewBodyState
    extends State<TechnicianHomeTabViewBody> {
  late final GetTechnicianOrdersViewModel _ordersVM;

  @override
  void initState() {
    super.initState();

    _ordersVM = context.read<GetTechnicianOrdersViewModel>();

    final technicianId = Supabase.instance.client.auth.currentUser!.id;

    _ordersVM.getTechnicianOrders();
    _ordersVM.startRealtime(technicianId);
  }

  @override
  void dispose() {
    _ordersVM.stopRealtime();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      child: Column(
        children: [
          if (!kIsWeb)
            Padding(
              padding: EdgeInsets.fromLTRB(
                RS.size(context, 16),
                RS.size(context, 12),
                RS.size(context, 16),
                RS.size(context, 12),
              ),
              child: HomeHeader(
                onNotificationTap: () {
                  Navigator.pushNamed(context, RoutesManager.notificationsView);
                },
              ),
            ),

          SizedBox(height: RS.size(context, 16)),
          Center(
            child: Text(
              loc.recentDailyTasks,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: RS.font(context, 20),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: RS.size(context, 16)),

          BlocBuilder<GetTechnicianOrdersViewModel,
              GetTechnicianOrdersViewModelStates>(
            builder: (context, state) {
              if (state is GetTechnicianOrdersViewModelLoading) {
                return const OrderDetailsListShimmer();
              }

              if (state is GetTechnicianOrdersViewModelSuccess) {
                if (state.orders.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: RS.size(context, 16),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: RS.size(context, 40)),
                        Image.asset(
                          AssetsManager.waiting,
                          fit: BoxFit.cover,
                          height: RS.size(context, 200),
                        ),
                        SizedBox(height: RS.size(context, 16)),
                        Text(
                          loc.noOrders,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontSize: RS.font(context, 20),
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        SizedBox(height: RS.size(context, 24)),

                        /// ===== ملخص اليوم تحت حالة الفاضي =====
                        TechnicianTodaySummarySection(orders: state.orders),
                        SizedBox(height: RS.size(context, 20)),
                        const TechnicianNoOrdersPlaceholder(),
                      ],
                    ),
                  );
                }

                /// ===== لو فيه أوردرات: OrderDetailsList الأصلية الأول =====
                return Column(
                  children: [
                    Center(
                      child: WebMaxWidth(
                        child: OrderDetailsList(
                          orders: state.orders,
                          isTechnician: true,
                        ),
                      ),
                    ),

                    SizedBox(height: RS.size(context, 20)),

                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: RS.size(context, 16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// ===== ملخص اليوم  =====
                          TechnicianTodaySummarySection(orders: state.orders),

                          SizedBox(height: RS.size(context, 20)),

                          Text(
                            loc.upcomingOrders,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: RS.font(context, 18),
                                ),
                          ),
                          SizedBox(height: RS.size(context, 12)),

                          ...state.orders.map(
                            (order) => OrderDetailsList(orders: [order], isNewRequest: true),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }

              return Center(
                child: Text(
                  "حدث خطأ",
                  style: TextStyle(fontSize: RS.font(context, 16)),
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