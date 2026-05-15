import 'package:flutter/material.dart';

/// Localized labels for service dashboard screens (EN / AR).
class DashboardL10n {
  DashboardL10n._(this._languageCode);

  final String _languageCode;

  bool get isArabic => _languageCode == 'ar';

  factory DashboardL10n.of(BuildContext context) {
    return DashboardL10n._(Localizations.localeOf(context).languageCode);
  }

  String _t(String en, String ar) => isArabic ? ar : en;

  // ── Section titles ────────────────────────────────────────────────────────
  String get requestsStatusBreakdown =>
      _t('Request Status Breakdown', 'تحليل حالة الطلب');

  String get requestTrendBreakdown =>
      _t('Request Trend Breakdown', 'تحليل اتجاهات الطلب');

  String get breakdown => _t('Breakdown', 'التحليل');

  String get totalRequests => _t('Total Requests', 'إجمالي الطلبات');

  String get totalTickets => _t('Total Tickets', 'إجمالي التذاكر');

  String get ticketRequests => _t('Ticket Requests', 'طلبات التذاكر');

  String get newRequest => _t('New Request', 'طلب جديد');

  String get searchByIdOrName =>
      _t('Search by ID or Name', 'البحث حسب المعرف أو الاسم');

  String get myRequests => _t('My Requests', 'طلباتي');

  String get actionItems => _t('Action Items', 'عناصر الإجراءات');

  String get noDataFound => _t('No Data Found', 'لا توجد بيانات');

  String get select => _t('Select', 'اختر');

  String get reportSecurityThreat =>
      _t('Report Security Threat', 'الإبلاغ عن تهديد أمني');
  String get myProfile => _t('My Profile', 'ملفي الشخصي');

  String get findTheProfileDetails =>
      _t('Find the Profile Details', 'البحث عن تفاصيل الملف الشخصي');

  String get announcements => _t('Announcements', 'الإعلانات');

  String get announcementsSubtext =>
      _t('Stay informed with latest updates', 'ابقَ على اطلاع بآخر التحديثات');

  String get settings => _t('Settings', 'الأمان');

  String get services => _t('Services', 'الخدمات');

  String get home => _t('Home', 'الصفحة الرئيسية');

  String get selectRole => _t('Select Role', 'اختر الدور');

  String get logout => _t('Logout', 'تسجيل الخروج');

  String securityNavTitle(int index) {
    switch (index) {
      case 0:
        return _t('Dashboard', 'لوحة القيادة');
      case 1:
        return reportSecurityThreat;
      case 2:
        return _t(
          'Request to Organize Security Awareness',
          'طلب تنظيم التوعية الأمنية',
        );
      case 3:
        return _t('Request for Project Approval', 'طلب الموافقة على المشروع');
      case 4:
        return _t(
          'Request for VAPT and Infrastructure Review',
          'طلب مراجعة اختبار الاختراق والبنية التحتية',
        );
      case 5:
        return _t(
          'Request for Internal Audit (Cyber Security Audit)',
          'طلب التدقيق الداخلي (تدقيق الأمن السيبراني)',
        );
      case 6:
        return _t(
          'Cyber Security Risk Management',
          'إدارة مخاطر الأمن السيبراني',
        );
      default:
        return _t('Home', 'الرئيسية');
    }
  }

  String requestIdLabel(String id) => _t('Request ID: $id', 'رقم الطلب: $id');

  // ── Filter periods ────────────────────────────────────────────────────────
  List<String> get periodFilterLabels => [
    _t('Weekly', 'أسبوعي'),
    _t('Monthly', 'شهري'),
    _t('Quarterly', 'ربع سنوي'),
    _t('Yearly', 'سنوي'),
  ];

  String periodFilterValue(String localizedLabel) {
    final index = periodFilterLabels.indexOf(localizedLabel);
    const enValues = ['weekly', 'monthly', 'quarterly', 'yearly'];
    if (index >= 0 && index < enValues.length) return enValues[index];
    return localizedLabel.toLowerCase();
  }

  String periodFilterLabelFromApi(String apiValue) {
    const enValues = ['weekly', 'monthly', 'quarterly', 'yearly'];
    final index = enValues.indexOf(apiValue.toLowerCase());
    if (index >= 0) return periodFilterLabels[index];
    return apiValue;
  }

  // ── KPI stat keys ─────────────────────────────────────────────────────────
  String statTitle(String key, {bool isSecurityThreat = false}) {
    final normalized = key.toLowerCase().replaceAll('_', '');

    if (isSecurityThreat && normalized == 'approved') {
      return _t('Closed', 'مغلق');
    }

    switch (normalized) {
      case 'totalapprovals':
        return _t('Total Approvals', 'إجمالي الموافقات');
      case 'totalrequests':
      case 'total':
        return _t('Total Requests', 'إجمالي الطلبات');
      case 'closed':
        return _t('Closed', 'مغلق');
      case 'approved':
        return _t('Approved', 'موافق');
      case 'pending':
        return _t('Pending', 'قيد الانتظار');
      case 'rejected':
        return _t('Rejected', 'مرفوض');
      case 'expired':
        return _t('Expired', 'منتهي');
      case 'open':
        return _t('Open', 'مفتوح');
      case 'inprogress':
        return _t('In Progress', 'قيد التنفيذ');
      default:
        return _formatKey(key);
    }
  }

  String _formatKey(String key) {
    final withSpaces = key
        .replaceAllMapped(
          RegExp(r'([a-z])([A-Z])'),
          (match) => '${match.group(1)} ${match.group(2)}',
        )
        .replaceAll('_', ' ');
    return withSpaces.replaceAllMapped(
      RegExp(r'\b\w'),
      (match) => match.group(0)!.toUpperCase(),
    );
  }

  // ── Request status (API → display) ──────────────────────────────────────
  String statusLabel(String status) {
    switch (status.toLowerCase().trim()) {
      case 'approved':
        return _t('Approved', 'تمت الموافقة');
      case 'closed':
        return _t('Close Request', 'إغلاق الطلب');
      case 'pending':
        return _t('Pending', 'قيد الانتظار');
      case 'rejected':
        return _t('Rejected', 'مرفوض');
      case 'in progress':
        return _t('In Progress', 'قيد التنفيذ');
      case 'draft':
        return _t('Draft', 'مسودة');
      case 'open':
        return _t('Open', 'مفتوح');
      case 'completed':
        return _t('Completed', 'مكتمل');
      case 'total':
        return _t('Total', 'إجمالي');
      default:
        return status;
    }
  }

  // ── Request card field labels ─────────────────────────────────────────────
  String fieldLabel(String key) {
    switch (key) {
      case 'Request Id':
        return _t('Request Id', 'رقم الطلب');
      case 'Request By':
        return _t('Request By', 'طلب بواسطة');
      case 'Date':
        return _t('Date', 'التاريخ');
      case 'Request Type':
        return _t('Request Type', 'نوع الطلب');
      case 'Priority':
        return _t('Priority', 'الأولوية');
      case 'Type Of Threat':
        return _t('Type Of Threat', 'نوع التهديد');
      case 'Approver':
        return _t('Approver', 'الموافق');
      default:
        return _formatKey(key);
    }
  }

  String requestDetailsLabel(String key) {
    switch (key) {
      case 'status_information':
        return _t('Status Information', 'معلومات الحالة');

      case 'assigned_to':
        return _t('Assigned To', 'معين الى');

      case 'Status':
        return _t('Status', 'الحالة');

      case 'section_name':
        return _t('Section Name', 'اسم القسم');

      case 'requested_date':
        return _t('Requested Date', 'تاريخ الطلب');

      case 'request_information':
        return _t('Request Information', 'معلومات الطلب');

      case 'ticket_name':
        return _t('Ticket Name', 'اسم التذكرة');

      case 'enter_ticket_name':
        return _t('Enter Ticket Name', 'أدخل اسم التذكرة');

      case 'source_of_incident':
        return _t('Source of Incident', 'مصدر الحادث');

      case 'specify_source_of_incident':
        return _t(
          'Please specify the source of incident',
          'يرجى تحديد مصدر الحادث',
        );

      case 'type_of_incident_detected':
        return _t('Type of Incident Detected', 'نوع الحادث المكتشف');

      case 'specify_type_of_incident':
        return _t(
          'Please specify the type of incident',
          'يرجى تحديد نوع الحادث',
        );

      case 'incident_ticket_number':
        return _t('Incident Ticket Number', 'رقم تذكرة الحادث');

      case 'denial_of_service':
        return _t('Denial of Service', 'رفض الخدمة');

      case 'unauthorized_use_access_data_compromised_account':
        return _t(
          'Unauthorized Use / Access / Use of Data / Compromised User Account',
          'استخدام غير مصرح به / الوصول / استخدام البيانات / حساب المستخدم المخترق',
        );

      case 'unauthorized_changes_systems_software_data':
        return _t(
          'Unauthorized changes to systems, software, or data',
          'تغييرات غير مصرح بها على الأنظمة أو البرامج أو البيانات',
        );

      case 'malicious_code':
        return _t('Malicious Code', 'كود ضار');

      case 'type_of_threat':
        return _t('Type Of Threat', 'نوع التهديد');

      case 'service_type':
        return _t('Service Type', 'نوع الخدمة');

      case 'Priority':
        return _t('Priority', 'الأولوية');

      case 'description':
        return _t('Description', 'الوصف');

      default:
        return _formatKey(key);
    }
  }
}
