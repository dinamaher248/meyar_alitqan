import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../core/enums/order_status.dart';
import '../../../../shared/domain/entities/order_entity/order_entity.dart';
import '../../../data/realtime/order_realtime_service.dart';
import '../../../domain/use_cases/orders_use_case/get_technician_orders_use_case/get_technician_orders_use_case.dart';
import 'get_technician_orders_view_model_states.dart';

@injectable
class GetTechnicianOrdersViewModel
    extends Cubit<GetTechnicianOrdersViewModelStates> {
  final GetTechnicianOrdersUseCase getTechnicianOrdersUseCase;
  final OrdersRealtimeService ordersRealtimeService;

  RealtimeChannel? _channel;

  GetTechnicianOrdersViewModel(
    this.getTechnicianOrdersUseCase,
    this.ordersRealtimeService,
  ) : super(GetTechnicianOrdersViewModelInitial());

  /// ================= FETCH =================
  Future<void> getTechnicianOrders() async {
    emit(GetTechnicianOrdersViewModelLoading());

    final result = await getTechnicianOrdersUseCase.getTechnicianOrders();

    result.fold(
      (failure) => emit(GetTechnicianOrdersViewModelError(failure.message)),
      (orders) => _emitFiltered(orders),
    );
  }

  /// ================= REALTIME =================
  void startRealtime(String technicianId) {
    _channel = ordersRealtimeService.subscribeAssignedOrders(
      technicianId: technicianId,
      onChange: () {
        getTechnicianOrders();
      },
    );
  }

  void _emitFiltered(List<OrderEntity> orders) {
    final filtered = orders.where((order) {
      return order.status != OrderStatus.canceled &&
          order.status != OrderStatus.completed;
    }).toList();

    emit(GetTechnicianOrdersViewModelSuccess(filtered));
  }

  void _emitCanceledOrCompleted(List<OrderEntity> orders) {
    final filtered = orders.where((order) {
      return order.status == OrderStatus.canceled ||
          order.status == OrderStatus.completed;
    }).toList();

    emit(GetTechnicianOrdersViewModelSuccess(filtered));
  }

  Future<void> getArchivedTechnicianOrders() async {
    emit(GetTechnicianOrdersViewModelLoading());

    final result = await getTechnicianOrdersUseCase.getTechnicianOrders();

    result.fold(
      (failure) => emit(GetTechnicianOrdersViewModelError(failure.message)),
      (orders) => _emitCanceledOrCompleted(orders),
    );
  }

  Future<void> getCompletedOrders() async {
    emit(GetTechnicianOrdersViewModelLoading());

    final result = await getTechnicianOrdersUseCase.getTechnicianOrders();

    result.fold(
      (failure) => emit(GetTechnicianOrdersViewModelError(failure.message)),
      (orders) {
        final completed = orders
            .where((o) => o.status == OrderStatus.completed)
            .toList();

      if(!isClosed) {
        emit(GetTechnicianOrdersViewModelSuccess(completed));
      }
      },
    );
  }

  Future<void> getCanceledOrders() async {
    emit(GetTechnicianOrdersViewModelLoading());

    final result = await getTechnicianOrdersUseCase.getTechnicianOrders();

    result.fold(
      (failure) => emit(GetTechnicianOrdersViewModelError(failure.message)),
      (orders) {
        final canceled = orders
            .where((o) => o.status == OrderStatus.canceled)
            .toList();

        emit(GetTechnicianOrdersViewModelSuccess(canceled));
      },
    );
  }

  void stopRealtime() {
    if (_channel != null) {
      ordersRealtimeService.unsubscribe(_channel!);
      _channel = null;
    }
  }

  @override
  Future<void> close() {
    stopRealtime();
    return super.close();
  }
}
