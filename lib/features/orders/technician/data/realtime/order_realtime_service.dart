import 'dart:ui';

import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
@singleton
class OrdersRealtimeService {
  final SupabaseClient _client;

  OrdersRealtimeService(this._client);

  RealtimeChannel subscribeAssignedOrders({
    required String technicianId,
    required VoidCallback onChange,
  }) {
    final channel = _client.channel('orders-realtime-$technicianId');

    // 🔔 INSERT (أي طلب جديد)
    channel.onPostgresChanges(
      event: PostgresChangeEvent.insert,
      schema: 'public',
      table: 'orders',
      callback: (_) => onChange(),
    );

    // 🔔 UPDATE (لما يتعيّن للتقني)
    channel.onPostgresChanges(
      event: PostgresChangeEvent.update,
      schema: 'public',
      table: 'orders',
      filter: PostgresChangeFilter(
        type: PostgresChangeFilterType.eq,
        column: 'technician_id',
        value: technicianId,
      ),
      callback: (_) => onChange(),
    );

    channel.subscribe();
    return channel;
  }

  void unsubscribe(RealtimeChannel channel) {
    _client.removeChannel(channel);
  }
}
