String sanitizeFileName(String original) {
  final name = original
      .toLowerCase()
      .replaceAll(RegExp(r'[^\w\.\-]'), '_');
  return name;
}
