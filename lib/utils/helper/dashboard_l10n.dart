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

  String get searchByIdOrName => _t('Search by Request Id', 'البحث برقم الطلب');

  String get myRequests => _t('My Requests', 'التذاكر الخاصة بي');

  String get actionItems => _t('Action Items', 'عناصر الإجراءات');

  String get noDataFound => _t('No Data Found', 'لا توجد بيانات');

  String get select => _t('Select', 'اختر');

  String get requestDetailScreenTitle => _t('Request Details', 'تفاصيل الطلب');

  String get requestDetailsTabLabel => _t('Request Details', 'تفاصيل الطلب');

  String get routingHistoryTabLabel => _t('Routing History', 'سجل التوجيه');

  String get requestHistoryTabLabel => _t('Request History', 'سجل الطلب');

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

  String get commentButtonReassign => _t('Re-assign', 'إعادة تعيين');

  String get commentButtonClose => _t('Close', 'إغلاق');

  String get commentButtonReplace => _t('Replace', 'استبدال');

  String get commentButtonInProgress => _t('In Progress', 'قيد التنفيذ');

  String get commentButtonComplete => _t('Complete', 'إكمال');

  // ── Foreign employee transportation ─────────────────────────────────────
  String get transportForeignEmployeeNewRequest =>
      _t('Transportation for Foreign Employee', 'نقل الموظفين الأجانب');

  String get vehicleMaintenanceNewRequest =>
      _t('Request for Vehicle Maintenance', 'طلب صيانة المركبة');

  String get salalahNewRequest => _t('New Salalah Request', 'طلب صلالة جديد');

  String get eventSupportNewRequest =>
      _t('Request for Event Support', 'طلب دعم الفعالية');

  String get vpnNewRequest => _t('VPN Request', 'طلب VPN');

  String get assignTaskToEmployeeNewRequest =>
      _t('Assign a Task to Employee', 'إسناد مهمة إلى موظف');

  String get assignTaskFormStepDetails => _t('Task details', 'تفاصيل المهمة');

  String get taskTitle => _t('Task Title', 'عنوان المهمة');

  String get enterTaskTitle => _t('Enter task title', 'أدخل عنوان المهمة');

  String get assignedEmployee => _t('Assigned Employee', 'الموظف المكلّف');

  String get assignedToEmployeeNameId => _t(
    'Assigned To (Employee Name / ID)',
    'مُسند إلى (اسم الموظف / الرقم الوظيفي)',
  );

  String get completionDate => _t('Completion Date', 'تاريخ الإنجاز');

  String get selectCompletionDate =>
      _t('Select completion date', 'اختر تاريخ الإنجاز');

  String get taskDescription => _t('Task Description', 'وصف المهمة');

  String get enterTaskDescription =>
      _t('Enter task description', 'أدخل وصف المهمة');

  String get attachmentsOptional =>
      _t('Attachments (Optional)', 'المرفقات (اختياري)');

  String get attachOptional => _t('Attach (Optional)', 'إرفاق (اختياري)');

  String priorityOption(String en) {
    switch (en) {
      case 'High':
        return _t('High', 'عالية');
      case 'Medium':
        return _t('Medium', 'متوسطة');
      case 'Low':
        return _t('Low', 'منخفضة');
      default:
        return en;
    }
  }

  String get reasonForRequest => _t('Reason for Request', 'سبب الطلب');

  String get transportFormStepTripDetails =>
      _t('Trip details', 'تفاصيل الرحلة');

  String get transportNoOfPassengers =>
      _t('Number of Passengers', 'عدد الركاب');

  String get transportPassengerNameSection =>
      _t('Name of the Passengers', 'أسماء الركاب');

  String get transportAddPassenger => _t('Add Name', 'إضافة الاسم');

  String transportPassengerNameHint(int index) =>
      _t('Enter name (characters only)', 'أدخل الاسم (حروف فقط)');

  String get transportPurpose => _t('Purpose', 'الغرض');

  String get transportPurposePlaceholder =>
      _t('Enter purpose of travel', 'أدخل غرض السفر');

  String get transportRequestType => _t('Request Type', 'نوع الطلب');

  String get transportEmployeePassport => _t(
    'Employee ID / Passport Number(Optional)',
    'رقم هوية الموظف / رقم جواز السفر (اختياري)',
  );

  String get transportEnterId => _t('Enter ID', 'أدخل رقم الهوية');

  String get transportOriginCity =>
      _t('Origin City (Optional)', 'مدينة الانطلاق (اختياري)');

  String get transportEnterCity => _t('Enter City', 'أدخل المدينة');

  String get transportDestinationCity =>
      _t('Destination City / Location', 'مدينة / موقع الوجهة');

  String get transportEnterDestination =>
      _t('Enter Destination', 'أدخل الوجهة');

  String get transportVehicleRequiredLocation =>
      _t('Vehicle Required Location', 'موقع المركبة المطلوبة');

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

  String get transportTravelItinerary => _t(
    'Travel Itinerary / Invitation (Optional)',
    'خط سير الرحلة / الدعوة (اختياري)',
  );

  String get transportContactNumber => _t('Contact Number', ' رقم التواصل');

  String get transportPassengerNameMinLength => _t(
    'Passenger name must be more than 2 letters',
    'يجب أن يكون اسم الراكب أكثر من حرفين',
  );

  String get transportAllocateVehicleTitle =>
      _t('Allocate Vehicle', 'تخصيص مركبة');

  String get transportApproveVehicleRequestTitle =>
      _t('Approve Request', 'موافقة على الطلب');

  String get transportDriverName => _t('Driver Name', 'اسم السائق');

  String get transportDriverNameHint =>
      _t('Enter Driver Name', 'أدخل اسم السائق');

  String get transportVehicleNumber =>
      _t('Select Vehicle Number', 'اختر رقم المركبة');

  String get transportSelectVehicleNumber =>
      _t('Vehicle number is required', 'رقم المركبة مطلوب');

  String get transportFuelCard => _t('Fuel Card', 'بطاقة الوقود');

  String get transportYes => _t('Yes', 'نعم');

  String get transportNo => _t('No', 'لا');

  String get transportVehicleReturnDate =>
      _t('Vehicle Return Date', 'تاريخ إرجاع المركبة المتوقع');

  String get transportVehicleReturnTime =>
      _t('Vehicle Return Time', 'وقت إرجاع المركبة المتوقع');

  String get transportSelectReturnDate =>
      _t('Please select return date', 'يرجى اختيار تاريخ الإرجاع');

  String get transportSelectReturnTime =>
      _t('Please select return time', 'يرجى اختيار وقت الإرجاع');
  String get transportVehicleCondition =>
      _t('Vehicle Condition', 'حالة المركبة');

  String get transportSelectVehicleCondition =>
      _t('Select Vehicle Condition', 'اختر حالة المركبة');

  String get transportReason => _t('Reason', 'السبب');

  String get transportEnterReason => _t('Enter reason', 'أدخل السبب');

  String get transportReasonRequired =>
      _t('Please enter reason', 'يرجى إدخال السبب');

  String get transportCommentsOptional =>
      _t('Comments (Optional)', 'ملاحظات (اختياري)');

  String get transportAddComments => _t('Add your comments', 'أضف ملاحظاتك');

  String get transportFormCancel => _t('CANCEL', 'إلغاء');

  String get transportFormSubmit => _t('SUBMIT', 'إرسال');

  String get employeeInformationTitle =>
      _t('Employee Information', 'معلومات الموظف');

  String get fileListTitle => _t('File List', 'قائمة الملفات');

  String get documentNameLabel => _t('Document Name', 'نوع المستند');

  String get fileTypeLabel => _t('File type', 'نوع الملف');

  String get uploadedDateLabel => _t('Uploaded Date', 'تاريخ الرفع');

  String get viewButtonLabel => _t('View', 'عرض');

  String get downloadButtonLabel => _t('Download', 'تنزيل');

  String get submittingRequest =>
      _t('Submitting request…', 'جاري إرسال الطلب…');

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

  // Logistics Daily/Emergency
  String get vehicleRequiredFor =>
      _t('Vehicle Required For', 'المركبة المطلوبة لـ');

  String get vehicleRequiredLocation =>
      _t('Vehicle Required Location', 'موقع المركبة المطلوبة');

  String get requestTitleLogistics => _t('Request Title', 'عنوان الطلب');

  String get enterRequestTitleLogistics => _t(
    'Enter request title (min 5, max 250 characters)',
    'أدخل عنوان الطلب (5 أحرف كحد أدنى و250 كحد أقصى)',
  );

  String get typeOfRequest => _t('Type of Request', 'نوع الطلب');

  String get purposeOfTravel => _t('Purpose of Travel', 'الغرض من السفر');

  String get travelTime => _t('Travel Time', 'وقت السفر');

  String get typeOfVehicleRequired =>
      _t('Type of Vehicle Required', 'نوع المركبة المطلوبة');

  String get attachFileOptional =>
      _t('Attach File (Optional)', 'المرفقات (اختياري)');

  String get autoCalculated => _t('Auto calculated', 'يُحسب تلقائياً');

  String get travelDateFrom => _t('Travel Date From', 'تاريخ السفر من');

  String get travelDateTo => _t('Travel Date To', 'تاريخ السفر إلى');

  String get numberOfGuests => _t('Number of Guests', 'عدد الضيوف');

  String get enterNumberOfGuests =>
      _t('Enter number of guests (1-100)', 'أدخل عدد الضيوف (1-100)');

  String get securityPrivacyPolicyAccepted => _t(
    'I have read and accepted the Security & Privacy Policy',
    'لقد قرأت وقبلت سياسة الأمان والخصوصية',
  );

  String get servicesLabel => _t('Services', 'الخدمات');

  String get declaration => _t('Declaration', 'إقرار');

  String get requestName => _t('Request Name', 'اسم الطلب');

  String get meal => _t('Meal', 'الوجبات');

  String get yesNoYes => _t('Yes', 'نعم');

  String get yesNoNo => _t('No', 'لا');

  String get downloadFailed => _t('Failed to download file', 'فشل تحميل الملف');

  String get downloadSuccess =>
      _t('File downloaded successfully', 'تم تحميل الملف بنجاح');

  String get previewNotAvailable => _t(
    'Preview is not available for this file type. Please download instead.',
    'المعاينة غير متاحة لهذا النوع من الملفات. يرجى التحميل بدلاً من ذلك.',
  );

  // reuqest fpr vehicle maintenance
  String get vehicleNumberId =>
      _t('Vehicle Number / ID', 'رقم المركبة / المعرف');

  String get typeOfMaintenanceRequired =>
      _t('Type of Maintenance Required', 'نوع الصيانة المطلوبة');

  String get preventive => _t('Preventive', 'صيانة وقائية');

  String get corrective => _t('Corrective', 'صيانة تصحيحية');

  String get preferredMaintenanceDate =>
      _t('Preferred Maintenance Date', 'تاريخ الصيانة المرغوب');

  String get requestSubmissionDate =>
      _t('Request Submission Date', 'تاريخ تقديم الطلب');

  String get issueDescription => _t('Issue Description', 'وصف المشكلة');

  String get writeHere => _t(
    'Write Here... (min 10 characters, max 255 characters)',
    'اكتب هنا... (الحد الأدنى 10 أحرف، الحد الأقصى 255 حرف)',
  );

  /// IT Services
  /// Salalah

  String get enterPersonName => _t('Enter Person Name', 'أدخل اسم الشخص');

  String get behalfOf => _t('Behalf Of', 'نيابةً عن');

  String get self => _t('Self', 'شخصي');

  String get section => _t('Section', 'القسم');

  String get sections => _t('Sections', 'الأقسام');

  String get serviceType => _t('Service Type', 'نوع الخدمة');

  String get selectServiceType => _t('Select Service Type', 'اختر نوع الخدمة');

  String get selectDepartment => _t('Select Department', 'اختر الدائرة');

  String get selectSection => _t('Select Section', 'اختر القسم');

  String get problem => _t('Problem', 'المشكلة');

  String get problemStatement => _t('Problem Statement', 'بيان المشكلة');

  String get enterPersonalEmail =>
      _t('Enter Personal Email', 'أدخل البريد الإلكتروني الشخصي');

  String get enterProblem => _t('Enter Problem', 'أدخل المشكلة');

  String get enterDescription => _t('Enter Description', 'أدخل الوصف');

  String get extensionNumber => _t('Extension Number', 'رقم المحول');

  String get enterExtensionNumber =>
      _t('Enter Extension Number', 'أدخل رقم التحويلة');

  String get enterEmail => _t('Enter Email', 'أدخل البريد الإلكتروني');

  String get assignedTo => _t('Assigned To', 'معين الى');

  String get selectAssignedTo => _t('Select Assigned To', 'اختيار المخصص');

  // Request for support event
  String get eventTitle =>
      _t('Event Title', 'التدريب على الأمن السيبراني إجباري');

  String get dateOfEvent => _t('Date of Event', 'تاريخ الفعالية');

  String get locationOfEvent => _t('Location of Event', 'موقع الفعالية');

  String get typeOfEvent => _t('Type of Event', 'نوع الفعالية');

  String get phoneNumber => _t('Phone Number', 'رقم الهاتف');

  String get requestFor => _t('Request For', 'نوع الطلب');

  String get attachFile => _t('Attach File', 'إرفاق ملفات');

  String get eventSupportSubmitNotePoint1 =>
      _t('Submit your request at least 3 days before the event date.', '');

  String get eventSupportSubmitNotePoint2 => _t(
    'In case of urgent requirements, contact the IT Help Desk directly for consideration.',
    '',
  );

  /// VPN
  String get country => _t('Country', 'الدولة');

  String get employeeId => _t('Employee ID', 'رقم الموظف');

  String get employeeMail => _t('Employee Mail', 'البريد الإلكتروني للموظف');

  String get contractor => _t('Contractor', 'المتعاقد');

  String get caaStaff => _t('CAA Staff', 'موظفو الهيئة');

  String get jobTitle => _t('Job Title', 'المسمى الوظيفي');

  String get thirdPartyVendorAccess =>
      _t('Third Party/Vendor Access', 'وصول طرف ثالث / مورد');

  String get remoteWork => _t('Remote Work', 'العمل عن بُعد');

  String get accessToInternalSystemApplications => _t(
    'Access to Internal System/Applications',
    'الوصول إلى الأنظمة / التطبيقات الداخلية',
  );

  String get projectSpecificRequirement =>
      _t('Project-specific Requirement', 'متطلبات خاصة بالمشروع');

  String get permanent => _t('Permanent', 'دائم');

  String get oneTime => _t('One Time', 'لمرة واحدة');

  String get other => _t('Other', 'أخرى');

  String get erp => _t('ERP', 'نظام تخطيط موارد الهيئة');

  String get ufuq => _t('UFUQ', 'اُفق');

  String get sharedServers => _t('Shared Servers', 'الخوادم المشتركة');

  String get fileServers => _t('File Servers', 'خوادم الملفات');

  String get internalDataBase =>
      _t('Internal data Bases', 'قواعد البيانات الداخلية');

  String get sysAppToAccess => _t(
    'Systems / Application to Access',
    'الأنظمة / التطبيقات التي يمكن الوصول إليها',
  );

  String get requestForTimePeriod => _t('Request for Time Period', 'مدة الطلب');

  String get reasonsForRequest => _t('Reasons For Request', 'أسباب الطلب');

  String get endDate => _t('End Date', 'إلى تاريخ');

  String get startDate => _t('Start Date', 'تاريخ البداية');

  String get deviceType => _t('Device Type', 'نوع الجهاز');

  String get enterContactNumber =>
      _t('Enter Contact Number', 'أدخل رقم التواصل');

  String get contactNumberRequired =>
      _t('Contact number is required', 'رقم التواصل مطلوب');

  String get contactNumberEightDigits =>
      _t('Contact number must be 8 digits', 'يجب أن يكون رقم التواصل 8 أرقام');

  String get enterEmployeeId => _t('Enter Employee ID', 'أدخل رقم الموظف');

  String get enterCountry => _t('Enter Country', 'أدخل الدولة');

  String get mobileDevice => _t('Mobile Device', 'جهاز الهاتف النقال');

  String get personalDeviceCompliesWithSecurityPolicies => _t(
    'Personal Device Complies With Security Policies',
    'جهاز شخصي يلتزم بسياسات الأمان',
  );

  String get caaLaptop => _t('CAA Laptop', 'حاسوب محمول للهيئة');

  String get policyPage => _t(
    "I agree to comply with CAA's security policies.",
    'أوافق على الالتزام بسياسات الأمان الخاصة بالهيئة',
  );

  String get misuseMayResultDisciplinaryAction => _t(
    'I understand misuse may result in disciplinary action.',
    'أدرك أن سوء الاستخدام قد يؤدي إلى اتخاذ إجراءات تأديبية.',
  );

  String get describeIssuePlaceholder =>
      _t('Describe the issue...', 'صف المشكلة...');

  String get transportFormStepPassengers =>
      _t('Passenger details', 'تفاصيل الركاب');

  // security access - request for access card
  String get enterName =>
      _t('Enter name (characters only)', 'أدخل الاسم (حروف فقط)');

  String get personName => _t('Person Name', 'اسم الشخص');

  String get enterPhoneNumber => _t('Enter Phone Number', 'أدخل رقم الهاتف');

  String get type => _t('Type', 'النوع');

  String get email => _t('Email', 'البريد الإلكتروني');

  String get category => _t('Category', 'الفئة');

  String get idNumber => _t('ID Number', 'رقم الهوية');

  String get enterPassportNumber =>
      _t('Enter Passport Number', 'أدخل رقم جواز السفر');

  String get dateOptional => _t('Date (Optional)', 'التاريخ (اختياري)');

  String get enterUniversityOrganization =>
      _t('Enter University / Organization', 'أدخل الجامعة / المنظمة');

  String get reason => _t('Reason', 'سبب الطلب');

  String get attachPassportSizePhotoWhiteBackground => _t(
    'Attach passport size photo (White background)',
    'إرفاق صورة بحجم جواز السفر (خلفية بيضاء)',
  );

  String logisticsDailyEmergencyOption(String en) {
    switch (en) {
      case 'Daily':
        return _t('Daily', 'يومي');
      case 'Emergency':
        return _t('Emergency', 'طارئ');
      default:
        return en;
    }
  }

  String logisticsVehicleRequiredForOption(String en) {
    switch (en) {
      case 'Conferences':
        return _t('Conferences', 'المؤتمرات');
      case 'Celebrations and Official Meetings':
        return _t(
          'Celebrations and Official Meetings',
          'الاحتفالات والاجتماعات الرسمية',
        );
      case 'others':
      case 'Others':
        return _t('Others', 'أخرى');
      default:
        return en;
    }
  }

  String logisticsPurposeOfTravelOption(String en) {
    switch (en) {
      case 'Site Visit':
        return _t('Site Visit', 'زيارة موقع');
      case 'Airport Duty':
        return _t('Airport Duty', 'مهمة مطار');
      case 'Official Meeting':
        return _t('Official Meeting', 'اجتماع رسمي');
      case 'Other':
        return _t('Other', 'أخرى');
      default:
        return en;
    }
  }

  String logisticsVehicleTypeOption(String en) {
    switch (en) {
      case 'Light vehicle':
      case 'Light Vehicle':
        return _t('Light Vehicle', 'مركبة خفيفة');
      case 'Heavy vehicle':
      case 'Heavy Vehicle':
        return _t('Heavy Vehicle', 'مركبة ثقيلة');
      default:
        return en;
    }
  }

  String get writeHereAr => _t('Write Here...', 'اكتب هنا...');

  String get duration => _t('Duration', 'المدة الزمنية');

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
      _t('Enter Contact Number', ' رقم التواصل');

  String get securityThreatFormTicketPlaceholder => _t(
    'Enter request title (min 5, max 250 characters)',
    'أدخل عنوان الطلب (5 أحرف كحد أدنى و250 كحد أقصى)',
  );

  String get securityThreatFormOtherDetailsPlaceholder => _t(
    'Enter Details (min 5, max 250 characters)',
    '(أدخل التفاصيل (5 كحد أدنى و250 حرفًا كحد أقصى',
  );
  String get otherDetailsPlaceholder => _t(
    'Enter Details (min 5, max 250 characters)',
    '(أدخل التفاصيل (5 كحد أدنى و250 حرفًا كحد أقصى',
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

  String get securityThreatCloseFormCommentsHint => _t(
    'Add your comments (optional, min 5, max 250 if provided)',
    'أضف تعليقاتك (اختياري، 5–250 حرفًا إن وُجد نص)',
  );

  String get securityThreatCloseFormIncidentNotificationLabel =>
      _t('Incident Notification in CAA', 'إشعار الحادث في هيئة الطيران المدني');

  String get securityThreatCloseFormHeadInfoSec =>
      _t('Head of Information Security', 'رئيس قسم امن المعلومات');

  String get securityThreatCloseFormDirectorIt =>
      _t('Director of Information Technology', 'مدير دائرة تقنية المعلومات');

  String get securityThreatCloseFormLegalDept =>
      _t('Legal Department', 'الدائرة القانونية');

  String get securityThreatCloseFormHeadInfra =>
      _t('Head of Infrastructure', 'رئيس قسم الشبكات');
  String get securyThreatAction => _t('Action', 'الإجراء');

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

  String get securityThreatCloseMitigation =>
      _t('Other Mitigation Measures', 'إجراءات التخفيف الأخرى:');

  String get securityThreatCloseFormFieldRequired =>
      _t('This field is required', 'هذا الحقل مطلوب');

  String get securityThreatCloseFormCancel => _t('CANCEL', 'إلغاء');

  String get securityThreatCloseFormSubmit => _t('SUBMIT', 'إرسال');

  String get reportSecurityThreat =>
      _t('Report Security Threat', 'الإبلاغ عن تهديد أمني');
  String get myProfile => _t('My Profile', 'ملفي الشخصي');

  String get findTheProfileDetails =>
      _t('Find the Profile Details', 'البحث عن تفاصيل الملف الشخصي');

  String get announcements => _t('Home', 'الرئيسية');

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
  // Hotel Reservation

  String get accommodationType => _t('Accommodation Type', 'نوع الإقامة');

  String get hotelName => _t('Hotel Name', 'اسم الفندق');

  String get enterHotelName =>
      _t('Enter Hotel Name (3-100 characters)', 'أدخل اسم الفندق (3-100 حرف)');

  String get enterPrice =>
      _t('Enter price (e.g., 100)', 'أدخل السعر (مثال: 100)');

  String get telephoneService => _t('Telephone service', 'خدمة الهاتف');

  String get meals => _t('Meals', 'الوجبات');

  String get breakfast => _t('Breakfast', 'الإفطار');

  String get lunch => _t('Lunch', 'الغداء');

  String get dinner => _t('Dinner', 'العشاء');

  String get laundry => _t('Laundry', 'غسيل الملابس');

  String get needMeetingRoom =>
      _t('Need Meeting Room', 'هل تحتاج إلى مركز للاجتماع؟');

  String get date => _t('Date', 'التاريخ');

  String get requestTimeoutTryAgain => _t(
    'Request timeout. Please try again.',
    'انتهت مهلة الطلب. يرجى المحاولة مرة أخرى.',
  );

  String get errorSubmittingRequest =>
      _t('Error submitting request', 'خطأ في تقديم الطلب');

  String get newRequestHotelReservation =>
      _t('New Request for Hotel Reservation', 'طلب جديد لحجز فندق');

  String get accommodationTypeRequested =>
      _t('Accommodation Type Requested', 'نوع الإقامة المطلوبة');

  String get accommodationTypeRequired =>
      _t('Accommodation Type is required', 'نوع الإقامة مطلوب');

  String get hotelPrice => _t('Hotel Price', 'سعر الفندق');

  String get hotelPriceRequired =>
      _t('Hotel Price is required', 'سعر الفندق مطلوب');

  String get invalidPriceMax => _t(
    'Invalid price (max 999,999.99)',
    'سعر غير صالح (الحد الأقصى 999,999.99)',
  );

  String get numberOfGuestsRequired =>
      _t('Number of Guests is required', 'عدد الضيوف مطلوب');

  String get guestsMustBe1100 =>
      _t('Guests must be between 1-100', 'يجب أن يكون عدد الضيوف بين 1-100');

  String get dateRequired => _t('Date is required', 'التاريخ مطلوب');

  String get hotelNameRequired =>
      _t('Hotel Name is required', 'اسم الفندق مطلوب');

  String get hotelNameValidation => _t(
    'Hotel Name: 3-100 chars, alphanumeric only',
    'اسم الفندق: 3-100 حرف، أرقام وحروف فقط',
  );

  String get checkInDateRequired =>
      _t('Check In Date is required', 'تاريخ الوصول مطلوب');

  String get checkInDateMin2Days => _t(
    'Check In Date must be at least 2 days from today',
    'يجب أن يكون تاريخ الوصول بعد يومين على الأقل من اليوم',
  );

  String get checkInTimeRequired =>
      _t('Check In Time is required', 'وقت الوصول مطلوب');

  String get checkOutDateRequired =>
      _t('Check Out Date is required', 'تاريخ المغادرة مطلوب');

  String get checkOutMustBeAfterCheckIn => _t(
    'Check Out must be after Check In',
    'يجب أن يكون تاريخ المغادرة بعد تاريخ الوصول',
  );

  String get checkOutTimeRequired =>
      _t('Check Out Time is required', 'وقت المغادرة مطلوب');

  String get purposeOfVisit => _t('Purpose of Visit', 'الغرض من الزيارة');

  String get purposeOfVisitRequired =>
      _t('Purpose of Visit is required', 'الغرض من الزيارة مطلوب');

  String get purposeOfVisitCharactersOnly => _t(
    'Purpose of Visit must contain only letters, spaces, hyphens, and apostrophes (minimum 3 characters)',
    'يجب أن يحتوي الغرض من الزيارة على أحرف ومسافات وشرطات وعلامات اقتباس فقط (3 أحرف على الأقل)',
  );

  String get enterPurposeOfVisit => _t(
    'Enter purpose of visit (letters only, minimum 5 characters)',
    'أدخل الغرض من الزيارة (أحرف فقط، 3 أحرف على الأقل)',
  );

  String get atLeastOneServiceFacilityRequired => _t(
    'At least one Service or Facility is required',
    'يجب اختيار خدمة أو مرفق واحد على الأقل',
  );

  String get passportVisaPhotoRequired => _t(
    'Passport & Visa Photo is required',
    'صورة جواز السفر والتأشيرة مطلوبة',
  );

  String get descriptionMax500Characters =>
      _t('Description max 500 characters', 'الوصف بحد أقصى 500 حرف');

  String get mustAcknowledgeSecurityPolicies => _t(
    'You must acknowledge the security policies',
    'يجب عليك الموافقة على سياسات الأمان',
  );

  String get checkInDate => _t('Check-In Date', 'تاريخ الوصول');

  String get checkOutDate => _t('Check-Out Date', 'تاريخ المغادرة');

  String get checkInTime => _t('Check-In Time', 'وقت الوصول');

  String get checkOutTime => _t('Check-Out Time', 'وقت المغادرة');

  String get attachPassportVisaPhoto =>
      _t('Attach Passport & Visa Photo', 'إرفاق صورة جواز السفر والتأشيرة');

  String get descriptionAdditionalNotesOptional => _t(
    'Description / Additional Notes (Optional)',
    'الوصف / الملاحظات الإضافية (اختياري)',
  );

  String securityNavTitle(int index) {
    switch (index) {
      case 0:
        return _t('Report Security Threat', 'الإبلاغ عن تهديد أمني');
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
      case 'Task Title':
        return taskTitle;
      case 'Task Description':
        return taskDescription;
      case 'Completion Date':
        return completionDate;
      case 'Assigned Employee':
        return assignedEmployee;
      case 'Request For':
        return requestFor;
      case 'Start Date':
        return startDate;
      case 'End Date':
        return endDate;
      case 'Employee Mail':
        return employeeMail;
      case 'Job Title':
        return jobTitle;
      case 'Country':
        return country;
      case 'Reasons For Request':
        return reasonsForRequest;
      case 'Systems / Applications to Access':
        return sysAppToAccess;
      case 'Device Type':
        return deviceType;
      case 'Type Of Threat':
        return _t('Type Of Threat', 'نوع التهديد');
      case 'Approver':
        return _t('Approver', 'المُعتمد');
      case 'Vehicle Location':
        return _t('Vehicle Location', 'موقع المركبة');
      case 'Request Name':
        return requestName;
      case 'Category':
        return category;
      case 'Hotel Name':
        return hotelName;
      case 'Check-In Date':
        return checkInDate;
      case 'Request Submission Date':
        return requestSubmissionDate;
      case 'Problem':
        return problem;
      case 'Created By':
        return _t('Created By', 'أنشئ بواسطة');
      case 'Comment':
        return _t('Comment', 'تعليق');
      case 'Level':
        return _t('Level', 'المستوى');
      case 'Vehicle Number':
        return vehicleNumberId;
      case 'Maintenance Type':
        return typeOfMaintenanceRequired;
      case 'Preferred Maintenance Date':
        return preferredMaintenanceDate;
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

      case 'Task Title':
        return taskTitle;

      case 'Task Description':
        return taskDescription;

      case 'Completion Date':
        return completionDate;

      case 'Assigned Employee':
        return assignedEmployee;

      case 'Request For':
        return requestFor;

      case 'Start Date':
        return startDate;

      case 'End Date':
        return endDate;

      case 'Employee Mail':
        return employeeMail;

      case 'Job Title':
        return jobTitle;

      case 'Country':
        return country;

      case 'Reasons For Request':
        return reasonsForRequest;

      case 'Systems / Applications to Access':
        return sysAppToAccess;

      case 'Device Type':
        return deviceType;

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
        return _t('Contact Number', ' رقم التواصل');

      case 'Service Type':
        return _t('Service Type', 'نوع الخدمة');

      case 'Sub Service Type':
        return _t('Sub Services', 'الخدمات الفرعية');

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
        return _t('Purpose of Travel', 'أدخل غرض السفر');

      case 'No of Passengers':
        return _t('Number of Passengers', 'عدد الركاب');

      case 'Arrival/Departure Date & Time':
        return _t(
          'Arrival/Departure Date & Time',
          'تاريخ ووقت الوصول / المغادرة',
        );

      case 'Vehicle Required Location':
        return _t('Vehicle Required Location', 'موقع المركبة المطلوبة');

      case 'Vehicle Location':
        return _t('Vehicle Location', 'موقع المركبة');

      case 'Requested Date':
        return _t('Requested Date', 'تاريخ الطلب');

      case 'Request Id':
        return _t('Request Id', 'رقم الطلب');

      case 'Employee ID':
        return _t('Employee ID', 'رقم الموظف');
      case 'Name':
        return _t('Name', 'الاسم');

      case 'Job Title / Designation':
        return _t('Job Title / Designation', 'المسمى الوظيفي / المنصب');

      case 'Email Address':
        return _t('Email Address', 'البريد الإلكتروني');

      case 'Assigned To':
        return _t('Assigned To', 'معين إلى');

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

      case 'Vehicle Number':
        return vehicleNumberId;

      case 'Maintenance Type':
        return typeOfMaintenanceRequired;

      case 'Preferred Maintenance Date':
        return preferredMaintenanceDate;

      case 'Issue Description':
        return issueDescription;

      case 'Problem Statement':
        return problemStatement;

      case 'Reason for Request':
        return reasonForRequest;

      case 'Travel Time':
        return travelTime;

      case 'Location':
        return _t('Location', 'الموقع');

      case 'Travel Date From':
        return travelDateFrom;

      case 'Travel Date To':
        return travelDateTo;

      case 'Hotel Name':
        return hotelName;

      case 'Accommodation Type':
        return accommodationType;

      case 'Number of Passengers':
        return _t('Number of Passengers', 'عدد الركاب');

      case 'Number of Guests':
        return numberOfGuests;

      case 'Check-Out Date':
        return checkOutDate;

      case 'Meal':
        return meal;

      case 'Hotel Price':
        return hotelPrice;

      case 'Request Name':
        return requestName;

      case 'Category':
        return category;

      case 'Type of Request':
        return typeOfRequest;

      case 'Type of Vehicle Required':
        return typeOfVehicleRequired;

      case 'Attach File':
        return attachFile;

      case 'Request Type':
        return typeOfRequest;

      default:
        return _formatKey(key);
    }
  }

  // ── Login screen ──────────────────────────────────────────────────────────
  String get loginAuthorityTitle =>
      _t('CIVIL AVIATION AUTHORITY', 'الهيئة العامة للطيران المدني');

  String get loginAuthoritySubtitle =>
      _t('هيئة الطيران المدني العمانية', 'هيئة الطيران المدني العمانية');

  String get loginIcaoBold => _t('ICAO', 'ICAO');

  String get loginCompliant => _t('Compliant', 'متوافق');

  String get loginIsoBold => _t('ISO', 'ISO');

  String get loginCertified => _t('Certified', 'معتمد');

  String get loginSupportBold => _t('24/7', '24/7');

  String get loginSupportLabel => _t('Support', 'دعم');

  String get loginSafetyExcellenceTitle =>
      _t('Safety Excellence', 'التميز في السلامة');

  String get loginSafetyExcellenceSubtitle => _t(
    'International Safety Standards & regulations',
    'معايير ولوائح السلامة الدولية',
  );

  String get loginGlobalNetworkTitle => _t('Global network', 'شبكة عالمية');

  String get loginGlobalNetworkSubtitle =>
      _t('Connecting Oman to the world', 'ربط عُمان بالعالم');

  String get loginInnovationHubTitle => _t('Innovation Hub', 'مركز الابتكار');

  String get loginInnovationHubSubtitle =>
      _t('Future-ready aviation technology', 'تقنيات طيران مستقبلية');

  String get loginIcaoCompliant => _t('ICAO Compliant', 'متوافق مع ICAO');

  String get loginIsoCertified => _t('ISO Certified', 'معتمد ISO');

  String get loginSupport247 => _t('24/7 Support', 'دعم على مدار الساعة');

  String get loginContinueWithMicrosoft =>
      _t('Continue with Microsoft', 'المتابعة مع Microsoft');

  String get loginOrDivider => _t('OR', 'أو');

  String get loginJwtHint =>
      _t('Paste your JWT token here...', 'الصق رمز JWT هنا...');

  String get loginJwtLabel => _t('JWT Token', 'رمز JWT');

  String get loginWithJwt => _t('Login with JWT', 'تسجيل الدخول بـ JWT');

  String get loginHideJwt => _t('Hide JWT login', 'إخفاء تسجيل JWT');

  String get loginJwtRequired =>
      _t('Please enter JWT token', 'يرجى إدخال رمز JWT');

  String get servicesMoreInfo => _t('More Info', 'مزيد من المعلومات');

  String get servicesLessInfo => _t('Less Info', 'معلومات أقل');

  String loginLanguageDisplayName(String code) {
    switch (code) {
      case 'ar':
        return 'العربية';
      default:
        return 'English';
    }
  }
}
