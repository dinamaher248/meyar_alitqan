import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meayar_alitqan/core/helper/web_max_width.dart';
import 'package:meayar_alitqan/l10n/app_localizations.dart';

import '../../../../../../../../core/helper/responsive_size.dart';
import '../../../../../../../../core/utils/assets_manager.dart';
import '../../../../../../../orders/shared/presentation/widgets/order_details_list.dart';
import '../../../../../../../orders/technician/presentation/manager/get_technician_orders_view_model/get_technician_orders_view_model.dart';
import '../../../../../../../orders/technician/presentation/manager/get_technician_orders_view_model/get_technician_orders_view_model_states.dart';
import '../../../../customer/orders/presentation/widgets/custom_orders_tab_bar.dart';

class TechnicianJobsTabViewBody extends StatefulWidget {
  const TechnicianJobsTabViewBody({super.key});

  @override
  State<TechnicianJobsTabViewBody> createState() =>
      _TechnicianJobsTabViewBodyState();
}

class _TechnicianJobsTabViewBodyState
    extends State<TechnicianJobsTabViewBody> {
  int selectedTab = 0;

  @override
  void initState() {
    super.initState();

    context.read<GetTechnicianOrdersViewModel>().getCompletedOrders();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomOrdersTabBar(
              currentOrdersLabel: t.completedOrders,
              previousOrdersLabel: t.canceledOrder,
              selectedIndex: selectedTab,
              onTabChanged: (index) {
                setState(() => selectedTab = index);
        
                final vm =
                context.read<GetTechnicianOrdersViewModel>();
        
                if (index == 0) {
                  vm.getCompletedOrders();
                } else {
                  vm.getCanceledOrders();
                }
              },
            ),
        
            const SizedBox(height: 24),
        
            BlocBuilder<
                GetTechnicianOrdersViewModel,
                GetTechnicianOrdersViewModelStates>(
              builder: (context, state) {
                if (state
                is GetTechnicianOrdersViewModelLoading) {
                  return const Center(
                    child: CupertinoActivityIndicator(),
                  );
                }
        
                if (state
                is GetTechnicianOrdersViewModelSuccess) {
                  if (state.orders.isEmpty) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.6,

                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            AssetsManager.waiting2,
                            fit: BoxFit.cover,
                            height: RS.size(context, 200),
                          ),
                          SizedBox(height: RS.size(context, 16)),
                          Text(
                            AppLocalizations.of(context)!.noCurrentOrders,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontSize: RS.font(context, 20),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
        
                  return WebMaxWidth(
                    child: OrderDetailsList(
                      orders: state.orders,
                      isTechnician: true,
                    ),
                  );
                }
        
                if (state
                is GetTechnicianOrdersViewModelError) {
                  return Center(
                    child: Text(state.message),
                  );
                }
        
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
