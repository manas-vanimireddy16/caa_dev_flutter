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

  String get dashboard => _t('Dashboard', 'لوحة التحكم');

  String get newRequest => _t('New Request', 'طلب جديد');

  String get createRequest => _t('Create Request', 'إنشاء طلب');

  String get assignNewTask => _t('Assign New Task', 'تعيين مهمة جديدة');

  String get newTicket => _t('New Ticket', 'طلب جديد');

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

  String get coverageDetailsSection => _t('Coverage Details', 'تفاصيل التغطية');

  String get nameOfAttendeesLabel => _t('Name of Attendees', 'أسماء الحاضرين');

  String get addAttendeeName => _t('Add Name', 'إضافة الاسم');

  String attendeeNameHint(int index) =>
      _t('Attendee $index Name', 'اسم الحاضر $index');

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

  String get phoneMustBe8To10Digits => _t(
    'Phone number must be between 8 and 10 digits',
    'يجب أن يتكون رقم الهاتف من 8 إلى 10 أرقام',
  );

  String get securityThreatTicketNameHint =>
      _t('Must be at least 5 characters', 'يجب ألا يقل عن 5 أحرف');

  String get requestWorkflowSectionTitle =>
      _t('Request Workflow', 'سير عمل الطلب');

  String get workflowActionTakenBy =>
      _t('Action Taken By', 'الإجراء المؤدي بواسطة');

  String get workflowDepartmentName => _t('Department Name', 'اسم الدائرة');

  String get workflowSectionName => _t('Section Name', 'اسم القسم');

  String get workflowRoleName => _t('Role Name', 'اسم الدور');

  String workflowEmployeeIdLine(String id) =>
      _t('Employee ID: $id', 'رقم الموظف: $id');

  String get commentsRoutingOverviewTitle => _t(
    'Comments / Routing Overview',
    'التعليقات / نظرة عامة على مسار الإجراء',
  );

  String get routingTileDateTime => _t('Date / Time', 'التاريخ / الوقت');

  String get routingTileRole => _t('Role / Authority', 'الدور / الصلاحية');

  String get routingTileAction =>
      _t('Comments & Actions', 'التعليقات والإجراءات');

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

  String get comments => _t('Comments', 'الملاحظات');

  String get needMoreInfo => _t('Need more info', 'أحتاج المزيد من المعلومات');

  String get commentButtonAssign => _t('Assign', 'تعيين');

  String get commentButtonApprove => _t('Approve', 'الموافقة');

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
  String get eventSupportPhoneNumberErrorText => _t(
    'Phone Number must be exactly 10 digits',
    'يجب أن يكون رقم التواصل 10 أرقام',
  );

  String get eventSupportRequestForErrorText => _t(
    'Request For must be at least 5 characters',
    'يجب أن يكون نوع الطلب 5 أحرف على الأقل',
  );

  String get eventSupportReasonForRequestErrorText => _t(
    'Reason For Request must be at least 5 characters',
    'يجب أن يكون سبب الطلب 5 أحرف على الأقل',
  );

  String get vpnNewRequest => _t('VPN Request', 'طلب VPN');

  String get assignTaskToEmployeeNewRequest =>
      _t('Assign a Task to Employee', 'إسناد مهمة إلى موظف');

  String get assignTaskFormStepDetails => _t('Task details', 'تفاصيل المهمة');

  String get enterTaskTitle => _t('Enter task title', 'أدخل عنوان المهمة');
  String get taskTitleRequired =>
      _t('Task title is required', 'عنوان المهمة مطلوب');
  String get taskTitleMinLength => _t(
    'Task Title must be at least 5 characters',
    'يجب أن يكون عنوان المهمة 5 أحرف على الأقل',
  );
  String get taskDescriptionMinLength => _t(
    'Task Description must be at least 5 characters',
    'يجب أن يكون وصف المهمة 5 أحرف على الأقل',
  );
  String get taskDescriptionRequired =>
      _t('Task Description is required', 'وصف المهمة مطلوب');

  String get assignedEmployee => _t('Assigned Employee', 'الموظف المكلّف');

  String get enter => _t('Enter', 'أدخل');
  String get eventSupportPlaceholderRequestFor =>
      _t('Enter your request', 'أدخل طلبك');

  String get eventSupportPlaceholderReason =>
      _t('Enter your Reason', 'أدخل سبب الطلب');

  String get selectCompletionDate =>
      _t('Select completion date', 'اختر تاريخ الإنجاز');

  String get enterTaskDescription =>
      _t('Enter task description', 'أدخل وصف المهمة');

  String get attachmentsOptional =>
      _t('Attachments (Optional)', 'المرفقات (اختياري)');

  String get attachOptional => _t('Attach (Optional)', 'إرفاق (اختياري)');

  String priorityOption(String en) {
    switch (en) {
      case 'High':
        return _t('High', 'عالي');
      case 'Medium':
        return _t('Medium', 'متوسط');
      case 'Low':
        return _t('Low', 'منخفض');
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

  String get transportActualReturnDate =>
      _t('Vehicle Return Date', 'تاريخ إرجاع المركبة');

  String get transportActualVehicleReturnTime =>
      _t('Vehicle Return Time', 'وقت إرجاع المركبة');
  String get allocateVehicleButton => _t('Allocate Vehicle', 'تخصيص المركبة');

  String get transportUpdateActualReturnTitle =>
      _t('Update Actual Return', 'تحديث الإرجاع الفعلي');

  String get commentButtonUpdate => _t('Update', 'تحديث');

  String get updateExternalServiceRequestTitle =>
      _t('Update External Service Request', 'تحديث طلب الخدمة الخارجية');

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

  // Permission
  String get typeOfRequest => _t('Type of Request', 'نوع الطلب');

  String get isTheMaterialHazardousOrSensitive =>
      _t('Is the material hazardous or sensitive?', 'هل المادة خطرة أو حساسة؟');

  String get purposeOfImportExport =>
      _t('Purpose of Import/Export', 'الغرض من الاستيراد/التصدير');

  String get requestedDateOfMaterialMovement =>
      _t('Requested Date of Material Movement', 'تاريخ نقل المواد المطلوب');

  String get export => _t('Export', 'إخراج');

  String get import => _t('import', 'إدخال');

  String get importAndExportBoth => _t('both', 'إدخال وإخراج');

  String importExportTypeOption(String value) {
    switch (value.toLowerCase()) {
      case 'import':
        return import;
      case 'export':
        return export;
      case 'both':
        return importAndExportBoth;
      default:
        return value;
    }
  }

  String get expiredLabel => _t('Expired', 'منتهي الصلاحية');

  String get vehicleNumber => _t('Vehicle Number', 'رقم المركبة');

  String get modeOfTransport => _t('Mode of Transport', 'وسيلة النقل');

  String get materialNameDescription =>
      _t('Material Name/Description', 'اسم المادة / الوصف');

  // Airport Entry Permit
  String get airportEntryPermit =>
      _t('Airport Entry Permit', 'تصريح دخول المطار');

  String get airportEntryPermitRequest =>
      _t('Airport Entry Permit Request', 'طلب تصريح دخول المطار');

  String get airportName => _t('Airport Name', 'اسم المطار');

  String get permissionToRequiredAreas =>
      _t('Permission to Required Areas', 'التصريح للمناطق المطلوبة');

  String get permissionAreaTaskHint => _t(
    'Enter work tasks required in this area',
    'أدخل مهام العمل المطلوبة في هذه المنطقة',
  );

  String get permissionAreaTaskRequired => _t(
    'Enter work tasks for all selected required areas',
    'أدخل مهام العمل لجميع المناطق المطلوبة المحددة',
  );

  String get issuingNewPermit => _t('Issuing New Permit', 'إصدار تصريح جديد');

  String get renewalOfPermit => _t('Renewal of Permit', 'تجديد التصريح');

  String get replacingLost => _t('Replacing lost', 'بدل فاقد');

  String get cancellingAirportSecurityPermits =>
      _t('Cancelling Airport Security Permits', 'إلغاء تصاريح أمن المطار');

  String get allCivilAirports =>
      _t('All Civil Airports', 'جميع المطارات المدنية');

  String get salalah => _t('Salalah', 'صلالة');

  String get muscat => _t('Muscat', 'مسقط');

  String get marmul => _t('Marmul', 'مرمول');

  String get duqm => _t('Duqm', 'الدقم');

  String get sohar => _t('Sohar', 'صحار');

  String get fuhud => _t('Fuhud', 'فهود');

  String get mukhazina => _t('Mukhazina', 'مخيزنه');

  String get laptopTablet => _t('Laptop/Tablet', 'حاسوب محمول / جهاز لوحي');

  String get boardingTheAircraft => _t('Boarding the Aircraft', 'صعود الطائرة');

  String get employeeAssistingPeopleWithSpecialNeeds => _t(
    'Employee Assisting People with Special Needs',
    'الموظف المساعد لذوي الاحتياجات الخاصة',
  );

  String get enterDeviceSerialNumber =>
      _t("Enter the device's serial number", 'إدخال الرقم التسلسلي للجهاز');

  String get additionalServices =>
      _t('Additional Services', 'الخدمات الإضافية');

  String get vipBuilding => _t('VIP Building', 'مبنى كبار الشخصيات');

  String get cargoBuildingImportsExports =>
      _t('Cargo Building (Imports & Exports)', 'مبنى الشحن (الصادر والوارد)');

  String get arrivalsHallArrivalsBuilding =>
      _t('Arrivals Hall / Arrivals Building', 'صالة القادمين ومبنى القادمين');

  String get departuresHallDeparturesBuilding => _t(
    'Departures Hall / Departures Building',
    'صالة المغادرين ومبنى المغادرين',
  );

  String get informationCenterControlTower => _t(
    'Information Center / Control Tower',
    'مبنى مركز المعلومات وبرج المراقبة',
  );

  String
  get aircraftParkingAreaAircraftMaintenanceBuildingVehicleRepairWorkshopFireStationAndFuelingStations => _t(
    'Aircraft Parking Area, Aircraft Maintenance Building, Vehicle Repair Workshop, Fire Station, and Fueling Stations',
    'ساحة مواقف الطائرات، مبنى صيانة الطائرات، ورشة تصليح المركبات، مركز الإطفاء ومحطات تعبئة الوقود.',
  );

  String get baggageSortingArea =>
      _t('Baggage Sorting Area', 'منطقة فرز الحقائب');

  String get cateringBuilding =>
      _t('Catering Building', 'مبـــــــــنى التمويــن');

  String get aircraftMaintenanceBuilding =>
      _t('Aircraft Maintenance Building', 'مبـــــــــنى صيانة الطائرات');

  String get goldBuilding => _t('Gold Building', 'مبنى الذهــــب');

  String get vip => _t('VIP', 'كبار الشخصيات');

  String get durationDaysAirportEntry =>
      _t('Duration (Days)', 'المدة (بالأيام)');

  String get temporary => _t('Temporary', 'مؤقت');

  String get permanent => _t('Permanent', 'دائم');

  String get temporaryVisit => _t('Temporary | Visit', 'مؤقت | زيارة');

  String get typeOfPermit => _t('Type of permit', 'نوع التصريح');

  String get phoneNumber => _t('Phone Number', 'رقم الهاتف');

  String get phoneNumberRequired =>
      _t('Phone number is required', 'رقم الهاتف مطلوب');

  String get dateOfSubmission => _t('Date of submission', 'تاريخ التقديم');

  String get categoryOfPermit => _t('Category of permit', 'فئة التصريح');

  String get passportIdCardNo =>
      _t('Passport/ID Card NO', 'رقم الجواز / الرقم المدني');

  String get dob => _t('Date of Birth', 'تاريخ الميلاد');

  String get nationality => _t('Nationality', 'الجنسية');

  String get fullNameFamilyName =>
      _t('Full Name / Family Name', 'الاسم الكامل / اسم العائلة');

  String get dynamicFormPrevious => _t('Previous', 'السابق');

  String get dynamicFormNext => _t('Next', 'التالي');

  String get dynamicFormSubmit => _t('Submit', 'إرسال');

  String get noDescriptionProvided =>
      _t('No description provided', 'لا يوجد وصف');

  String dynamicFormSubtitle(String title) =>
      _t('Provide details about your $title', 'قدّم تفاصيل حول $title');

  String dynamicFormMultiSelectHint(String fieldLabel) =>
      _t('Select $fieldLabel', 'اختر $fieldLabel');

  String dynamicFormMultiSelectCount(int n) =>
      _t('$n Selected', isArabic ? 'تم اختيار $n' : '$n Selected');

  String get dynamicFormMultiSelectDone => _t('DONE', 'تم');

  String get dynamicFormSearchHint => _t('Search...', 'بحث...');

  String get autoFilled => _t('Auto filled', 'يُعبأ تلقائياً');

  String get idCardResidenceCard =>
      _t('ID Card | Residence Card', 'بطاقة الهوية | بطاقة الإقامة');

  String get employmentContract => _t('Employment Contract', 'عقد العمل');

  String get passport => _t('Passport', 'جواز السفر');

  String get permitApplicationForm =>
      _t('Permit Application Form', 'نموذج طلب التصريح');

  String get securityAwarenessForm =>
      _t('Security Awareness Form', 'نموذج التوعية الأمنية');

  String get copyOfIdCard => _t('Copy of ID Card', 'نسخة من بطاقة الهوية');

  String get copyOfPreviousPermit =>
      _t('Copy of Previous Permit', 'نسخة من التصريح السابق');

  String get acknowledgements => _t('Acknowledgements', 'الإقرارات');

  String airportPermitCategoryOption(String en) {
    switch (en) {
      case 'Issuing New Permit':
        return issuingNewPermit;
      case 'Renewal of Permit':
        return renewalOfPermit;
      case 'Replacing lost':
        return replacingLost;
      case 'Cancelling Airport Security Permits':
        return cancellingAirportSecurityPermits;
      default:
        return en;
    }
  }

  String airportNameOption(String en) {
    switch (en) {
      case 'Salalah':
        return salalah;
      case 'Muscat':
        return muscat;
      case 'Marmul':
        return marmul;
      case 'Duqm':
        return duqm;
      case 'Sohar':
        return sohar;
      case 'Fuhud':
        return fuhud;
      case 'Mukhazina':
        return mukhazina;
      case 'All Civil Airports':
        return allCivilAirports;
      default:
        return en;
    }
  }

  String airportPermitAreaLabel(String en) {
    switch (en) {
      case 'VIP Building':
        return vipBuilding;
      case 'Cargo Building (Imports & Exports)':
        return cargoBuildingImportsExports;
      case 'Arrivals Hall / Arrivals Building':
        return arrivalsHallArrivalsBuilding;
      case 'Departures Hall / Departures Building':
        return departuresHallDeparturesBuilding;
      case 'Information Center / Control Tower':
        return informationCenterControlTower;
      case 'Aircraft Parking Area, Aircraft Maintenance Building, Vehicle Repair Workshop, Fire Station, and Fueling Stations':
        return aircraftParkingAreaAircraftMaintenanceBuildingVehicleRepairWorkshopFireStationAndFuelingStations;
      case 'Baggage Sorting Area':
        return baggageSortingArea;
      case 'Catering Building':
        return cateringBuilding;
      case 'Aircraft Maintenance Building':
        return aircraftMaintenanceBuilding;
      case 'Gold Building':
        return goldBuilding;
      default:
        return en;
    }
  }

  ///Tender Services
  String get requestingEntityOrRelevantDepartment => _t(
    'Requesting Entity or Relevant Department',
    'الجهة الطالبة أو القسم المعني',
  );

  String get implementationPeriod => _t('Implementation period', 'مدة التنفيذ');

  String get estimatedCost => _t('Estimated Cost', 'التكلفة التقديرية');

  String get budgetCode => _t('Budget code', 'رمز الميزانية');

  String get tenderOptionCancelledTender =>
      _t('Cancelled tender', 'مناقصة ملغاة');

  String get tenderOptionRefloatedTender => _t(
    'Refloated tender (Resubmit previous tender request)',
    'إعادة طرح مناقصة (إعادة تقديم طلب مناقصة سابق)',
  );

  String get titleOfEnquire => _t('Title of Enquire', 'عنوان الاستفسار');

  String get titleOfProject => _t('Title of project', 'عنوان المشروع');

  String get typeOfProject => _t('Type of Project', 'نوع المشروع');

  String get projectCodeBudgetCode =>
      _t('Project code/budget code', 'رمز المشروع/رمز الميزانية');

  String get enterCompanyName => _t('Enter Company Name', 'أدخل اسم الشركة');

  String get companyName => _t('Company Name', 'اسم الشركة');
  String get companyPhoneNumber =>
      _t('Company Phone Number', 'رقم هاتف الشركة');

  String get attachment => _t('Attachment', 'مرفق');
  String get descriptionPlaceholder =>
      _t('Write your description', 'اكتب وصفك');

  String get projectCodeBudgetCodePlaceholder =>
      _t('Project code/budget code', 'رمز المشروع/رمز الميزانية');

  String get titleOfProjectPlaceholder =>
      _t('Enter Title of Project', 'أدخل عنوان المشروع');

  String get enterProjectCodeBudgetCode =>
      _t('Enter Project Code/Budget Code', 'أدخل رمز المشروع / رمز الميزانية');

  String get titleOfProjectRequired =>
      _t('Title of project is required', 'عنوان المشروع مطلوب');

  String get projectCodeBudgetCodeRequired => _t(
    'Project code / budget code is required',
    'رمز المشروع / رمز الميزانية مطلوب',
  );

  String get descriptionMustBeAtLeast10Characters => _t(
    'Description must be at least 10 characters',
    'يجب أن يكون الوصف 10 أحرف على الأقل',
  );

  String get descriptionMustBeBetween10And100Characters => _t(
    'Description must be between 10 and 100 characters',
    'يجب أن يكون الوصف بين 10 و 100 حرفًا',
  );

  String get phoneMustBeExactly8Digits => _t(
    'Phone number must be exactly 8 digits',
    'يجب أن يتكون رقم الهاتف من 8 أرقام',
  );

  String get fieldIsRequired => _t('This field is required', 'هذا الحقل مطلوب');

  // Logistics Daily/Emergency

  /// HOME SCREEN
  String get inputSearchPlaceholder =>
      _t('Search by Service Name', 'البحث باسم الخدمة');

  String get importantLinks => _t('Important Links', 'الروابط المهمة');

  String get quickLink => _t('Quick Links', 'الروابط السريعة');

  String get myServices => _t('My Services', 'خدماتي');

  String get allServices => _t('All Services', 'جميع الخدمات');

  String get status => _t('Status', 'الحالة');

  String get requestId => _t('Request ID', 'رقم الطلب');

  String get requestName => _t('Request Name', 'اسم الطلب');

  String get myTickets => _t('My Tickets', 'تذاكري');

  String get searchByName => _t('Search by Request Id', 'البحث برقم الطلب');

  String get approvals => _t('Approvals', 'الموافقات');

  String get links => _t('Links', 'الروابط');

  String get postedOn => _t('Posted On', 'نُشر في');

  String get navProfile => _t('Profile', 'الملف الشخصي');

  String get goodMorning => _t('Good Morning', 'صباح الخير');

  String get goodAfternoon => _t('Good Afternoon', 'مساء الخير');

  String get goodEvening => _t('Good Evening', 'مساء الخير');

  String greetingForTime([DateTime? time]) {
    final hour = (time ?? DateTime.now()).hour;
    if (hour < 12) return goodMorning;
    if (hour < 16) return goodAfternoon;
    return goodEvening;
  }

  String get requestForCoverageUrgentContactMessage => _t(
    'You may contact the Media Department for urgent requests.',
    'يمكنك التواصل مع قسم الإعلام للطلبات العاجلة.',
  );

  String get latestAnnouncements => _t('Latest Announcements', 'آخر الإعلانات');

  String get requestMaintenanceSubService =>
      _t('Request Maintenance', 'طلب صيانة');

  String get maintenanceOfExternalServiceSubService =>
      _t('Maintenance of External Service', 'صيانة المحطات الخارجية');

  String get importExportMaterialPermissionSubService =>
      _t('Import/Export Material Permission', 'تصريح استيراد / تصدير المواد');

  String get requestForStudyLeaveSubService =>
      _t('Request for Study Leave', 'طلب إجازة دراسية');

  /// Resolves sub-service title for list/dashboard headers (EN or AR).
  String subServiceDisplayName({String? englishName, String? arabicName}) {
    final en = englishName?.trim() ?? '';
    if (!isArabic) {
      return en.isNotEmpty ? en : ticketRequests;
    }

    final ar = arabicName?.trim() ?? '';
    if (ar.isNotEmpty) return ar;

    final localized = _localizedSubServiceName(en);
    if (localized != null && localized.isNotEmpty) return localized;

    return en.isNotEmpty ? en : ticketRequests;
  }

  String? _localizedSubServiceName(String englishName) {
    if (!isArabic || englishName.trim().isEmpty) return null;

    final key = englishName.trim().toLowerCase();

    if (key == 'request maintenance') {
      return requestMaintenanceSubService;
    }
    if (key == 'maintenance of external service' ||
        key == 'request for maintenance of external stations') {
      return maintenanceOfExternalServiceSubService;
    }
    if (key == 'import/export material permission' ||
        key == 'import export material permission' ||
        key == 'permission' ||
        key.contains('import') &&
            key.contains('export') &&
            key.contains('permission')) {
      return importExportMaterialPermissionSubService;
    }
    if (key == 'complaint/lost property report' ||
        key == 'complaint or lost property report' ||
        key == 'complaint or lost property' ||
        (key.contains('complaint') && key.contains('lost'))) {
      return complaintLostPropertyReport;
    }
    if (key == 'request for study leave' || key == 'study leave') {
      return requestForStudyLeaveSubService;
    }
    if (key == 'appeal against administrative decisions' ||
        key.contains('appeal against administrative')) {
      return appealAgainstAdministrativeDecisionsTitle;
    }

    return null;
  }

  String get stayInformedWithLatestUpdates =>
      _t('Stay informed with latest updates', 'ابقَ على اطلاع بآخر التحديثات');

  String get eventsAnnouncementsTitle => _t('Announcements', 'الإعلانات');

  String get myProfileDetails => _t('My Profile', 'صفحة ملفي الشخصي');

  String get myProfileSubtext =>
      _t('Find the Profile Details', 'البحث عن تفاصيل الملف الشخصي');
  String get pleaseEnterHazardousOrSensitiveMaterial => _t(
    'Please Enter if the material is hazardous or sensitive',
    'يرجى إدخال ما إذا كانت المادة خطرة أو حساسة',
  );

  String get enterPurposeOfImportExport => _t(
    'Enter the purpose of import/ export',
    'أدخل الغرض من الإدخال / الإخراج',
  );

  String get pleaseEnterPurposeOfImportExport => _t(
    'Please Enter the purpose of import/ export',
    'يرجى إدخال الغرض من الإدخال / الإخراج',
  );

  String get enterDescriptionOfMaterial =>
      _t('Enter the description of material', 'أدخل وصف المادة');

  String get pleaseEnterDescriptionOfMaterial =>
      _t('Please Enter the description of material', 'يرجى إدخال وصف المادة');

  String get pleaseEnterDescription =>
      _t('Please Enter the Description', 'يرجى إدخال الوصف');

  String get enterModeOfTransport =>
      _t('Enter the mode of transport', 'أدخل وسيلة النقل');

  String get pleaseEnterModeOfTransport =>
      _t('Please Enter the mode of transport', 'يرجى إدخال وسيلة النقل');

  String get enterVehicleNumber =>
      _t('Enter the vehicle number', 'أدخل رقم المركبة');

  String get pleaseEnterVehicleNumber =>
      _t('Please Enter the vehicle number', 'يرجى إدخال رقم المركبة');

  String get selectTypeOfRequest =>
      _t('Select Type of Request', 'اختر نوع الطلب');

  String get pleaseSelectTypeOfRequest =>
      _t('Please Select the Type of Request', 'يرجى اختيار نوع الطلب');

  String get selectMaterialMovementDate =>
      _t('Select Material Movement Date', 'اختر تاريخ حركة المواد');

  String get pleaseSelectMaterialMovementDate => _t(
    'Please Select the Material Movement Date',
    'يرجى اختيار تاريخ حركة المواد',
  );

  String get enterHazardousOrSensitiveMaterial => _t(
    'Enter if the material is hazardous or sensitive',
    'أدخل ما إذا كانت المادة خطرة أو حساسة',
  );

  String get dateOfRequest => _t('Date of Request', 'تاريخ الطلب');

  String get dateOfLoss => _t('Date of Loss', 'تاريخ الفقدان');

  String get timeOfLoss => _t('Time of Loss', 'وقت الفقدان');

  String get itemDescriptionLabel => _t('Item Description', 'وصف المفقودات');

  String get dateOfLossRequired =>
      _t('Date of loss is required', 'تاريخ الفقدان مطلوب');

  String get timeOfLossRequired =>
      _t('Time of loss is required', 'وقت الفقدان مطلوب');

  String get locationWhereItemWasLostRequired => _t(
    'Location where item was lost is required',
    'موقع فقدان المفقودات مطلوب',
  );

  String get itemDescriptionRequired =>
      _t('Item description is required', 'وصف المفقودات مطلوب');

  String get attachmentRequired => _t('Attachment is required', 'المرفق مطلوب');

  String get uploadAtLeastOneAttachment => _t(
    'Please upload at least one attachment',
    'يرجى رفع مرفق واحد على الأقل',
  );

  String get descriptionMinFiveChars => _t(
    'Description must be at least 5 characters',
    'يجب أن يكون الوصف 5 أحرف على الأقل',
  );

  String get mustBeAtLeast3Characters =>
      _t('Must be at least 3 characters', 'يجب ألا يقل عن 3 أحرف');

  String get mustBeAtLeast10CharactersLong => _t(
    'Description must be at least 10 characters long',
    'يجب أن يكون الوصف 10 أحرف على الأقل',
  );

  String get cannotExceed250Characters =>
      _t('Cannot exceed 250 characters', 'لا يجوز أن يتجاوز 250 حرفًا');

  String get cannotExceed255Characters =>
      _t('Cannot exceed 255 characters', 'لا يجوز أن يتجاوز 255 حرفًا');

  String get logisticsDescription3250 => _t(
    'Write here (min 3, max 250 characters)',
    'اكتب هنا (3 أحرف كحد أدنى و250 حرفًا كحد أقصى)',
  );

  String get approvalCommentOptional5250 => _t(
    'Add your comments (optional, min 5, max 250 if provided)',
    'أضف تعليقاتك (اختياري، 5–250 حرفًا إن وُجد نص)',
  );

  String get otherVehicleRequiredForLabel =>
      _t('Other Vehicle Required For', 'الغرض الآخر للمركبة');

  String get otherVehicleRequiredForMinLength => _t(
    'Other Vehicle Required For must be at least 5 characters',
    'يجب أن يكون حقل الغرض الآخر للمركبة 5 أحرف على الأقل',
  );

  String get otherVehicleRequiredForMaxLength => _t(
    'Other Vehicle Required For cannot exceed 250 characters',
    'لا يجوز أن يتجاوز حقل الغرض الآخر للمركبة 250 حرفًا',
  );

  String get materialDescriptionMinFiveChars => _t(
    'Material Name/Description must be at least 5 characters',
    'يجب أن يكون اسم/وصف المادة 5 أحرف على الأقل',
  );

  String get hazardousMaterialRequired => _t(
    'Is the material hazardous or sensitive? is required',
    'هل المادة خطرة أو حساسة؟ مطلوب',
  );

  String get purposeOfImportExportRequired => _t(
    'Purpose of Import/Export is required',
    'الغرض من الاستيراد/التصدير مطلوب',
  );

  String get modeOfTransportRequired =>
      _t('Mode of Transport is required', 'وسيلة النقل مطلوبة');

  String get selectDate => _t('Select Date', 'اختر التاريخ');

  String get enterLocationWhereItemWasLost =>
      _t('Enter Location Where Item Was Lost', 'أدخل موقع فقدان المفقودات');

  String get pleaseEnterLocationWhereItemWasLost => _t(
    'Please Enter the Location Where Item Was Lost',
    'يرجى إدخال موقع فقدان المفقودات',
  );

  String get enterItemDescription =>
      _t('Enter Item Description', 'أدخل وصف المفقودات');

  String get pleaseEnterItemDescription =>
      _t('Please Enter the Item Description', 'يرجى إدخال وصف المفقودات');

  String get complaintLostPropertyReport =>
      _t('Complaint/Lost Property Report', 'بلاغ شكوى / مفقودات');

  String get dateTimeOfLoss => _t('Date & time of loss', 'تاريخ ووقت الفقدان');

  String get locationWhereItemWasLost =>
      _t('Location where item was lost', 'موقع فقدان المفقودات');

  String get scholarship => _t('Scholarship', 'المنحة الدراسية');

  String get instituteName => _t('Institute name', 'اسم المعهد / المؤسسة');

  String get enterInstituteName =>
      _t('Enter Institute Name', 'أدخل اسم المعهد / المؤسسة');

  String get qualificationRequired =>
      _t('Qualification Required', 'المؤهل المطلوب');

  String get studyLeaveAttachmentDescription => _t(
    'University Approval (Acceptance Letter)',
    'University Approval (Acceptance Letter)',
  );

  String get haveYouEverReceivedAuthority => _t(
    'Have you ever received a study leave from the Authority?',
    'هل سبق لك الحصول على إجازة دراسية من السلطة المختصة؟',
  );

  String get alreadySubmittedInMinistryOfEducationSystem => _t(
    'Has this application already been submitted in the Ministry of Education system?',
    'هل تم إرسال هذا الطلب مسبقا في نظام التعليم الموجود في وزارة التعليم؟',
  );

  String get durationOfCourseStartDate =>
      _t('Duration of Scholarship Start Date', 'تاريخ بدء المنحة الدراسية');

  String get durationOfCourseEndDate =>
      _t('Duration of Scholarship End Date', 'تاريخ انتهاء المنحة الدراسية');
  String get vehicleRequiredFor =>
      _t('Vehicle Required For', 'المركبة المطلوبة لـ');

  String get vehicleRequiredLocation =>
      _t('Vehicle Required Location', 'موقع المركبة المطلوبة');

  String get requestTitleLogistics => _t('Request Title', 'عنوان الطلب');

  String get enterRequestTitleLogistics => _t(
    'Enter request title (min 5, max 250 characters)',
    'أدخل عنوان الطلب (5 أحرف كحد أدنى و250 كحد أقصى)',
  );

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
  String get airportEntryPermitSecurityPrivacyPolicy => _t(
    'I agree to comply with CAA\'s security policies.',
    'سياسة الأمان والخصوصية',
  );

  String get servicesLabel => _t('Services', 'الخدمات');

  String get declaration => _t('Declaration', 'إقرار');

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
  String get vehicleNumberId => _t('Vehicle Number', 'رقم المركبة');

  String get typeOfMaintenanceRequired => _t('Maintenance Type', 'نوع الصيانة');

  String get typeOfMaintenanceDetailsRequired =>
      _t('Type of Maintenance Required', 'نوع الصيانة المطلوبة');

  String get preventive => _t('Preventive', 'صيانة وقائية');

  String get corrective => _t('Corrective', 'صيانة تصحيحية');

  String get writeHere => _t(
    'Write Here... (min 10 characters, max 255 characters)',
    'اكتب هنا... (الحد الأدنى 10 أحرف، الحد الأقصى 255 حرف)',
  );
  String get issueDescription => _t('Issue Description', 'وصف المشكلة');

  String get preferredMaintenanceDate =>
      _t('Preferred Maintenance Date', 'تاريخ الصيانة المرغوب');

  String get requestSubmissionDate =>
      _t('Request Submission Date', 'تاريخ تقديم الطلب');

  String get maintenanceType => _t('Maintenance Type', 'نوع الصيانة');

  /// Book CAA Halls
  ///
  String get expectedNumberOfAttendeesOptional => _t(
    'Expected Number of Attendees (Optional)',
    'العدد المتوقع للحضور (اختياري)',
  );

  String get selectHall => _t('Select Hall', 'اختر القاعة');

  String get typeOfHall => _t('Type of Hall', 'نوع القاعة');

  String get typeOfHallConferenceHall => _t('Conference Hall', 'قاعة مؤتمرات');

  String get typeOfHallMeetingHall => _t('Meeting Hall', 'قاعة اجتماعات');

  String get caaConferenceHall =>
      _t('CAA Conference Hall', 'قاعة مؤتمرات هيئة الطيران المدني');

  String get caaMeetingHall =>
      _t('CAA Meeting Hall', 'قاعة اجتماعات هيئة الطيران المدني');

  String get hallName => _t('Hall Name', 'اسم القاعة');

  String get expectedNumberOfAttendees =>
      _t('Expected Number of Attendees', 'العدد المتوقع للحضور');

  String get purposeOfEvent => _t('Purpose of Event', 'الغرض من الفعالية');

  String get purposeOfEventMeeting =>
      _t('Purpose of Event / Meeting', 'الغرض من الفعالية / الاجتماع');

  String get purposeOfEventMeetingRequired => _t(
    'Purpose of Event / Meeting is required',
    'الغرض من الفعالية / الاجتماع مطلوب',
  );

  String get typeOfHallRequired =>
      _t('Type of Hall is required', 'نوع القاعة مطلوب');

  String get startDateRequired =>
      _t('Start Date is required', 'تاريخ البداية مطلوب');

  String get endDateRequired =>
      _t('End Date is required', 'تاريخ النهاية مطلوب');

  String get startTimeRequired =>
      _t('Start Time is required', 'وقت البداية مطلوب');

  String get endTimeRequired => _t('End Time is required', 'وقت النهاية مطلوب');

  String get hallSelectionRequired =>
      _t('Hall selection is required', 'اختيار القاعة مطلوب');

  String get validAttendeeCountRequired =>
      _t('Please enter a valid attendee count', 'يرجى إدخال عدد حضور صالح');

  String get topic => _t('Topic', 'الموضوع');

  String get concernedDepartment =>
      _t('Concerned Department', 'الإدارة المعنية');

  String get dateFrom => _t('Date From', 'التاريخ من');

  String get dateTo => _t('Date To', 'التاريخ إلى');

  String get sentBy => _t('Sent By', 'أرسل بواسطة');

  String get sentDate => _t('Sent Date', 'تاريخ الإرسال');

  /// Follow-up report
  String get followUpEnterSentBy => _t('Enter Sent By', 'أدخل اسم المرسل');

  String get followUpSentByRequired =>
      _t('Sent By is required', 'اسم المرسل مطلوب');

  String get followUpLetterDateRequired =>
      _t('Letter Date is required', 'تاريخ الخطاب مطلوب');

  String get followUpEnterSubject => _t('Enter Subject', 'أدخل الموضوع');

  String get followUpSubjectRequired =>
      _t('Subject is required', 'الموضوع مطلوب');

  String get followUpSelectSubjectClassification =>
      _t('Select Subject Classification', 'اختر تصنيف الموضوع');

  String get followUpSubjectClassificationRequired =>
      _t('Subject Classification is required', 'تصنيف الموضوع مطلوب');

  String get followUpEnterTopic => _t('Enter Topic', 'أدخل المحور');

  String get followUpTopicRequired => _t('Topic is required', 'المحور مطلوب');

  String get followUpSelectConcernedDepartment =>
      _t('Select Concerned Department', 'اختر الإدارة المعنية');

  String get followUpConcernedDepartmentRequired =>
      _t('Concerned Department is required', 'الإدارة المعنية مطلوبة');

  String get followUpDateFromRequired =>
      _t('Date From is required', 'تاريخ البداية مطلوب');

  String get followUpDateToRequired =>
      _t('Date To is required', 'تاريخ النهاية مطلوب');

  String get followUpAttachmentRequired =>
      _t('Attachment is required', 'المرفق مطلوب');

  String get followUpUploadAttachmentRequired => _t(
    'Please upload at least one attachment',
    'يرجى رفع مرفق واحد على الأقل',
  );
  String get referenceNumberSentBy =>
      _t('Reference Number (Sent By)', 'رقم القيد (مرسل من)');

  String get letterDate => _t('Letter Date', 'تاريخ الخطاب');

  String get subject => _t('Subject', 'الموضوع');

  String get subjectClassification =>
      _t('Subject Classification', 'تصنيف الموضوع');

  String get generalManagerComment =>
      _t('General Manager\'s Comment', 'تعليق المدير العام');

  String get responseDateTargetDate =>
      _t('Response Date (Target Date)', 'تاريخ الرد (التاريخ المستهدف)');

  String get actionStatus => _t('Action Status', 'حالة الإجراء');

  String get completed => _t('Completed', 'تم اللازم');

  String get inProgress => _t('In Progress', 'قيد الإجراء');

  String get noResponse => _t('No Response', 'لم يتم الرد');

  String get overdue => _t('Overdue', 'متأخر');

  String get actionTaken => _t('Action Taken', 'الإجراء المتخذ');

  String get delayPeriod => _t('Delay Period', 'فترة التأخير');

  String get followUpUrgent => _t('Urgent', 'عاجل');

  String get followUpVeryUrgent => _t('Very Urgent', 'عاجل جداً');

  String get followUpConfidential => _t('Confidential', 'سري');

  String get followUpDepartmentIt => _t('IT', 'تقنية المعلومات');

  String get followUpDepartmentHr => _t('HR', 'الموارد البشرية');

  String get followUpDepartmentTraining => _t('Training', 'التدريب');

  String get followUpDepartmentFinance => _t('Finance', 'المالية');

  String get followUpDepartmentProjectsMaintenance =>
      _t('Projects & Maintenance', 'المشاريع والصيانة');

  /// Follow-up report — action cards (stepper)
  String get followUpDetailsStepTitle => _t('Details', 'التفاصيل');

  String get followUpActionsStepTitle => _t('Actions', 'الإجراءات');

  String followUpActionCardTitle(int index) =>
      _t('Action $index', 'الإجراء $index');

  String get followUpAddAction => _t('Add', 'إضافة');

  String get followUpActionsRequired => _t(
    'Please complete all action details',
    'يرجى إكمال جميع تفاصيل الإجراء',
  );

  String get followUpSelect => _t('Select', 'اختر');

  String get followUpUpload => _t('upload', 'رفع');

  String get followUpRelevantDepartmentLabel =>
      _t('Relevant Department', 'الإدارة ذات الصلة');

  String get followUpSelectRelevantDepartment =>
      _t('Select Relevant Department', 'اختر الإدارة ذات الصلة');

  /// Action card field labels
  String get followUpSentByFieldLabel => _t(
    'Reference Number / Letter Date (Sent By)',
    'الرقم المرجعي / تاريخ الخطاب (مرسل من)',
  );

  String get followUpGeneralManagerCommentLabel =>
      _t("General Manager's Comment", 'تعليق المدير العام');

  String get followUpResponseDateLabel =>
      _t('Response Date (Target Date)', 'تاريخ الرد (التاريخ المستهدف)');

  String get followUpActionStatusLabel => _t('Action Status', 'حالة الإجراء');

  String get followUpActionTakenLabel => _t('Action Taken', 'الإجراء المتخذ');

  String get followUpEnterActionTaken =>
      _t('Enter Action Taken', 'أدخل الإجراء المتخذ');

  String get followUpDelayPeriodLabel => _t('Delay Period', 'مدة التأخير');

  String get followUpAttachmentOptionalLabel =>
      _t('Attachment (Optional)', 'المرفق (اختياري)');

  /// Sent By options
  String get followUpSentByLetter => _t('Letter', 'خطاب');

  String get followUpSentByEmail => _t('Email', 'بريد إلكتروني');

  String get followUpSentByInstruction => _t('Instruction', 'تعليمات');

  String get followUpSentByMinutes => _t('Minutes (Meeting)', 'محضر (اجتماع)');

  String get followUpSentByOther => _t('Other', 'أخرى');

  /// Subject classification options (extra)
  String get followUpNormal => _t('Normal', 'عادي');

  String get followUpImportant => _t('Important', 'مهم');

  String get followUpHighlyConfidential =>
      _t('Highly Confidential', 'سري للغاية');

  String get followUpRestricted => _t('Restricted', 'مقيد');

  String get followUpLimited => _t('Limited', 'محدود');

  /// General Manager's Comment options
  String get followUpGmReviewAction =>
      _t('For Review and Necessary Action', 'للمراجعة واتخاذ الإجراء اللازم');

  String get followUpGmInformation => _t('For Information', 'للعلم');

  String get followUpGmFollowUp => _t('Follow-up', 'متابعة');

  String get followUpGmNecessaryAction => _t(
    'For necessary action as applicable',
    'لاتخاذ الإجراء اللازم حسب الاقتضاء',
  );

  /// Response Date (Target Date) options
  String get followUpResponse10Days => _t('10 days', '10 أيام');

  String get followUpResponse7Days => _t('7 Days', '7 أيام');

  String get followUpResponse2Weeks => _t('2 Weeks', 'أسبوعان');

  String get followUpResponse1WeekTo1Month =>
      _t('1 Week - 1 Month', 'أسبوع - شهر');

  /// Action Status options
  String get followUpStatusNoResponse => _t('No Response', 'لا يوجد رد');

  String get followUpStatusCompleted => _t('Completed', 'مكتمل');

  String get followUpStatusInProgress => _t('In Progress', 'قيد التنفيذ');

  String get followUpStatusOverdue => _t('Overdue', 'متأخر');

  /// IT Services
  /// Salalah

  String get enterPersonName => _t('Enter Person Name', 'أدخل اسم الشخص');

  String get behalfOf => _t('Behalf Of', 'نيابةً عن');

  String get self => _t('Self', 'شخصي');

  String get section => _t('Section', 'القسم');

  String get sections => _t('Sections', 'الأقسام');

  String get sectionName => _t('Section Name', 'اسم القسم');

  String get departmentName => _t('Department Name', 'اسم الدائرة');

  String get departments => _t('Departments', 'الدوائر');

  String get departmentsList => _t('Departments List', 'قائمة الدوائر');

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

  /// Request Maintenance for External
  String get contactPersonName => _t('Contact Person Name', 'اسم شخص التواصل');

  String get enterContactPersonName =>
      _t('Enter contact person name', 'أدخل اسم شخص التواصل');

  String get contactPersonNumber =>
      _t('Contact Person Number', 'رقم شخص التواصل');

  String get enterContactPersonNumber =>
      _t('Enter contact person number', 'أدخل رقم شخص التواصل');

  String get contactPersonDesignation =>
      _t('Contact Person Designation', 'المسمى الوظيفي لشخص التواصل');

  String get enterContactPersonDesignation => _t(
    'Enter contact person designation',
    'أدخل المسمى الوظيفي لشخص التواصل',
  );

  String get requestForMaintenanceOfExternalStations => _t(
    'Request for Maintenance of External Stations',
    'طلب صيانة المحطات الخارجية',
  );

  String get externalStationNameOrLocation =>
      _t('External Station Name or Location', 'اسم المحطة الخارجية أو الموقع');

  String get enterExternalStationNameOrLocation => _t(
    'Enter external station name or location',
    'أدخل اسم المحطة الخارجية أو الموقع',
  );

  String get pleaseEnterExternalStationNameOrLocation => _t(
    'Please enter external station name or location',
    'يرجى إدخال اسم المحطة الخارجية أو الموقع',
  );

  String get stationCategory => _t('Station Category', 'فئة المحطة');

  String get selectStationCategory =>
      _t('Select station category', 'اختر فئة المحطة');

  String get pleaseSelectStationCategory =>
      _t('Please select station category', 'يرجى اختيار فئة المحطة');

  String get enterStationCategory =>
      _t('Enter station category', 'أدخل فئة المحطة');

  String get stationCategoryOther =>
      _t('Station Category (Other)', 'فئة المحطة (أخرى)');

  String get externalStationCategoryWorkshop => _t('Workshop', 'ورشة عمل');

  String get externalStationCategoryTraining => _t('Training', 'تدريب');

  String get externalStationCategoryAssignment => _t('Assignment', 'مهمة');

  String get typeOfIssue => _t('Type of Issue', 'نوع المشكلة');

  String get selectTypeOfIssue =>
      _t('Select type of issue', 'اختر نوع المشكلة');

  String get pleaseSelectTypeOfIssue =>
      _t('Please select type of issue', 'يرجى اختيار نوع المشكلة');

  String get enterTypeOfIssue => _t('Enter type of issue', 'أدخل نوع المشكلة');

  String get typeOfIssueOther =>
      _t('Type of Issue (Other)', 'نوع المشكلة (أخرى)');

  String get externalStationIssueEquipment => _t('Equipment', 'المعدات');

  String get externalStationIssueFacility => _t('Facility', 'المرافق');

  String get externalStationIssueInfrastructure =>
      _t('Infrastructure', 'البنية الأساسية');

  String get detailedDescription =>
      _t('Detailed Description', 'الوصف التفصيلي');

  String get enterDetailedDescription =>
      _t('Enter detailed description', 'أدخل الوصف التفصيلي');

  String get urgencyLevel => _t('Urgency Level', 'مستوى الأولوية');

  String get selectUrgencyLevel =>
      _t('Select urgency level', 'اختر مستوى الأولوية');

  String get pleaseSelectUrgencyLevel =>
      _t('Please select urgency level', 'يرجى اختيار مستوى الأولوية');

  String get externalStationUrgencyCritical => _t('Critical', 'حرج');

  String get dateOfIssueOccurred =>
      _t('Date of Issue Occurred', 'تاريخ حدوث المشكلة');

  String get selectDateOfIssueOccurred =>
      _t('Select date of issue occurred', 'اختر تاريخ حدوث المشكلة');

  // Request for support event
  String get eventTitle =>
      _t('Event Title', 'التدريب على الأمن السيبراني إجباري');

  String get dateOfEvent => _t('Date of Event', 'تاريخ الفعالية');

  String get locationOfEvent => _t('Location of Event', 'موقع الفعالية');

  String get typeOfEvent => _t('Type of Event', 'نوع الفعالية');

  String get requestFor => _t('Request For', 'نوع الطلب');

  String get attachFile => _t('Attach File', 'إرفاق ملفات');

  String get eventSupportSubmitNotePoint1 =>
      _t('Submit your request at least 3 days before the event date.', '');

  String get eventSupportSubmitNotePoint2 => _t(
    'In case of urgent requirements, contact the IT Help Desk directly for consideration.',
    '',
  );

  /// Request Maintenance
  String get pleaseSelectACategory =>
      _t('Please select a category', 'يرجى اختيار فئة');

  String get pleaseSelectASubCategory =>
      _t('Please select a sub-category', 'يرجى اختيار الفئة الفرعية');

  String get subCategory => _t('Sub Category', 'الفئة الفرعية');

  String get reasonForMaintenance =>
      _t('Reason for Maintenance', 'سبب طلب الصيانة');

  String get maintenanceCategoryStation => _t('Station', 'محطة');

  String get maintenanceCategoryResidential => _t('Residential', 'سكن');

  String get maintenanceSubCategoryElectrical =>
      _t('Electrical', 'الأعمال الكهربائية');

  String get maintenanceSubCategoryPlumbing => _t('Plumbing', 'أعمال السباكة');

  String get maintenanceSubCategoryHvac =>
      _t('HVAC', 'التكييف والتهوية والتبريد');

  String get maintenanceSubCategoryCivil => _t('Civil', 'الأعمال المدنية');

  String get maintenanceSubCategoryCleaning => _t('Cleaning', 'أعمال النظافة');

  String get buildingSiteClassification =>
      _t('Building Site Classification', 'تصنيف موقع المبنى');

  String get caaMuscatOutsideStation =>
      _t('CAA Muscat/outside station', 'مقر الهيئة بمسقط / المحطات الخارجية');

  String get housing => _t('Housing', 'وحدة سكنية');

  String get selectStation => _t('Select Station', '');

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
  String get accessCard => _t('Access Card', 'بطاقة الدخول');

  String get requestAccessCard => _t('Request A Access Card', 'طلب بطاقة دخول');

  String get enterName =>
      _t('Enter name (characters only)', 'أدخل الاسم (حروف فقط)');

  String get personName => _t('Person Name', 'اسم الشخص');

  String get enterPhoneNumber => _t('Enter Phone Number', 'أدخل رقم الهاتف');

  String get type => _t('Type', 'النوع');

  String get department => _t('Department', 'الدائرة');

  String get email => _t('Email', 'البريد الإلكتروني');

  String get category => _t('Category', 'الفئة');

  String get idNumber => _t('ID Number', 'رقم الهوية');

  String get accessCardIdNumberNote => _t(
    'Note:- ID Number (For Omanis and Residents) | Passport Number (For Foreigners outside the country)',
    'ملاحظة:- رقم الهوية (للعمانيين والمقيمين) | رقم جواز السفر (للأجانب خارج الدولة)',
  );

  String get enterPassportNumber =>
      _t('Enter Passport Number', 'أدخل رقم جواز السفر');

  String get dateOptional => _t('Date (Optional)', 'التاريخ (اختياري)');

  String get enterUniversityOrganization =>
      _t('Enter University / Organization', 'أدخل الجامعة / المنظمة');

  String get reason => _t('Reason', 'سبب الطلب');

  String get reasonMinLength =>
      _t('Must be at least 5 characters', 'يجب ألا يقل عن 5 أحرف');

  String get attachPassportSizePhotoWhiteBackground => _t(
    'Attach passport size photo (White background)',
    'إرفاق صورة بحجم جواز السفر (خلفية بيضاء)',
  );

  String get newOption => _t('New', 'جديد');

  String get renewal => _t('Renewal', 'تجديد');

  String get workers => _t('Workers', 'العمال');

  String get contractors => _t('Contractors', 'المتعاقدون');

  String get trainee => _t('Trainee', 'متدرب');

  String get employees => _t('Employees', 'الموظفون');

  String get enterPhoneNumberDigits =>
      _t('Enter Phone Number (8-10 digits)', 'أدخل رقم الهاتف (8-10 أرقام)');

  String get enterCivilIdPassportNumber => _t(
    'Enter Civil ID / Passport Number',
    'أدخل الرقم المدني / رقم جواز السفر',
  );

  String get accessCardNumberOptional =>
      _t('Access Card Number (Optional)', 'رقم بطاقة الدخول (اختياري)');

  String get enterAccessCardNumber =>
      _t('Enter Access Card Number', 'أدخل رقم بطاقة الدخول');

  String get universityOrganization =>
      _t('University / Organization', 'الجامعة / المنظمة');

  String get enterOrganization => _t('Enter Organization', 'أدخل المنظمة');

  String get reasonPlaceholder => _t(
    'Write here (min 5, max 250 characters)',
    'اكتب هنا (5 أحرف كحد أدنى و250 كحد أقصى)',
  );

  String get accessCardAttachmentLabel => _t(
    'Attachment (Passport Size Photo (White Background))',
    'المرفق (صورة بحجم جواز السفر بخلفية بيضاء)',
  );

  String accessCardRequestForOption(String en) {
    switch (en) {
      case 'Self':
        return self;
      case 'Behalf Of':
        return behalfOf;
      default:
        return en;
    }
  }

  String accessCardTypeOption(String en) {
    switch (en) {
      case 'New':
        return newOption;
      case 'Renewal':
        return renewal;
      default:
        return en;
    }
  }

  String accessCardCategoryOption(String en) {
    switch (en) {
      case 'workers':
      case 'Workers':
        return workers;
      case 'contractor':
      case 'Contractors':
        return contractors;
      case 'trainee':
      case 'Trainee':
        return trainee;
      case 'Employees':
        return employees;
      default:
        return en;
    }
  }

  /// HC Services
  /// shift allowance
  String get shiftStartDate => _t('Shift Start Date', 'تاريخ بداية المناوبة');

  String get shiftAllowancePaymentStart =>
      _t('Shift Allowance Payment Start', 'تاريخ بداية صرف بدل المناوبة');

  String get allowancePercentage => _t('Allowance Percentage', 'نسبة البدل');

  String get employeeName => _t('Employee Name', 'اسم الموظف');

  String get employeeIdNumber => _t('Employee ID Number', 'الرقم الوظيفي');

  String get financialGrade => _t('Financial Grade', 'الدرجة المالية');
  // Assign a task to employee
  String get enterRequestTitle => _t(
    'Enter request title (min 5, max 250 characters)',
    'أدخل عنوان الطلب (5 أحرف كحد أدنى و250 كحد أقصى)',
  );

  String get priority => _t('Priority', 'الأولوية');

  String get taskDescription => _t('Task Description', 'وصف المهمة');

  String get taskTitle => _t('Task Title', 'عنوان المهمة');

  String get high => _t('High', 'عالٍ');

  String get medium => _t('Medium', 'متوسط');

  String get low => _t('Low', 'منخفض');

  String get assignedToEmployeeNameId =>
      _t('Assigned To (Employee Name/ID)', 'مكلّف إلى (اسم الموظف / المعرف)');

  String get completionDate => _t('Completion Date', 'تاريخ الإتمام');

  String get completionDateOptional =>
      _t('Completion Date (Optional)', 'تاريخ الإنجاز (اختياري)');

  String get referenceNumber => _t('Reference Number', 'الرقم المرجعي');

  String get allowanceValue => _t('Allowance Value', 'قيمة البدل');

  String get shiftEndDate => _t('Shift End Date', 'تاريخ نهاية المناوبة');

  String get startTime => _t('Start Time', 'وقت البداية');

  String get endTime => _t('End Time', 'وقت النهاية');

  String get createdBy => _t('Created By', 'تم الإنشاء بواسطة');

  String get createdAt => _t('Created At', 'تاريخ الإنشاء');

  String get updatedBy => _t('Updated By', 'تم التحديث بواسطة');

  String get updatedAt => _t('Updated At', 'تاريخ التحديث');

  String get endOfServiceDate =>
      _t('End of Service Date', 'تاريخ انتهاء الخدمة');

  String get basicSalary => _t('Basic Salary', 'الراتب الأساسي');

  String get basicSalaryPerDay =>
      _t('Basic Salary Per Day', 'الراتب الأساسي اليومي');

  String get totalSalaryDue =>
      _t('Total Salary Due', 'إجمالي المستحقات المالية');

  String get remainingLeaveBalance =>
      _t('Remaining Leave Balance', 'رصيد الإجازات المتبقي');

  String get jobDescription => _t('Job Description', 'الوصف الوظيفي');

  String get numberOfYearsOfExperience =>
      _t('Number of Years of Experience', 'عدد سنوات الخبرة');

  String get requiredSkillsExpertise =>
      _t('Required Skills / Expertise', 'المهارات / الخبرات المطلوبة');

  String get educationRequirement =>
      _t('Education Requirement', 'المؤهل العلمي المطلوب');

  String get roleTitleOfResource =>
      _t('Role / Title of Resource', 'الدور / المسمى الوظيفي للوظيفة');

  String get requiredCompetencyPercentage =>
      _t('Required Competency Percentage', 'نسبة الجدارة المطلوبة');

  String get descriptionSummaryOfSkill =>
      _t('Description/Summary of Skill', 'وصف/ملخص المهارة');

  String get competencyTitleSkill =>
      _t('Competency Title | Skill', 'عنوان الجدارة | المهارة');

  String get skillCategory => _t('Skill Category', 'فئة المهارة');

  String get technical => _t('Technical', 'فني');

  String get compliance => _t('Compliance', 'الامتثال');

  String get safety => _t('Safety', 'السلامة');

  String get softSkills => _t('Soft Skills', 'المهارات الشخصية');

  String get productivity => _t('Productivity', 'الإنتاجية');

  String get behavior => _t('Behavior', 'السلوك');

  String get leadership => _t('Leadership', 'القيادة');

  String get emotionalIntelligence =>
      _t('Emotional Intelligence', 'الذكاء العاطفي');

  String get workExperienceYears =>
      _t('Work Experience (years)', 'خبرة العمل (بالسنوات)');

  String get skills => _t('Skills', 'المهارات');

  String get currentPosition => _t('Current Position', 'المنصب الحالي');

  String get fromEntity => _t('From Entity', 'جهة الإعارة');

  String get toEntity => _t('To Entity', 'جهة المُعار اليها');

  String get assignedJobPosition =>
      _t('Assigned Job Position', 'الجهة المُندب إليها');

  String get civilIdCardNumber =>
      _t('Civil ID Card Number', 'رقم البطاقة المدنية');

  String get currentJobPosition =>
      _t('Current Job Position', 'المسمى الوظيفي الحالي');

  String get assignedEmployeeName =>
      _t('Assigned Employee Name', 'اسم الموظف المُعار');

  String get salaryPaymentSource =>
      _t('Salary Payment Source', 'جهة صرف الراتب');

  String get socialProtectionFund =>
      _t('Social Protection Fund', 'صندوق الحماية الاجتماعية');

  String get salaryDetails => _t('Salary Details', 'تفاصيل الراتب');

  String get transferredToEntity =>
      _t('Transferred to Entity', 'الجهة المنقول إليها');

  String get currentEntity => _t('Current Entity', 'الجهة الحالية');

  String get positionTransferredFrom =>
      _t('Position Transferred from', 'المنصب المنقول منه');

  String get positionTransferredTo =>
      _t('Position Transferred To', 'المنصب المنقول إليه');

  String get currentJobTitle =>
      _t('Current Job Title', 'المسمى الوظيفي الحالي');

  String get proposedJobTitle =>
      _t('Proposed Job Title', 'المسمى الوظيفي المقترح');

  String get currentSalaryGrade =>
      _t('Current Salary Grade', 'الدرجة الوظيفية الحالية');

  String get proposedSalaryGrade =>
      _t('Proposed Salary Grade', 'الدرجة الوظيفية المقترحة');

  String get currentBasicSalary =>
      _t('Current Basic Salary', 'الراتب الأساسي الحالي');

  String get proposedBasicSalary =>
      _t('Proposed Basic Salary', 'الراتب الأساسي المقترح');

  String get annualPeriodicAllowance =>
      _t('Annual Periodic Allowance', 'العلاوة الدورية السنوية');

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
        return _t('Conferences', 'مؤتمرات');
      case 'Celebrations and Official Meetings':
        return _t(
          'Celebrations and Official Meetings',
          'احتفالات واجتماعات رسمية',
        );
      case 'others':
      case 'Others':
        return _t('Others', 'اخرى ');
      default:
        return en;
    }
  }

  String logisticsPurposeOfTravelOption(String en) {
    switch (en) {
      case 'Site Visit':
        return _t('Site Visit', 'زيارة ميدانية');
      case 'Airport Duty':
        return _t('Airport Duty', 'مهمة في المطار');
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
        return _t('Light Vehicle', 'المركبة الخفيفة');
      case 'Heavy vehicle':
      case 'Heavy Vehicle':
        return _t('Heavy Vehicle', 'المركبة الثقيلة');
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

  String get securityThreatDownloadFormHint => _t(
    'Download the Security threat form and fill',
    'قم بتنزيل نموذج التهديد الأمني واملأه',
  );

  String get securityThreatDownloadThreatFormLabel =>
      _t('Download Threat Form', 'تنزيل نموذج التهديد');

  String get securityThreatDownloadExcelLabel => _t('Excel', 'إكسل');

  String get securityThreatDownloadCsvLabel => _t('CSV', 'CSV');

  String get securityThreatAttachFormLabel => _t(
    'Attach Form Downloaded (Optional)',
    'إرفاق النموذج الذي تم تنزيله (اختياري)',
  );

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

  String get allocateUserTitle => _t('Allocate User', 'تعيين مستخدم');

  String get selectUser => _t('Select User', 'اختر المستخدم');

  String get userLabel => _t('User', 'المستخدم');

  String get cancelButton => _t('Cancel', 'إلغاء');

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

  /// Legal Services
  /// /// Appeal againt

  String get grievanceDetails => _t('Grievance Details', 'تفاصيل الشكوى');

  String get grievantName => _t('Grievant Name', 'اسم مقدم الشكوى');

  String get grievantEmployeeNumber =>
      _t('Grievant Employee Number', 'رقم موظف مقدم الشكوى');

  String get grievantDirectorate =>
      _t('Grievant Directorate', 'مديرية مقدم الشكوى');

  String get grievantDepartment =>
      _t('Grievant Department', 'دائرة مقدم الشكوى');

  String get grievantSection => _t('Grievant Section', 'قسم مقدم الشكوى');

  String get grievantRelationshipToMatter =>
      _t('Grievant Relationship to Matter', 'علاقة مقدم الشكوى بالموضوع');

  String get location => _t('Location', 'الموقع');

  String get times => _t('Times', 'الأوقات');

  String get requests => _t('Requests', 'الطلبات');

  String get events => _t('Events', 'الاحداث');

  String get individualsInvolved =>
      _t('Individuals Involved', 'الأشخاص المعنيون');

  String get decisionSubject => _t('Decision Subject', 'موضوع القرار');

  String get decisionDate => _t('Decision Date', 'تاريخ القرار');

  String get decisionNumber => _t('Decision Number', 'رقم القرار');
  String get extensionNumberIsRequired =>
      _t('Extension Number is required', 'رقم التحويلة مطلوب');

  String get extensionNumberMustBeExactly5Digits => _t(
    'Extension Number must be exactly 5 digits',
    'يجب أن يتكون رقم التحويلة من 5 أرقام بالضبط',
  );
  String get appealAgainstDecision =>
      _t('Appeal Against Decision', 'التظلم على القرار');

  String get appealAgainstAdministrativeDecisionsTitle => _t(
    'Appeal Against Administrative Decisions',
    'التظلم ضد القرارات الإدارية',
  );

  String get appealStepDecisionBeingGrieved =>
      _t('Decision Being Grievant', 'القرار محل التظلم');

  String get appealStepGrievantInformation =>
      _t('Grievant Information', 'بيانات مقدم التظلم');

  String get appealDeclarationAcknowledgementText => _t(
    'Declaration of the accuracy of the attached information. The grievant shall bear legal responsibility for any incorrect data.',
    'إقرار بصحة المعلومات المرفقة. يتحمل مقدم الشكوى المسؤولية القانونية عن أي بيانات غير صحيحة.',
  );

  String get attachment1 => _t('Attachment 1', 'مرفق 1');

  String get attachment2 => _t('Attachment 2', 'مرفق 2');

  /// Raise Legal Complaint
  String get raiseLegalComplaintTitle =>
      _t('Raise Legal Complaint', 'تقديم شكوى قانونية');

  String get legalComplaintStepRequestDetails =>
      _t('Request Details', 'تفاصيل الطلب');

  String get legalComplaintStepComplaintIncident =>
      _t('Complaint Incident', 'حادثة الشكوى');

  String get legalComplaintStepUserDetails =>
      _t('User Details', 'بيانات المستخدم');

  String get legalComplaintStepReviewSubmit =>
      _t('Review & Submit', 'مراجعة وإرسال');

  String get legalComplaintComplainantDetails =>
      _t('Complainant Details', 'بيانات مقدم الشكوى');

  String get legalComplaintComplainedEmployeeDetails =>
      _t('Complained Employee Details', 'بيانات الموظف محل الشكوى');

  String get incidentDate => _t('Date', 'التاريخ');

  String get incidentTime => _t('Time', 'الوقت');

  String get incidentLocation => _t('Location', 'الموقع');

  String get incidentEvents => _t('Events', 'الاحداث');

  String get otherDetailsRelatedToComplaint =>
      _t('Other Details Related to Complaint', 'تفاصيل أخرى متعلقة بالشكوى');

  String get complainantName => _t('Name', 'الاسم');

  String get positionLabel => _t('Position', 'المنصب');

  String get salaryGrade => _t('Salary Grade', 'الدرجة الوظيفية');

  String get directorateLabel => _t('Directorate', 'المديرية');

  // String get selectDepartment => _t('Select Department', 'اختر الدائرة');

  // String get selectSection => _t('Select Section', 'اختر القسم');

  String get requestDate => _t('Request Date', 'تاريخ الطلب');

  String get titleLabel => _t('Title', 'العنوان');

  String get descriptionLabel => _t('Description', 'الوصف');

  String get reviewSummaryTitle => _t('Review your request', 'راجع طلبك');

  String get selectEmployee => _t('Select Employee', 'اختر الموظف');

  String get enterRequestTitleMinMax => _t(
    'Enter request title (min 5, max 250 characters)',
    'أدخل عنوان الطلب (الحد الأدنى 5 والحد الأقصى 250 حرفاً)',
  );

  String get writeHereMinMax => _t(
    'Write here (min 5, max 250 characters)',
    'اكتب هنا (الحد الأدنى 5 والحد الأقصى 250 حرفاً)',
  );

  String dynamicFormStepOf(int current, int total) =>
      _t('Step $current of $total', 'الخطوة $current من $total');

  String get titleOfComplaint => _t('Title of the Appeal', 'عنوان التظلم');

  String get requestClassification =>
      _t('Request Classification', 'تصنيف الطلب');

  String get submissionDate => _t('Submission Date', 'تاريخ التقديم');

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
      case 'totaltickets':
        return totalRequests;
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
        return expiredLabel;
      case 'open':
        return _t('Open', 'مفتوح');
      case 'completed':
        return _t('Completed', 'مكتمل');

      case 'assigned':
        return _t('Assigned', 'تم التعيين');

      case 'inprogress':
        return _t('In Progress', 'قيد المعالجة');
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
      case 'Request Date':
        return _t('Request Date', 'تاريخ الطلب');
      case 'Request Type':
        return _t('Request Type', 'نوع الطلب');
      case 'Nationality':
        return nationality;
      case 'User Name':
        return _t('User Name', 'اسم المستخدم');
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
      case 'Type':
        return type;
      case 'Email':
        return email;
      case 'ID Number':
        return idNumber;
      case 'Person Name':
        return personName;
      case 'Access Card Number':
      case 'Access Card Number (Optional)':
        return accessCardNumberOptional;
      case 'Hotel Name':
        return hotelName;
      case 'Check-In Date':
        return checkInDate;
      case 'Request Submission Date':
        return requestSubmissionDate;
      case 'Purpose of Event':
        return purposeOfEvent;
      case 'Purpose of Event / Meeting':
        return purposeOfEventMeeting;
      case 'Sent By':
        return sentBy;
      case 'Letter Date':
        return letterDate;
      case 'Subject':
        return subject;
      case 'Subject Classification':
        return subjectClassification;
      case 'Topic':
        return topic;
      case 'Concerned Department':
        return concernedDepartment;
      case 'Date From':
        return dateFrom;
      case 'Date To':
        return dateTo;
      case 'Attachments':
        return attachmentsTabLabel;
      case 'Type of Hall':
        return typeOfHall;
      case 'Select Hall':
        return selectHall;
      case 'Hall Name':
        return hallName;
      case 'Expected Number of Attendees':
        return expectedNumberOfAttendees;
      case 'Expected Number of Attendees (Optional)':
        return expectedNumberOfAttendeesOptional;
      case 'Start Time':
        return startTime;
      case 'End Time':
        return endTime;
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
        return typeOfMaintenanceDetailsRequired;
      case 'Preferred Maintenance Date':
        return preferredMaintenanceDate;
      case 'Type Of Enquire':
        return titleOfEnquire;
      case 'Budget Code':
        return budgetCode;
      case 'Estimated Cost':
        return estimatedCost;
      case 'Type of Project':
        return typeOfProject;
      case 'Project Code/Budget Code':
        return projectCodeBudgetCode;
      case 'Title of the Complaint':
        return titleOfComplaint;
      case 'Appeal Against Decision':
        return appealAgainstDecision;
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

      case 'Profile':
        return _t('Profile', 'الملف الشخصي');

      case 'User Info':
        return _t('User Info', 'معلومات المستخدم');

      case 'section_name':
        return sectionName;

      case 'department_name':
        return departmentName;

      case 'departments':
        return departments;

      case 'departments_list':
      case 'department_list':
        return departmentsList;

      case 'employee_id':
        return employeeId;

      case 'action_taken_by':
        return workflowActionTakenBy;

      case 'requested_date':
        return _t('Requested Date', 'تاريخ الطلب');

      case 'Request Date':
        return _t('Request Date', 'تاريخ الطلب');

      case 'Reason For Request':
        return reasonForRequest;

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

      case 'Airport Name':
        return airportName;

      case 'Passport/ID Number':
      case 'Passport/ID Card NO':
        return passportIdCardNo;

      case 'Category of Permit':
        return categoryOfPermit;

      case 'Date of Submission':
      case 'Date of submission':
        return dateOfSubmission;

      case 'Phone Number':
        return phoneNumber;

      case 'Type of Permit':
        return typeOfPermit;

      case 'Permission to Required Areas':
        return permissionToRequiredAreas;

      case 'Additional Services':
        return additionalServices;

      case 'Person Name':
        return personName;

      case 'ID Number':
        return idNumber;

      case 'Date':
        return date;

      case 'Access Card Number':
      case 'Access Card Number (Optional)':
        return accessCardNumberOptional;

      case 'University / Organization':
        return universityOrganization;

      case 'Reason':
        return reason;

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

      case 'Start Time':
        return startTime;

      case 'End Time':
        return endTime;

      case 'Purpose of Event':
        return purposeOfEvent;

      case 'Purpose of Event / Meeting':
        return purposeOfEventMeeting;
      case 'Sent By':
        return sentBy;
      case 'Letter Date':
        return letterDate;
      case 'Subject':
        return subject;
      case 'Subject Classification':
        return subjectClassification;
      case 'Topic':
        return topic;
      case 'Concerned Department':
        return concernedDepartment;
      case 'Date From':
        return dateFrom;
      case 'Date To':
        return dateTo;
      case 'Attachments':
        return attachmentsTabLabel;

      case 'Type of Hall':
        return typeOfHall;

      case 'Select Hall':
        return selectHall;

      case 'Hall Name':
        return hallName;

      case 'Expected Number of Attendees':
        return expectedNumberOfAttendees;

      case 'Expected Number of Attendees (Optional)':
        return expectedNumberOfAttendeesOptional;

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

      case 'Phone':
        return phoneNumber;

      case 'Customer ID':
        return _t('Customer ID', 'رقم العميل');

      case 'Request ID':
        return _t('Request ID', 'رقم الطلب');

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
        return typeOfMaintenanceDetailsRequired;

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

      case 'Date of Loss':
        return dateOfLoss;

      case 'Time of Loss':
        return timeOfLoss;

      case 'Location Where Item Was Lost':
        return locationWhereItemWasLost;

      case 'Item Description':
        return itemDescriptionLabel;

      case 'Type of Vehicle Required':
        return typeOfVehicleRequired;

      case 'Attach File':
        return attachFile;

      case 'Request Type':
        return typeOfRequest;
      case 'Workflow Execution ID':
        return _t('Workflow Execution ID', 'معرف تنفيذ سير العمل');

      case 'Reference Number':
        return _t('Reference Number', 'الرقم المرجعي');

      case 'Employee Name':
        return _t('Employee Name', 'اسم الموظف');

      case 'Employee ID Number':
        return _t('Employee ID Number', 'الرقم الوظيفي');

      case 'Financial Grade':
        return _t('Financial Grade', 'الدرجة المالية');

      case 'Allowance Value':
        return _t('Allowance Value', 'قيمة البدل');

      case 'Shift Start Date':
        return _t('Shift Start Date', 'تاريخ بداية المناوبة');

      case 'Shift End Date':
        return _t('Shift End Date', 'تاريخ نهاية المناوبة');

      case 'Created By':
        return _t('Created By', 'تم الإنشاء بواسطة');

      case 'Created At':
        return _t('Created At', 'تاريخ الإنشاء');

      case 'Updated By':
        return _t('Updated By', 'تم التحديث بواسطة');

      case 'Updated At':
        return _t('Updated At', 'تاريخ التحديث');

      case 'End of Service Date':
        return _t('End of Service Date', 'تاريخ انتهاء الخدمة');

      case 'Basic Salary':
        return _t('Basic Salary', 'الراتب الأساسي');

      case 'Basic Salary Per Day':
        return _t('Basic Salary Per Day', 'الراتب الأساسي اليومي');

      case 'Total Salary Due':
        return _t('Total Salary Due', 'إجمالي المستحقات المالية');

      case 'Remaining Leave Balance':
        return _t('Remaining Leave Balance', 'رصيد الإجازات المتبقي');

      case 'Job Description':
        return _t('Job Description', 'الوصف الوظيفي');

      case 'Number of Years of Experience':
        return _t('Number of Years of Experience', 'عدد سنوات الخبرة');

      case 'Required Skills / Expertise':
        return _t('Required Skills / Expertise', 'المهارات / الخبرات المطلوبة');

      case 'Education Requirement':
        return _t('Education Requirement', 'المؤهل العلمي المطلوب');

      case 'Role / Title of Resource':
        return _t('Role / Title of Resource', 'الدور / المسمى الوظيفي للوظيفة');
      case 'Required Competency Percentage':
        return _t('Required Competency Percentage', 'نسبة الجدارة المطلوبة');

      case 'Description/Summary of Skill':
        return _t('Description/Summary of Skill', 'وصف/ملخص المهارة');

      case 'Competency Title | Skill':
        return _t('Competency Title | Skill', 'عنوان الجدارة | المهارة');

      case 'Skill Category':
        return _t('Skill Category', 'فئة المهارة');

      case 'Technical':
        return _t('Technical', 'فني');

      case 'Compliance':
        return _t('Compliance', 'الامتثال');

      case 'Safety':
        return _t('Safety', 'السلامة');

      case 'Soft Skills':
        return _t('Soft Skills', 'المهارات الشخصية');
      case 'Productivity':
        return _t('Productivity', 'الإنتاجية');

      case 'Behavior':
        return _t('Behavior', 'السلوك');

      case 'Leadership':
        return _t('Leadership', 'القيادة');

      case 'Emotional Intelligence':
        return _t('Emotional Intelligence', 'الذكاء العاطفي');

      case 'Work Experience (years)':
        return _t('Work Experience (years)', 'خبرة العمل (بالسنوات)');

      case 'Skills':
        return _t('Skills', 'المهارات');

      case 'Current Position':
        return _t('Current Position', 'المنصب الحالي');
      case 'From Entity':
        return _t('From Entity', 'جهة الإعارة');

      case 'To Entity':
        return _t('To Entity', 'جهة المُعار اليها');

      case 'Assigned Job Position':
        return _t('Assigned Job Position', 'الجهة المُندب إليها');

      case 'Civil ID Card Number':
        return _t('Civil ID Card Number', 'رقم البطاقة المدنية');

      case 'Current Job Position':
        return _t('Current Job Position', 'المسمى الوظيفي الحالي');

      case 'Assigned Employee Name':
        return _t('Assigned Employee Name', 'اسم الموظف المُعار');
      case 'Salary Payment Source':
        return _t('Salary Payment Source', 'جهة صرف الراتب');

      case 'Social Protection Fund':
        return _t('Social Protection Fund', 'صندوق الحماية الاجتماعية');
      case 'Salary Details':
        return _t('Salary Details', 'تفاصيل الراتب');

      case 'Transferred to Entity':
        return _t('Transferred to Entity', 'الجهة المنقول إليها');

      case 'Current Entity':
        return _t('Current Entity', 'الجهة الحالية');

      case 'Position Transferred from':
        return _t('Position Transferred from', 'المنصب المنقول منه');

      case 'Position Transferred To':
        return _t('Position Transferred To', 'المنصب المنقول إليه');
      case 'Current Job Title':
        return _t('Current Job Title', 'المسمى الوظيفي الحالي');

      case 'Proposed Job Title':
        return _t('Proposed Job Title', 'المسمى الوظيفي المقترح');

      case 'Current Salary Grade':
        return _t('Current Salary Grade', 'الدرجة الوظيفية الحالية');

      case 'Proposed Salary Grade':
        return _t('Proposed Salary Grade', 'الدرجة الوظيفية المقترحة');

      case 'Current Basic Salary':
        return _t('Current Basic Salary', 'الراتب الأساسي الحالي');

      case 'Proposed Basic Salary':
        return _t('Proposed Basic Salary', 'الراتب الأساسي المقترح');
      case 'Annual Periodic Allowance':
        return _t('Annual Periodic Allowance', 'العلاوة الدورية السنوية');

      case 'Type Of Enquire':
        return titleOfEnquire;

      case 'Budget Code':
        return budgetCode;

      case 'Estimated Cost':
        return estimatedCost;

      case 'Type of Project':
        return typeOfProject;

      case 'Project Code/Budget Code':
        return projectCodeBudgetCode;

      case 'Company Name':
        return companyName;

      case 'Title of the Complaint':
        return titleOfComplaint;

      case 'Appeal Against Decision':
        return appealAgainstDecision;

      case 'Request Classification':
        return requestClassification;

      case 'Decision Number':
        return decisionNumber;

      case 'Decision Date':
        return decisionDate;

      case 'Decision Subject':
        return decisionSubject;

      case 'Grievance Details':
        return grievanceDetails;

      case 'Individuals Involved':
        return individualsInvolved;

      case 'Dates':
        return _t('Dates', 'التواريخ');

      case 'Requests':
        return requests;

      case 'Events':
        return events;

      case 'Grievant Name':
        return grievantName;

      case 'Grievant Employee Number':
        return grievantEmployeeNumber;

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

  String get servicesAllServices => _t('All Services', 'جميع الخدمات');

  String get servicesMyServices => _t('My Services', 'خدماتي');

  String get servicesSearchPlaceholder =>
      _t('Search by Service name', 'البحث باسم الخدمة');

  String loginLanguageDisplayName(String code) {
    switch (code) {
      case 'ar':
        return 'العربية';
      default:
        return 'English';
    }
  }
}
