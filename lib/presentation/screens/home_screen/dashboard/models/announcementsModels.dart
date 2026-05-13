import 'dart:convert';

class AnnouncementModel {
  final String? title;
  final String? fieldActiveAnnouncementFrom;
  final String? fieldActiveAnnouncementTo;
  final String? fieldAnnouncementCaaContent;
  final String? fieldAnnouncementCaaPriority;
  final String? fieldAnnouncementCaaStatus;
  final String? fieldAnnouncementCaaTitle;
  final String? fieldBanner;
  final String? fieldCreatedAnnouncementOn;
  final String? nid;

  AnnouncementModel({
    this.title,
    this.fieldActiveAnnouncementFrom,
    this.fieldActiveAnnouncementTo,
    this.fieldAnnouncementCaaContent,
    this.fieldAnnouncementCaaPriority,
    this.fieldAnnouncementCaaStatus,
    this.fieldAnnouncementCaaTitle,
    this.fieldBanner,
    this.fieldCreatedAnnouncementOn,
    this.nid,
  });

  /// ✅ Factory constructor to parse JSON
  factory AnnouncementModel.fromJson(Map<String, dynamic> json) {
    return AnnouncementModel(
      title: stripHtmlTags(json['title']) as String?,
      fieldActiveAnnouncementFrom:
          json['field_active_announcement_from'] as String?,
      fieldActiveAnnouncementTo:
          json['field_active_announcement_to'] as String?,
      fieldAnnouncementCaaContent:
          json['field_announcement_caa_content'] as String?,
      fieldAnnouncementCaaPriority:
          json['field_announcement_caa_priority'] as String?,
      fieldAnnouncementCaaStatus:
          json['field_announcement_caa_status'] as String?,
      fieldAnnouncementCaaTitle:
          json['field_announcement_caa_title'] as String?,
      fieldBanner: json['field_caa_banner'] as String?,
      fieldCreatedAnnouncementOn:
          json['field_created_announcement_on'] as String?,
      nid: json['nid'] as String?,
    );
  }

  /// ✅ Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'field_active_announcement_from': fieldActiveAnnouncementFrom,
      'field_active_announcement_to': fieldActiveAnnouncementTo,
      'field_announcement_caa_content': fieldAnnouncementCaaContent,
      'field_announcement_caa_priority': fieldAnnouncementCaaPriority,
      'field_announcement_caa_status': fieldAnnouncementCaaStatus,
      'field_announcement_caa_title': fieldAnnouncementCaaTitle,
      'field_caa_banner': fieldBanner,
      'field_created_announcement_on': fieldCreatedAnnouncementOn,
      'nid': nid,
    };
  }

  /// ✅ Helper method to parse list of announcements
  static List<AnnouncementModel> fromJsonList(String jsonString) {
    final data = json.decode(jsonString);
    return List<AnnouncementModel>.from(
      data.map((item) => AnnouncementModel.fromJson(item)),
    );
  }
}

String stripHtmlTags(String htmlString) {
  return htmlString.replaceAll(RegExp(r'<[^>]*>'), '');
}
