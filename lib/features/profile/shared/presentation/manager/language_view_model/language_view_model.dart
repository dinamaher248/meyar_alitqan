import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class LanguageCubit extends Cubit<Locale> {
  static const _key = 'lang';

  LanguageCubit() : super(const Locale('en')) {
    loadLanguage();
  }

  Future<void> loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();

    // لو المستخدم اختار لغة قبل كده
    final savedLang = prefs.getString(_key);
    if (savedLang != null) {
      emit(Locale(savedLang));
      return;
    }

    // غير كده → لغة الجهاز
    final deviceLang =
        PlatformDispatcher.instance.locale.languageCode;

    // ندعم en / ar فقط
    final supported =
    deviceLang == 'ar' || deviceLang == 'en'
        ? deviceLang
        : 'en';

    emit(Locale(supported));
  }

  Future<void> changeLanguage(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, code);
    emit(Locale(code));
  }
}
