import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  String get requestDetailScreenTitle => _t('Request Detail', 'تفاصيل الطلب');

  String get requestDetailsTabLabel => _t('Request Details', 'تفاصيل الطلب');

  String get routingHistoryTabLabel => _t('Routing History', 'سجل التوجيه');

  String get attachmentsTabLabel => _t('Attachments', 'المرفقات');

  String get workFlowTabLabel => _t('Work Flow', 'سير العمل');

  String get coverageInformationSection =>
      _t('Coverage Information', 'معلومات التغطية');

  String get technicalDetailsSection =>
      _t('Technical Details', 'التفاصيل الفنية');

  String notAvailableValue() => _t('N/A', 'غير متاح');

  String formatDetailDate(String? raw) {
    if (raw == null || raw.isEmpty || raw == 'N/A') {
      return notAvailableValue();
    }
    try {
      final dt = DateTime.parse(raw).toLocal();
      return DateFormat.yMMMd(isArabic ? 'ar' : 'en').format(dt);
    } catch (_) {
      return raw;
    }
  }

  /// Approval row on request details (align wording with KPI "Closed" where applicable).
  String detailApprovalStatus(String status) {
    final n = status.toLowerCase().trim();
    if (n == 'closed') return _t('Closed', 'مغلق');
    return statusLabel(status);
  }

  String securityThreatPhoneValidationError() =>
      _t('Phone number must be 8 digits', 'يجب أن يكون رقم الهاتف 8 أرقام');

  /// Shown while typing until the field has exactly 8 digits.
  String get securityThreatPhoneDigitsHint =>
      _t('Please enter 8 digits', 'يرجى إدخال 8 أرقام');

  String get requestWorkflowSectionTitle =>
      _t('Request Workflow', 'سير عمل الطلب');

  String get workflowActionTakenBy =>
      _t('Action taken by', 'تم الإجراء بواسطة');

  String workflowEmployeeIdLine(String id) =>
      _t('Employee ID: $id', 'رقم الموظف: $id');

  String get commentsRoutingOverviewTitle => _t(
        'Comments / Routing Overview',
        'التعليقات / نظرة عامة على التوجيه',
      );

  String get routingTileDateTime => _t('Date / Time', 'التاريخ / الوقت');

  String get routingTileRole => _t('Role', 'الدور');

  String get routingTileAction => _t('Action', 'الإجراء');

  String get routingTileStatus => _t('Status', 'الحالة');

  String get noCommentsYet => _t('No comments yet', 'لا توجد تعليقات بعد');

  String get noAttachmentsAvailable =>
      _t('No attachments available', 'لا توجد مرفقات');

  String attachmentSizeLine(String size) => _t('Size: $size', 'الحجم: $size');

  String attachmentUploadedByLine(String name) =>
      _t('Uploaded by: $name', 'تم الرفع بواسطة: $name');

  String attachmentUploadedAtLine(String at) =>
      _t('Uploaded at: $at', 'تاريخ الرفع: $at');

  String get attachmentUnknownFile =>
      _t('Unknown File', 'ملف غير معروف');

  String get routingAddCommentHint =>
      _t('Add a comment...', 'أضف تعليقاً...');

  String get needMoreInfo =>
      _t('Need more info', 'أحتاج المزيد من المعلومات');

  String get dynamicFormPrevious => _t('Previous', 'السابق');

  String get dynamicFormNext => _t('Next', 'التالي');

  String get dynamicFormSubmit => _t('Submit', 'إرسال');

  String dynamicFormSubtitle(String title) =>
      _t('Provide details about your $title', 'قدّم تفاصيل حول $title');

  String dynamicFormMultiSelectHint(String fieldLabel) =>
      _t('Select $fieldLabel', 'اختر $fieldLabel');

  String dynamicFormMultiSelectCount(int n) =>
      _t('$n Selected', isArabic ? 'تم اختيار $n' : '$n Selected');

  String get dynamicFormMultiSelectDone => _t('DONE', 'تم');

  String get dynamicFormSearchHint => _t('Search...', 'بحث...');

  String securityThreatSourceOfIncident(String en) {
    switch (en) {
      case 'Internal / Insider':
        return _t('Internal / Insider', 'داخلي / موظف');
      case 'External / Outsider':
        return _t('External / Outsider', 'خارجي / طرف خارجي');
      case 'System / Device':
        return _t('System / Device', 'نظام / جهاز');
      case 'Third Party / Vendor':
        return _t('Third Party / Vendor', 'طرف ثالث / مورّد');
      case 'Physical / Environmental':
        return _t('Physical / Environmental', 'مادي / بيئي');
      case 'Unknown / Under Investigation':
        return _t('Unknown / Under Investigation', 'غير معروف / قيد التحقيق');
      case 'Others':
        return _t('Others', 'أخرى');
      default:
        return en;
    }
  }

  String securityThreatIncidentType(String en) {
    switch (en) {
      case 'Denial of Service':
        return _t('Denial of Service', 'رفض الخدمة');
      case 'Unauthorized Use / Access / Use of Data / Compromised User Account':
        return _t(
          'Unauthorized Use / Access / Use of Data / Compromised User Account',
          'استخدام غير مصرح به / الوصول / استخدام البيانات / حساب مستخدم مُخترق',
        );
      case 'Unauthorized changes to systems, software, or data':
        return _t(
          'Unauthorized changes to systems, software, or data',
          'تغييرات غير مصرح بها على الأنظمة أو البرامج أو البيانات',
        );
      case 'Malicious Code':
        return _t('Malicious Code', 'كود ضار');
      case 'Unplanned Downtime':
        return _t('Unplanned Downtime', 'توقف غير مخطط');
      case 'Loss or Theft of equipment':
        return _t('Loss or Theft of equipment', 'فقدان أو سرقة المعدات');
      case 'Ransomware Attacks':
        return _t('Ransomware Attacks', 'هجمات برمجيات الفدية');
      case 'Physical Security Breach':
        return _t('Physical Security Breach', 'اختراق أمني مادي');
      case 'Leakage of Secret or Top Secret Data':
        return _t(
          'Leakage of Secret or Top Secret Data',
          'تسرّب بيانات سرية أو للغاية سرية',
        );
      case 'Others':
        return _t('Others', 'أخرى');
      default:
        return en;
    }
  }

  String securityThreatThreatType(String en) {
    switch (en) {
      case 'Malware Threat':
        return _t('Malware Threat', 'تهديد برمجيات خبيثة');
      case 'Email Threat':
        return _t('Email Threat', 'تهديد عبر البريد');
      case 'Identity & Access Threat':
        return _t('Identity & Access Threat', 'تهديد الهوية والوصول');
      case 'Application & System Threat':
        return _t('Application & System Threat', 'تهديد التطبيقات والأنظمة');
      case 'Others':
        return _t('Others', 'أخرى');
      default:
        return en;
    }
  }

  String securityThreatPriority(String en) {
    switch (en) {
      case 'P1-Very Low':
        return _t('P1-Very Low', 'P1-منخفض جداً');
      case 'P2-Low':
        return _t('P2-Low', 'P2-منخفض');
      case 'P3-Moderate':
        return _t('P3-Moderate', 'P3-متوسط');
      case 'P4-High':
        return _t('P4-High', 'P4-مرتفع');
      case 'P5-Very High':
        return _t('P5-Very High', 'P5-مرتفع جداً');
      default:
        return en;
    }
  }

  String get securityThreatFormDeptPlaceholder =>
      _t('Select Department', 'اختر القسم');

  String get securityThreatFormContactPlaceholder =>
      _t('Enter Contact Number', 'أدخل رقم الاتصال');

  String get securityThreatFormTicketPlaceholder => _t(
    'Enter request title (min 5, max 250 characters)',
    'أدخل عنوان الطلب (5 أحرف كحد أدنى، 250 كحد أقصى)',
  );

  String get securityThreatFormOtherDetailsPlaceholder => _t(
    'Enter Details (min 5, max 250 characters)',
    'أدخل التفاصيل (5 أحرف كحد أدنى، 250 كحد أقصى)',
  );

  String get securityThreatFormSelectTypeIncidentDetected =>
      _t('Select Type of Incident Detected', 'اختر نوع الحادث المكتشف');

  String get securityThreatFormDescriptionPlaceholder => _t(
    'Write here (min 3, max 250 characters)',
    'اكتب هنا (3 أحرف كحد أدنى، 250 كحد أقصى)',
  );

  String get securityThreatFormPrioritiesLabel => _t('Priorities', 'الأولويات');

  String get securityThreatFormDescLabel =>
      _t('Description / Additional Notes', 'الوصف / ملاحظات إضافية');

  String get securityThreatFormSelectPriority =>
      _t('Select Priority', 'اختر الأولوية');

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

      case 'Approval Status':
        return _t('Approval Status', 'حالة الموافقة');

      case 'Department':
        return _t('Department', 'القسم');

      case 'Section':
        return _t('Section', 'الشعبة');

      case 'Approver Name':
        return _t('Approver Name', 'اسم المعتمد');

      case 'Approver Email':
        return _t('Approver Email', 'البريد الإلكتروني للمعتمد');

      case 'Contact Number':
        return _t('Contact Number', 'رقم الاتصال');

      case 'Service Type':
        return _t('Service Type', 'نوع الخدمة');

      case 'Sub Service Type':
        return _t('Sub Service Type', 'نوع الخدمة الفرعي');

      case 'Ticket Name':
        return _t('Ticket Name', 'اسم التذكرة');

      case 'Source of Incident Detected':
        return _t('Source of Incident Detected', 'مصدر الحادث المكتشف');

      case 'Type Of Threat':
        return _t('Type Of Threat', 'نوع التهديد');

      case 'Type of Incident Detected':
        return _t('Type of Incident Detected', 'نوع الحادث المكتشف');

      case 'Extension Number':
        return _t('Extension Number', 'رقم التحويلة');

      case 'Status Information':
        return _t('Status Information', 'معلومات الحالة');

      case 'Request Information':
        return _t('Request Information', 'معلومات الطلب');

      default:
        return _formatKey(key);
    }
  }
}
