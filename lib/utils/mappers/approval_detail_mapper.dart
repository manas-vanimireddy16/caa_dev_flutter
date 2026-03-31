class ApprovalDetailMapper {
  static Map<String, dynamic> normalize(Map<String, dynamic> json) {
    final Map<String, dynamic> normalized = Map.from(json);

    /// 🔥 Handle department
    if (normalized['department_id'] is Map<String, dynamic>) {
      normalized['department'] = normalized['department_id'];
      normalized['department_id'] = normalized['department']['id'];
    }

    /// 🔥 Handle section
    if (normalized['section_id'] is Map<String, dynamic>) {
      normalized['section'] = normalized['section_id'];
      normalized['section_id'] = normalized['section']['id'];
    }

    return normalized;
  }
}
