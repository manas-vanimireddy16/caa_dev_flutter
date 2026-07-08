String? validateTextLength(
  dynamic value, {
  required int min,
  required int max,
  required String minMessage,
  required String maxMessage,
  bool required = true,
}) {
  final text = value?.toString().trim() ?? '';
  if (text.isEmpty) {
    return required ? null : null;
  }
  if (text.length < min) return minMessage;
  if (text.length > max) return maxMessage;
  return null;
}

String? validateOptionalTextLength(
  dynamic value, {
  required int min,
  required int max,
  required String minMessage,
  required String maxMessage,
}) {
  return validateTextLength(
    value,
    min: min,
    max: max,
    minMessage: minMessage,
    maxMessage: maxMessage,
    required: false,
  );
}
