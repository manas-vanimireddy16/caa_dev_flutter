bool isNotificationWorkflowStep({
  String? content,
  String? contentAr,
  String? status,
  String? statusAr,
}) {
  for (final candidate in [content, contentAr, status, statusAr]) {
    final normalized = candidate?.trim().toLowerCase() ?? '';
    if (normalized.contains('notification sent') ||
        normalized.contains('email / notification')) {
      return true;
    }
  }
  return false;
}
