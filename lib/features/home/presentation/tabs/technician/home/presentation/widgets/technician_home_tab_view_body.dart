import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meayar_alitqan/core/helper/web_max_width.dart';
import 'package:meayar_alitqan/features/orders/shared/presentation/widgets/order_details_list.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../../config/routes/routes_manager.dart';
import '../../../../../../../../core/helper/responsive_size.dart';
import '../../../../../../../../core/utils/assets_manager.dart';
import '../../../../../../../../core/utils/colors_manager.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import '../../../../../../../orders/customer/presentation/widgets/order_details_list_shimmer.dart';
import '../../../../../../../orders/technician/presentation/manager/get_technician_orders_view_model/get_technician_orders_view_model.dart';
import '../../../../../../../orders/technician/presentation/manager/get_technician_orders_view_model/get_technician_orders_view_model_states.dart';
import '../../../../shared/widgets/home_header.dart';

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

    final technicianId =
        Supabase.instance.client.auth.currentUser!.id;

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
    return SingleChildScrollView(
      child: Column(


        children: [
          if(!kIsWeb)
          Stack(
            children: [
              Container(
                height: RS.size(context, 100),
                decoration: BoxDecoration(
                  color: ColorsManager.primaryColor.withOpacity(.4),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: RS.size(context, 16),
                  horizontal: RS.size(context, 8),
                ),

                child: HomeHeader(
                  onNotificationTap: () {
                    Navigator.pushNamed(
                      context,
                      RoutesManager.notificationsView,
                    );
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: RS.size(context, 16)),
          Center(
            child: Text(
              AppLocalizations.of(context)!.recentDailyTasks,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: RS.font(context, 20),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: RS.size(context, 16)),

          BlocBuilder<
            GetTechnicianOrdersViewModel,
            GetTechnicianOrdersViewModelStates
          >(
            builder: (context, state) {
              if (state is GetTechnicianOrdersViewModelLoading) {
                return const OrderDetailsListShimmer();
              } else if (state is GetTechnicianOrdersViewModelSuccess) {
                if (state.orders.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: RS.size(context, 60)),
                      Image.asset(
                        AssetsManager.waiting,
                        fit: BoxFit.cover,
                        height: RS.size(context, 250),
                      ),
                      SizedBox(height: RS.size(context, 16)),
                      Text(
                        AppLocalizations.of(context)!.noOrders,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: RS.font(context, 20),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                }
                return Center(
                  child: WebMaxWidth(
                    child: OrderDetailsList(
                      orders: state.orders,
                      isTechnician: true,
                    ),
                  ),
                );
              } else {
                return const Center(child: Text("حدث خطأ",style: TextStyle(
                  color: Colors.white,fontSize: 16
                ),));
              }
            },
          ),
        ],
      ),
    );
  }
}
