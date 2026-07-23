import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AvatarUploadService {
  final ImagePicker _picker = ImagePicker();
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<String?> pickAndUpload(ImageSource source) async {
    final XFile? image = await _picker.pickImage(
      source: source,
      imageQuality: 80,
    );

    if (image == null) return null;

    return await _uploadXFile(image);
  }

  Future<String> _uploadXFile(XFile image) async {
    final Uint8List bytes = await image.readAsBytes(); // ✅ Web safe

    final userId = _supabase.auth.currentUser!.id;
    final fileExt = image.name.split('.').last;
    final filePath = 'avatars/$userId/avatar.$fileExt';

    await _supabase.storage
        .from('avatars')
        .uploadBinary(
      filePath,
      bytes,
      fileOptions: FileOptions(
        contentType: image.mimeType ?? 'image/png',
        upsert: true,
      ),
    );

    return _supabase.storage
        .from('avatars')
        .getPublicUrl(filePath);
  }
}
