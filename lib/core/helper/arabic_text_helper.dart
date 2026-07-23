import 'package:arabic_reshaper/arabic_reshaper.dart';
import 'package:bidi/bidi.dart' as bidi;

class ArabicTextHelper {
  static final ArabicReshaper _reshaper = ArabicReshaper();

  static String fix(String text) {
    if (text.trim().isEmpty) return text;

    final reshaped = _reshaper.reshape(text);

    final visualCodes = bidi.logicalToVisual(reshaped);

    return String.fromCharCodes(visualCodes);
  }
}
