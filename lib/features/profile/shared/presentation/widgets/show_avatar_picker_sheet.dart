import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void showAvatarPicker(
    BuildContext context, {
      required VoidCallback onCamera,
      required VoidCallback onGallery,
    }) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if(!kIsWeb)
        ListTile(
          leading: const Icon(Icons.camera_alt),
          title:   Text('التقاط صورة',),
          onTap: () {
            Navigator.pop(context);
            onCamera();
          },
        ),

        ListTile(
          leading:   Icon(Icons.photo,size: 20,),
          title:   Text('اختيار من المعرض',style:  TextStyle(
            fontSize: 16
          ),),
          onTap: () {
            Navigator.pop(context);
            onGallery();
          },
        ),
        if(kIsWeb) SizedBox(height: 20,)
      ],
    ),
  );
}
