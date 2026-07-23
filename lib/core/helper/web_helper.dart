// web_helper.dart
import 'dart:html' as html;

void clearUrl(String url) {
  html.window.history.replaceState(null, '', url);
}