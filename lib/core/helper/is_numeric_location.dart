bool isNumericLocation(String value) {
  final numericRegex = RegExp(r'^[0-9.,\s-]+$');
  return numericRegex.hasMatch(value);
}
