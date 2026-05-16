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

  String get requestDetailScreenTitle => _t('Request Details', 'تفاصيل الطلب');

  String get requestDetailsTabLabel => _t('Request Details', 'تفاصيل الطلب');

  String get routingHistoryTabLabel => _t('Routing History', 'سجل التوجيه');

  String get attachmentsTabLabel => _t('Attachments', 'المرفقات');

  String get workFlowTabLabel => _t('Work Flow', 'مسار العمل ');

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
      _t('Min should be 8 digits', 'يرجى إدخال 8 أرقام');
  String get securityThreatTicketNameHint =>
      _t('Must be at least 5 characters', 'يجب ألا يقل عن 5 أحرف');

  String get requestWorkflowSectionTitle =>
      _t('Request Workflow', 'سير عمل الطلب');

  String get workflowActionTakenBy =>
      _t('Action taken by', 'تم الإجراء بواسطة');

  String workflowEmployeeIdLine(String id) =>
      _t('Employee ID: $id', 'رقم الموظف: $id');

  String get commentsRoutingOverviewTitle =>
      _t('Comments & Actions', 'التعليقات / نظرة عامة على');

  String get routingTileDateTime => _t('Date / Time', 'التاريخ / الوقت');

  String get routingTileRole => _t('Role / Authority', 'الدور / الصلاحية');

  String get routingTileAction => _t('Action', 'الإجراء');

  String get routingTileStatus => _t('Requested Status', 'الحالة المطلوبة');

  String get noCommentsYet => _t('No comments yet', 'التعليقات والإجراءات');

  String get noAttachmentsAvailable =>
      _t('No attachments available', 'لا توجد مرفقات');

  String attachmentSizeLine(String size) => _t('Size: $size', 'الحجم: $size');

  String attachmentUploadedByLine(String name) =>
      _t('Uploaded by: $name', 'تم الرفع بواسطة: $name');

  String attachmentUploadedAtLine(String at) =>
      _t('Uploaded at: $at', 'تاريخ الرفع: $at');

  String get attachmentUnknownFile => _t('Unknown File', 'ملف غير معروف');

  String get routingAddCommentHint => _t('Add a comment...', 'أضف تعليقاً...');

  String get needMoreInfo => _t('Need more info', 'أحتاج المزيد من المعلومات');

  String get commentButtonAssign => _t('Assign', 'تعيين');

  String get commentButtonApprove => _t('Approve', 'موافقة');

  String get commentButtonReject => _t('Reject', 'رفض');

  String get commentButtonAllocateVehicle =>
      _t('Allocate Vehicle', 'تخصيص مركبة');

  String get commentButtonReassign => _t('Reassign', 'إعادة تعيين');

  String get commentButtonClose => _t('Close', 'إغلاق');

  String get commentButtonReplace => _t('Replace', 'استبدال');

  String get commentButtonInProgress => _t('In Progress', 'قيد التنفيذ');

  String get commentButtonComplete => _t('Complete', 'إكمال');

  // ── Foreign employee transportation ─────────────────────────────────────
  String get transportForeignEmployeeNewRequest =>
      _t('Transportation for Foreign Employee', 'نقل الموظفين الأجانب');

  String get transportFormStepPassengers =>
      _t('Passenger details', 'تفاصيل الركاب');

  String get transportFormStepTripDetails =>
      _t('Trip details', 'تفاصيل الرحلة');

  String get transportNoOfPassengers => _t('No of Passengers', 'عدد الركاب');

  String get transportPassengerNameSection =>
      _t('Name of the Passenger', 'اسم الراكب');

  String get transportAddPassenger => _t('Add Passenger', 'إضافة راكب');

  String transportPassengerNameHint(int index) =>
      _t('Enter passenger $index name', 'أدخل اسم الراكب $index');

  String get transportPurpose => _t('Purpose', 'الغرض');

  String get transportPurposePlaceholder =>
      _t('Enter purpose of travel', 'أدخل غرض السفر');

  String get transportRequestType => _t('Request Type', 'نوع الطلب');

  String get transportEmployeePassport =>
      _t('Employee ID / Passport Number', 'رقم الموظف / جواز السفر');

  String get transportEnterId => _t('Enter ID', 'أدخل الرقم');

  String get transportOriginCity => _t('Origin City', 'مدينة المغادرة');

  String get transportEnterCity => _t('Enter City', 'أدخل المدينة');

  String get transportDestinationCity =>
      _t('Destination City / Location', 'مدينة / موقع الوجهة');

  String get transportEnterDestination =>
      _t('Enter Destination', 'أدخل الوجهة');

  String get transportVehicleRequiredLocation =>
      _t('Vehicle Required Location', 'موقع الحاجة للمركبة');

  String get transportInsideMuscat => _t('Inside Muscat', 'داخل مسقط');

  String get transportOutsideMuscat => _t('Outside Muscat', 'خارج مسقط');

  String get transportArrivalDepartureDate =>
      _t('Arrival / Departure Date', 'تاريخ الوصول / المغادرة');

  String get transportArrivalDepartureTime =>
      _t('Arrival / Departure Time', 'وقت الوصول / المغادرة');

  String get transportSpecialInstructions =>
      _t('Special Instructions', 'تعليمات خاصة');

  String get transportSpecialInstructionsPlaceholder => _t(
    'Write here (min 5, max 250 characters)',
    'اكتب هنا (5 أحرف كحد أدنى، 250 كحد أقصى)',
  );

  String get transportTravelItinerary =>
      _t('Travel Itinerary / Invitation', 'خط سير الرحلة / الدعوة');

  String get transportContactNumber => _t('Contact Number', 'رقم الاتصال');

  String get transportPassengerNameMinLength => _t(
    'Passenger name must be more than 2 letters',
    'يجب أن يكون اسم الراكب أكثر من حرفين',
  );

  String get transportAllocateVehicleTitle =>
      _t('Allocate Vehicle', 'تخصيص مركبة');

  String get transportApproveVehicleRequestTitle =>
      _t('Approve Vehicle Request', 'الموافقة على طلب المركبة');

  String get transportDriverName => _t('Driver Name', 'اسم السائق');

  String get transportDriverNameHint =>
      _t('Enter Driver Name', 'أدخل اسم السائق');

  String get transportVehicleNumber => _t('Vehicle Number', 'رقم المركبة');

  String get transportSelectVehicleNumber =>
      _t('Please select vehicle number', 'يرجى اختيار رقم المركبة');

  String get transportFuelCard => _t('Fuel Card', 'بطاقة الوقود');

  String get transportYes => _t('Yes', 'نعم');

  String get transportNo => _t('No', 'لا');

  String get transportVehicleReturnDate =>
      _t('Vehicle Return Date', 'تاريخ إرجاع المركبة');

  String get transportVehicleReturnTime =>
      _t('Vehicle Return Time', 'وقت إرجاع المركبة');

  String get transportSelectReturnDate =>
      _t('Please select return date', 'يرجى اختيار تاريخ الإرجاع');

  String get transportSelectReturnTime =>
      _t('Please select return time', 'يرجى اختيار وقت الإرجاع');

  String get transportVehicleCondition =>
      _t('Vehicle Condition', 'حالة المركبة');

  String get transportSelectVehicleCondition =>
      _t('Please select vehicle condition', 'يرجى اختيار حالة المركبة');

  String get transportReason => _t('Reason', 'السبب');

  String get transportEnterReason => _t('Enter reason', 'أدخل السبب');

  String get transportReasonRequired =>
      _t('Please enter reason', 'يرجى إدخال السبب');

  String get transportCommentsOptional =>
      _t('Comments (Optional)', 'ملاحظات (اختياري)');

  String get transportAddComments => _t('Add your comments', 'أضف ملاحظاتك');

  String get transportFormCancel => _t('CANCEL', 'إلغاء');

  String get transportFormSubmit => _t('SUBMIT', 'إرسال');

  String transportRequestTypeOption(String en) {
    switch (en) {
      case 'New Request':
        return _t('New Request', 'طلب جديد');
      case 'Extension of Previous Request':
        return _t('Extension of Previous Request', 'تمديد طلب سابق');
      default:
        return en;
    }
  }

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

  String securityThreatIncidentType(String en) {
    switch (en) {
      case 'Denial of Service':
        return _t('Denial of Service', 'رفض الخدمة');

      case 'Unauthorized Use / Access / Use of Data / Compromised User Account':
        return _t(
          'Unauthorized Use / Access / Use of Data / Compromised User Account',
          'استخدام غير مصرح به / الوصول / استخدام البيانات / حساب المستخدم المخترق',
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
        return _t('Physical Security Breach', 'خرق الأمن المادي');

      case 'Leakage of Secret or Top Secret Data':
        return _t(
          'Leakage of Secret or Top Secret Data',
          'تسريب البيانات السرية أو السرية للغاية',
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
        return _t('Malware Threat', 'تهديد البرمجيات الخبيثة');

      case 'Email Threat':
        return _t('Email Threat', 'تهديد البريد الإلكتروني');

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

  String securityThreatSourceOfIncident(String en) {
    switch (en) {
      case 'Internal / Insider':
        return _t('Internal / Insider', 'داخلي / من داخل المؤسسة');

      case 'External / Outsider':
        return _t('External / Outsider', 'خارجي');

      case 'System / Device':
        return _t('System / Device', 'النظام أو الجهاز نفسه');

      case 'Third Party / Vendor':
        return _t('Third Party / Vendor', 'طرف ثالث / مزود خدمة');

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

  String securityThreatPriority(String en) {
    switch (en) {
      case 'P1-Very Low':
        return _t('P1-Very Low', 'P1 - منخفض جداً');

      case 'P2-Low':
        return _t('P2-Low', 'P2 - منخفض');

      case 'P3-Moderate':
        return _t('P3-Moderate', 'P3 - متوسط');

      case 'P4-High':
        return _t('P4-High', 'P4 - مرتفع');

      case 'P5-Very High':
        return _t('P5-Very High', 'P5 - مرتفع جداً');

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
    'أدخل عنوان الطلب (5 أحرف كحد أدنى و250 كحد أقصى)',
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
      _t('Description / Additional Notes', 'الوصف / الملاحظات الإضافية');

  String get securityThreatFormSelectPriority =>
      _t('Select Priority', 'اختر الأولوية');

  String get securityThreatCloseFormActionTitle =>
      _t('Action Text', 'نص الإجراء');

  String get securityThreatCloseFormCommentsLabel =>
      _t('Comments (Optional)', 'التعليقات (اختياري)');

  String get securityThreatCloseFormCommentsHint =>
      _t('Enter comments', 'أدخل التعليقات');

  String get securityThreatCloseFormIncidentNotificationLabel =>
      _t('Incident Notification in CAA', 'إشعار الحادث في هيئة الطيران المدني');

  String get securityThreatCloseFormHeadInfoSec =>
      _t('Head of Information Security', 'رئيس أمن المعلومات');

  String get securityThreatCloseFormDirectorIt =>
      _t('Director of Information Technology', 'مدير تقنية المعلومات');

  String get securityThreatCloseFormLegalDept =>
      _t('Legal Department', 'الإدارة القانونية');

  String get securityThreatCloseFormHeadInfra =>
      _t('Head of Infrastructure', 'رئيس البنية التحتية');

  String get securityThreatCloseFormIdentificationLabel =>
      _t('Identification Measures', 'تدابير التحديد');

  String get securityThreatCloseFormIdentificationHint =>
      _t('Enter identification measures', 'أدخل تدابير التحديد');

  String get securityThreatCloseFormEvidenceHint =>
      _t('Enter evidence collected', 'أدخل الأدلة المجمعة');

  String get securityThreatCloseFormEradicationLabel =>
      _t('Eradication / Mitigation Measures', 'تدابير القضاء / التخفيف');

  String get securityThreatCloseFormEradicationHint =>
      _t('Enter mitigation measures', 'أدخل تدابير التخفيف');

  String get securityThreatCloseFormRecoveryLabel =>
      _t('Recovery Measures', 'تدابير الاستعادة');

  String get securityThreatCloseFormRecoveryHint =>
      _t('Enter recovery measures', 'أدخل تدابير الاستعادة');

  String get securityThreatCloseFormOtherMitigationHint =>
      _t('Enter other mitigation measures', 'أدخل تدابير التخفيف الأخرى');

  String get securityThreatCloseFormFieldRequired =>
      _t('This field is required', 'هذا الحقل مطلوب');

  String get securityThreatCloseFormCancel => _t('CANCEL', 'إلغاء');

  String get securityThreatCloseFormSubmit => _t('SUBMIT', 'إرسال');

  String get reportSecurityThreat =>
      _t('Report Security Threat', 'الإبلاغ عن تهديد أمني');
  String get myProfile => _t('My Profile', 'ملفي الشخصي');

  String get findTheProfileDetails =>
      _t('Find the Profile Details', 'البحث عن تفاصيل الملف الشخصي');

  String get announcements => _t('Announcements', 'الإعلانات');

  String get announcementsSubtext =>
      _t('Stay informed with latest updates', 'ابقَ على اطلاع بآخر التحديثات');

  String get profileEmailLabel => _t('Email', 'البريد الإلكتروني');

  String get profilePhoneLabel => _t('Phone', 'الهاتف');

  String get profileLocationLabel => _t('Location', 'الموقع');

  String get profileRoleLabel => _t('Role', 'الدور');

  String get settings => _t('Settings', 'الإعدادات');

  String get services => _t('Services', 'الخدمات');

  String get home => _t('Home', 'الصفحة الرئيسية');

  String get selectRole => _t('Select Role', 'اختر الدور');

  String get logout => _t('Logout', 'تسجيل الخروج');

  String get languageLabel => _t('Language', 'اللغة');

  String get selectLanguageHint => _t('Select language', 'اختر اللغة');

  String get accountSectionTitle => _t('Account', 'الحساب');

  String get chooseActiveRoleHint =>
      _t('Choose your active role', 'اختر دورك النشط');
  String get securityThreatCloseFormOtherMitigationLabel => _t(
    'Identification Measures (Incident Verified, Assessed, Options Evaluated, Containment Measures):',
    'إجراءات التعريف (تم التحقق من الحادث، تم التقييم، تم تقييم الخيارات، إجراءات الاحتواء):',
  );

  String get securityThreatCloseFormEvidenceLabel => _t(
    'Evidence Collected (system logs, audit logs, Png, etc.):',
    'الأدلة المجمعة (سجلات النظام، سجلات التدقيق، PNG، إلخ):',
  );

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
        return _t('Approver', 'المُعتمد');
      case 'Vehicle Location':
        return _t('Vehicle Location', 'موقع المركبة');
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
        return _t('Department', 'الدائرة');

      case 'Section':
        return _t('Section', 'القسم');

      case 'Approver Name':
        return _t('Approver Name', 'اسم المعتمد');

      case 'Approver Email':
        return _t('Approver Email', 'البريد الإلكتروني للمعتمد');

      case 'Contact Number':
        return _t('Contact Number', 'رقم التواصل');

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
        return _t('Extension Number', 'رقم المحول');

      case 'Purpose of Travel':
        return _t('Purpose of Travel', 'غرض السفر');

      case 'No of Passengers':
        return _t('No of Passengers', 'عدد الركاب');

      case 'Arrival/Departure Date & Time':
        return _t(
          'Arrival/Departure Date & Time',
          'تاريخ ووقت الوصول / المغادرة',
        );

      case 'Vehicle Required Location':
        return _t('Vehicle Required Location', 'موقع الحاجة للمركبة');

      case 'Vehicle Location':
        return _t('Vehicle Location', 'موقع المركبة');

      case 'Requested Date':
        return _t('Requested Date', 'تاريخ الطلب');

      case 'Description':
        return _t('Description', 'الوصف');

      case 'Status Information':
        return _t('Status Information', 'معلومات الحالة');

      case 'Request Information':
        return _t('Request Information', 'معلومات الطلب');

      case 'Identification Measures (Incident Verified, Assessed, Options Evaluated, Containment Measures):':
        return _t(
          'Identification Measures (Incident Verified, Assessed, Options Evaluated, Containment Measures):',
          'إجراءات التعريف (تم التحقق من الحادث، تم التقييم، تم تقييم الخيارات، إجراءات الاحتواء):',
        );

      case 'Evidence Collected (system logs, audit logs, Png, etc.):':
        return _t(
          'Evidence Collected (system logs, audit logs, Png, etc.):',
          'الأدلة المجمعة (سجلات النظام، سجلات التدقيق، PNG، إلخ):',
        );

      case 'Other Mitigation Measures:':
        return _t('Other Mitigation Measures:', 'إجراءات التخفيف الأخرى:');

      default:
        return _formatKey(key);
    }
  }
}
