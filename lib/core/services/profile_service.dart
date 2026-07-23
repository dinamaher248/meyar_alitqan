import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileService {
  static Future<void> updatePhone(String phone) async {
    final user = Supabase.instance.client.auth.currentUser;

    if (user == null) {
      throw Exception('User not logged in');
    }

    await Supabase.instance.client
        .from('users_profile')
        .update({'phone': phone})
        .eq('id', user.id);
  }
}
