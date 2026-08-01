import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meayar_alitqan/core/cubit/app_user/app_user_cubit.dart';
import 'package:meayar_alitqan/features/location/presentation/manager/get_service_areas_view_model/get_service_areas_view_model.dart';
import 'package:meayar_alitqan/features/services/presentation/widgets/guest_locked_card.dart';

import '../../../../core/components/app_loader.dart';
import '../../../../core/di/di.dart';
import '../../../../core/helper/responsive_size.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../config/routes/routes_manager.dart';
import '../../../location/presentation/manager/get_current_location_view_model/get_current_location_view_model.dart';
import '../../../orders/customer/presentation/manager/create_order_view_model/create_order_view_model.dart';
import '../../../orders/customer/presentation/manager/create_order_view_model/create_order_view_model_states.dart';
import '../widgets/order_stepper_header.dart';
import '../widgets/service_request_details_view_body.dart';

class ServiceRequestDetailsView extends StatelessWidget {
  const ServiceRequestDetailsView({
    super.key,
    required this.mainCategoryId,
    required this.subserviceId,
    required this.categoryId,
    required this.title,
  });

  final String? mainCategoryId;
  final String? categoryId;
  final String? subserviceId;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final isGuest = getIt<AppUserCubit>().isGuest;
    final loc = AppLocalizations.of(context)!;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<CreateOrderViewModel>()),
        BlocProvider(create: (_) => getIt<GetCurrentUserLocationViewModel>()),
        BlocProvider(
          create: (_) => getIt<GetServiceAreasViewModel>()..getServiceAreas(),
        ),
      ],
      child: BlocBuilder<CreateOrderViewModel, CreateOrderViewModelStates>(
        builder: (context, state) {
          final isLoading = state is CreateOrderViewModelLoading;

          return Scaffold(
            body: SafeArea(
              child: Stack(
                children: [
                  Column(
                    children: [
                      
                      /// ================= BODY =================
                      Expanded(
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 700),
                            child: AbsorbPointer(
                              absorbing: isGuest,
                              child: ServiceRequestDetailsBody(
                                mainCategoryId: mainCategoryId,
                                categoryId: categoryId,
                                subserviceId: subserviceId,
                                title: title,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  /// ================= GUEST OVERLAY =================
                  if (isGuest)
                    Positioned.fill(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                        child: Container(
                          color: Colors.black.withOpacity(0.2),
                          alignment: Alignment.center,
                          child: GuestLockedCard(
                            title: loc.loginRequired,
                            description: loc.loginToCreateOrder,
                            buttonText: loc.login,
                            onLogin: () {
                              kIsWeb
                                  ? Navigator.pushNamed(
                                      context,
                                      RoutesManager.roleSelection,
                                    )
                                  : Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      RoutesManager.splash,
                                      (route) => false,
                                    );
                            },
                          ),
                        ),
                      ),
                    ),

                  /// ================= LOADER =================
                  if (isLoading) const AppLoader(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}