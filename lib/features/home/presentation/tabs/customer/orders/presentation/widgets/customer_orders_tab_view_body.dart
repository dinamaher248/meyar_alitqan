import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meayar_alitqan/core/components/guest_orders_placeholder.dart';
import 'package:meayar_alitqan/core/cubit/app_user/app_user_cubit.dart';
import 'package:meayar_alitqan/features/orders/customer/presentation/manager/get_customer_orders_view_model/get_customer_orders_view_model.dart';
import 'package:meayar_alitqan/features/orders/customer/presentation/manager/get_customer_orders_view_model/get_customer_orders_view_model_states.dart';
import 'package:meayar_alitqan/features/orders/customer/presentation/widgets/order_details_list_shimmer.dart';
import 'package:meayar_alitqan/features/services/presentation/widgets/header_pages.dart';
import '../../../../../../../../core/helper/order_status_optimization.dart';
import '../../../../../../../../core/helper/responsive_size.dart';
import '../../../../../../../../core/helper/web_max_width.dart';
import '../../../../../../../../core/utils/assets_manager.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import '../../../../../../../orders/customer/presentation/manager/cancel_order_view_model/cancel_order_view_model.dart';
import '../../../../../../../orders/customer/presentation/manager/cancel_order_view_model/cancel_order_view_model_states.dart';
import '../../../../../../../orders/shared/presentation/widgets/order_details_list.dart';
import 'custom_orders_tab_bar.dart';

class CustomerOrdersTabViewBody extends StatefulWidget {
  const CustomerOrdersTabViewBody({super.key});

  @override
  State<CustomerOrdersTabViewBody> createState() =>
      _CustomerOrdersTabViewBodyState();
}

class _CustomerOrdersTabViewBodyState
    extends State<CustomerOrdersTabViewBody> {
  int selectedTab = 0;

@override
Widget build(BuildContext context) {
  final isGuest = context.watch<AppUserCubit>().state == null;

  if (isGuest) {
    return const GuestOrdersPlaceholder();
  }

  return BlocListener<
      CancelOrderViewModel,
      CancelOrderViewModelStates
  >(
    listener: (context, state) {
      if (state is CancelOrderViewModelSuccess) {
        context
            .read<GetCustomerOrdersViewModel>()
            .getCustomerOrders();
      }
    },
    child:RefreshIndicator(
      onRefresh: () async {
        await context.read<GetCustomerOrdersViewModel>().getCustomerOrders();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CustomOrdersTabBar(
                selectedIndex: selectedTab,
                onTabChanged: (index) {
                  setState(() => selectedTab = index);
                },
              ),
              const SizedBox(height: 24),
              selectedTab == 0
                  ? WebMaxWidth(child: _CurrentOrdersView())
                  : WebMaxWidth(child: _PreviousOrdersView()),
            ],
          ),
        ),
      ),
    )
  );
}

}


class _CurrentOrdersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      GetCustomerOrdersViewModel,
      GetCustomerOrdersViewModelStates
    >(
      builder: (context, state) {
        if (state is GetCustomerOrdersViewModelLoading) {
          return const OrderDetailsListShimmer();
        }

        if (state is GetCustomerOrdersViewModelSuccess) {
          final currentOrders = state.orders
              .where((o) => isCurrentOrder(o.status.name))
              .toList();

          if (currentOrders.isEmpty) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,

              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    AssetsManager.waiting,
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

          return OrderDetailsList(orders: currentOrders);
        }

       return const OrderDetailsListShimmer();
      },
    );
  }
}

class _PreviousOrdersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      GetCustomerOrdersViewModel,
      GetCustomerOrdersViewModelStates
    >(
      builder: (context, state) {
        if (state is GetCustomerOrdersViewModelLoading) {
          return const OrderDetailsListShimmer();
        }

        if (state is GetCustomerOrdersViewModelSuccess) {
          final previousOrders = state.orders
              .where((o) => isPreviousOrder(o.status.name))
              .toList();

          if (previousOrders.isEmpty) {
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
                    AppLocalizations.of(context)!.noPreviousOrders,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: RS.font(context, 20),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          }

          return OrderDetailsList(orders: previousOrders);
        }
 return const OrderDetailsListShimmer();
      },
    );
  }
}
