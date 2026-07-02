/// Picks Arabic label when available and [isArabic] is true; otherwise English.
String localizedDisplayName({
  required bool isArabic,
  String? english,
  String? arabic,
}) {
  if (isArabic) {
    final trimmed = arabic?.trim();
    if (trimmed != null && trimmed.isNotEmpty) {
      return trimmed;
    }
  }
  return english?.trim() ?? '';
}
