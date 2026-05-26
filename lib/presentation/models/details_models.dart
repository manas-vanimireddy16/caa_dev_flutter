import 'dart:convert';

import 'package:code_setup/presentation/screens/asset_affairs/models/accommodation_in_muscat_model.dart';
import 'package:code_setup/presentation/screens/aviation_security_Facilitation/models/airport_entry_request_model.dart';
import 'package:code_setup/presentation/screens/hr_service/models/goal_weight_model.dart';
import 'package:code_setup/presentation/screens/hr_service/models/human_resource_annual_plan.dart';
import 'package:code_setup/presentation/screens/information_security_services/models/cyber_security_risk_management_model.dart';
import 'package:code_setup/utils/mappers/approval_detail_mapper.dart';

RequestDetailModel welcomeFromJson(String str) =>
    RequestDetailModel.fromJson(json.decode(str));

String welcomeToJson(RequestDetailModel data) => json.encode(data.toJson());

class RequestDetailModel {
  String? status;
  RequestDetailData? data;

  RequestDetailModel({this.status, this.data});

  factory RequestDetailModel.fromJson(Map<String, dynamic> json) =>
      RequestDetailModel(
        status: json["status"],
        data: json["data"] == null
            ? null
            : RequestDetailData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"status": status, "data": data?.toJson()};
}

class RequestDetailData {
  RequestModel? request;
  final CyberSecurityRiskModel? risk;

  List<WorkflowDetailModel>? workflowDetails;
  List<ApprovalDetailModel>? approvalDetails;
  List<ChatMessageModel>? chatMessages;
  List<AttachmentModel>? attachments;
  final List<GoalModel>? goals;
  final int? id;
  final int? serviceId;
  final int? subServiceId;

  final String? description;
  final String? status;
  final String? priority; // NEW
  final int? typeOfThreat; // NEW

  final String? workflowExecutionId;
  final int? createdBy;
  final String? createdAt;
  final int? updatedBy;
  final String? updatedAt;
  final int? userId;

  final int? reqUserDepartmentId;
  final int? reqUserSectionId;

  // ─────────────────────────────
  // CONTACT INFO (Salalah)
  // ─────────────────────────────
  final String? contactNum; // contact_number / contact_num
  final String? extnNum; // extension_number
  final String? email;
  final String? personName;
  final String? personContactNumber;
  final String? requestFor;
  final String? problem;
  final String? requestDate;
  final int? serviceTypeId;
  final String? requestType;

  // ─────────────────────────────
  // LOGISTICS FIELDS
  // ─────────────────────────────
  final String? category;
  final String? vehicleRequiredFor;
  final String? vehicleRequiredLocation;
  final String? title;
  final String? purposeOfTravel;
  final String? typeOfVehicleRequired;
  final String? typeOfRequest;
  final String? dateOfTravel;
  final String? timeOfTravel;
  final int? expDurationOfUseHrs;
  final int? expDurationOfUseDays;

  // ─────────────────────────────
  // ACCOMMODATION FIELDS
  // ─────────────────────────────
  final String? hotelName;
  final String? typeOfAccommodation;
  final int? numberOfGuests;
  final List<String>? meal;
  final String? price;
  final String? requestedBy;
  final bool? hrApproval;
  final bool? prApproval;
  final String? checkInDate;
  final String? checkInTime;
  final String? checkOutDate;
  final String? checkOutTime;
  final String? dateOfRequest;
  final String? visitorName;

  // ─────────────────────────────
  // SECURITY AWARENESS FIELDS
  // ─────────────────────────────
  final String? dateOfSubmission;
  final String? phoneNumber;
  final String? place;
  final String? eventDate;
  final String? eventTime;
  final String? mediaCoverageRequired;

  // ─────────────────────────────
  // AIRPORT ENTRY / PERMIT FIELDS
  // ─────────────────────────────
  final String? nameFullFamilyName;
  final String? nationality;
  final String? dob;
  final String? passportIdCardNo;
  final String? categoryOfPermit;
  final String? typeOfPermit;

  final List<String>? permissionToRequiredAreas;
  final String? occupationStaff;
  final String? temporaryStartTime;
  final String? temporaryDuration;
  final List<String>? forVisitor;
  final String? currentEntity;
  final String? transferredToEntity;

  final String? salaryDetails;
  final String? salaryDetailsDescription;

  // ─────────────────────────────
  // CONSENTS / FLAGS
  // ─────────────────────────────
  final bool? acknowledgeSecurityPolicies;
  final bool? acknowledgeDisciplinaryAction;
  final bool? consentApproveToIssuePermit;
  final bool? consentDoNotApproveToIssuePermit;
  final String? consentJustification;

  // ─────────────────────────────
  // META
  // ─────────────────────────────
  final String? requestId;
  final String? expirationDate;
  final String? attachmentUrl;

  // ─────────────────────────────
  // NESTED OBJECTS
  // ─────────────────────────────
  final UserModel? createdByUser;
  final ServiceTypeModel? serviceType;
  final ServiceModel? service;
  final SubServiceModel? subService;
  final DepartmentModel? reqDepartment;
  final SectionModel? reqSection;

  // ─────────────────────────────
  // ASSIGNMENT DECISION FIELDS
  // ─────────────────────────────
  final bool? isDeleted;

  final int? assignedToUserId;
  final String? assignedAt;
  final int? reviewerUserId;

  final String? assignedEmployeeName;
  final String? civilIdCardNumber;
  final String? employeeId;
  final String? currentJobPosition;
  final String? assignedJobPosition;

  final String? startDate;
  final String? endDate;
  final String? assignmentAllowance;
  final List<String>? reasonForRequest;

  // Replacement
  final bool? isReplaced;
  final String? replacementEmployeeName;
  final String? replacementEmployeeId;
  final String? replacementCivilIdCardNumber;
  final String? replacementReason;
  final int? replacedByUserId;
  final String? replacedAt;
  final int? reqUserPositionId;
  final int? originalDepartmentId;
  final int? assignedDepartmentId;
  final String? fromEntity;
  final String? toEntity;
  final dynamic assignedToRole;

  /// ─────────────────────────────
  /// TASK MANAGEMENT FIELDS (NEW)
  /// ─────────────────────────────
  final String? taskTitle;
  final String? taskDescription;
  final String? completionDate;

  // ─────────────────────────────
  // DUTY MISSION FIELDS (NEW)
  // ─────────────────────────────
  final String? tripType;
  final String? chooseType;

  final String? missionSponsoredBy;
  final String? missionPurpose;
  final String? missionNumber;
  final String? missionId;

  final String? missionStartDate;
  final String? missionEndDate;

  final String? travellingAreaFrom;
  final String? travellingAreaTo;

  final String? fromCountry;
  final String? toCountry;
  final String? travelPlace;

  final String? travelStartDate;
  final String? travelReturnDate;

  final int? missionDays;
  final String? distance;

  final String? ifSponsored;
  final String? allowancePercentage;
  final String? airTicketRequired;
  final String? vehicleRequired;
  final String? remarks;

  // ─────────────────────────────
  // DUTY MISSION NESTED LISTS
  // ─────────────────────────────
  final List<EmployeeDutyMission>? employeesDetails;
  final List<AirTicketDetail>? airTicketDetails;

  // ─────────────────────────────
  // REQUEST FOR COVERAGE (MEDIA) FIELDS
  // ─────────────────────────────
  final String? eventLocation;
  final String? eventDetails;
  final String? importanceOfPublishing;
  final String? directorateName;
  final bool? requiredForPresident;
  final int? departmentId; // Media / Communication department
  final String? suggestedPhotography;
  final String? newsSize;
  final String? eventObjective;
  final String? organizingEntity;
  final String? hostedPerson;
  final String? audience;
  final String? rejectionReason;
  final String? documentType;

  // ─────────────────────────────
  // TRAINING ROOM BOOKING FIELDS
  // ─────────────────────────────
  final String? purposeOfTraining;
  final String? dateOfEvent;
  final String? startTime;
  final String? endTime;
  final String? roomType;
  final int? numberOfAttendees;
  final bool? networkSupportRequired;
  final bool? mealsRequired;

  /// ─────────────────────────────
  /// TRAINING DETAILS (MISSING FIELDS ADDED)
  /// ─────────────────────────────
  final String? courseName;
  final int? noOfParticipants;
  final String? courseCost;
  final String? totalCost;
  final String? reason;
  final String? location;
  final List<dynamic>? employeeList;
  final String? proposedImplementationDate;

  /// ─────────────────────────────
  /// TRAINING REQUEST (CAA015) FIELDS
  /// ─────────────────────────────
  final String? typeOfTraining;
  final String? typeOfCategory;

  final int? noOfAttendees;

  final String? durationOfCourse;
  final String? instituteName;
  final String? courseStartDate;
  final String? courseEndDate;

  /// Transfer specific fields only
  final String? positionToBeTransferred;
  final String? effectiveFromDate;
  final String? decisionNumber;

  /// Employee info
  final String? employeeName;
  final String? jobTitle;
  final String? financialGrade;

  /// Shift details
  final DateTime? shiftStartDate;
  final DateTime? shiftEndDate;

  /// Employee Info
  ///
  final String? salaryGrade;

  /// Leave Calculation Fields
  final String? remainingLeaveBalance;
  final String? basicSalary;
  final String? totalSalaryDue;
  final DateTime? endOfServiceDate;
  final String? reasonForTermination;
  final String? salaryPaymentSource;
  final String? socialServiceFundContribution;
  final String? positionToBeFilled;
  final String? grade;
  final String? roleTitle;
  final String? educationRequirements;
  final String? requiredSkills;
  final String? yearsOfExperience;
  final String? jobDescription;

  /// Current Details
  final String? currentBasicSalary;
  final String? currentJobTitle;
  final String? currentSalaryGrade;

  /// Proposed Details
  final String? proposedBasicSalary;
  final String? proposedJobTitle;
  final String? proposedSalaryGrade;
  final String? certificationTitle;
  final String? skillCategory;
  final String? issuingAuthority;
  final String? skillSummary;
  final String? additionalInfoRequested;

  /// Performance Management Fields
  final String? cyclePeriod;
  final int? cycleYear;
  final String? extensionNumber;
  final String? quater;
  final int? year;
  final List<TaskModel>? tasks;

  /// Accommodation in Muscat specific fields
  final int? durationOfDays;
  final String? travellingFromRegion;
  final String? travelFrom;
  final String? travelTo;
  final String? timeOfArrival;
  final String? startDateOfStay;
  final String? referenceNumber;
  final String? otherPurposeSpecification;
  final String? officialPurposeOfTravel;
  final int? numberOfEmployeesTravelling;
  final List<AccommodationEmployeeDetails>? employeeDetails;
  final String? unitType;
  final int? familySize;
  final String? locationOfStay;
  final String? durationOfStay;
  final String? reasonForRenewal;
  final String? requestedRenewalDuration;
  final String? approverComment;
  final String? handoverDate;
  final String? pendingBillsClearanceStatus;
  final String? reasonForCancellation;
  final String? requestedCancellationDate;
  final String? currentContractEndDate;
  final String? currentContractStartDate;
  final String? currentUnitType;
  final String? eventTitle;
  final String? locationOfEvent;
  final String? typeOfEvent;
  final int? eventDepartmentId;
  RequestDetailData({
    this.request,
    this.risk,
    this.workflowDetails,
    this.approvalDetails,
    this.chatMessages,
    this.attachments,
    this.goals,
    this.id,
    this.serviceId,
    this.subServiceId,
    this.description,
    this.status,
    this.priority,
    this.typeOfThreat,
    this.workflowExecutionId,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.userId,
    this.reqUserDepartmentId,
    this.reqUserSectionId,

    this.contactNum,
    this.extnNum,
    this.email,
    this.personName,
    this.personContactNumber,
    this.requestFor,
    this.problem,
    this.requestDate,
    this.serviceTypeId,
    this.requestType,

    this.category,
    this.vehicleRequiredFor,
    this.vehicleRequiredLocation,
    this.title,
    this.purposeOfTravel,
    this.typeOfVehicleRequired,
    this.typeOfRequest,
    this.dateOfTravel,
    this.timeOfTravel,
    this.expDurationOfUseHrs,
    this.expDurationOfUseDays,

    this.hotelName,
    this.typeOfAccommodation,
    this.numberOfGuests,
    this.meal,
    this.price,
    this.requestedBy,
    this.hrApproval,
    this.prApproval,
    this.checkInDate,
    this.checkInTime,
    this.checkOutDate,
    this.checkOutTime,
    this.dateOfRequest,
    this.visitorName,

    this.createdByUser,
    this.serviceType,
    this.service,
    this.subService,
    this.reqDepartment,
    this.reqSection,

    this.dateOfSubmission,
    this.phoneNumber,
    this.place,
    this.eventDate,
    this.eventTime,
    this.mediaCoverageRequired,
    this.nameFullFamilyName,
    this.nationality,
    this.dob,
    this.passportIdCardNo,
    this.categoryOfPermit,
    this.typeOfPermit,
    this.permissionToRequiredAreas,
    this.occupationStaff,
    this.temporaryStartTime,
    this.temporaryDuration,
    this.forVisitor,
    this.acknowledgeSecurityPolicies,
    this.acknowledgeDisciplinaryAction,
    this.consentApproveToIssuePermit,
    this.consentDoNotApproveToIssuePermit,
    this.consentJustification,
    this.requestId,
    this.expirationDate,
    this.attachmentUrl,

    this.isDeleted,

    this.assignedToUserId,
    this.assignedAt,
    this.reviewerUserId,

    this.assignedEmployeeName,
    this.civilIdCardNumber,
    this.employeeId,
    this.currentJobPosition,
    this.assignedJobPosition,

    this.startDate,
    this.endDate,
    this.assignmentAllowance,
    this.reasonForRequest,

    this.isReplaced,
    this.replacementEmployeeName,
    this.replacementEmployeeId,
    this.replacementCivilIdCardNumber,
    this.replacementReason,
    this.replacedByUserId,
    this.replacedAt,
    this.reqUserPositionId,
    this.originalDepartmentId,
    this.assignedDepartmentId,
    this.fromEntity,
    this.toEntity,
    this.assignedToRole,

    this.currentEntity,
    this.transferredToEntity,

    this.salaryDetails,
    this.salaryDetailsDescription,
    this.taskTitle,
    this.taskDescription,
    this.completionDate,

    this.tripType,
    this.chooseType,
    this.missionSponsoredBy,
    this.missionPurpose,
    this.missionNumber,
    this.missionId,
    this.missionStartDate,
    this.missionEndDate,
    this.travellingAreaFrom,
    this.travellingAreaTo,
    this.fromCountry,
    this.toCountry,
    this.travelPlace,
    this.travelStartDate,
    this.travelReturnDate,
    this.missionDays,
    this.distance,
    this.ifSponsored,
    this.allowancePercentage,
    this.airTicketRequired,
    this.vehicleRequired,
    this.remarks,
    this.employeesDetails,
    this.airTicketDetails,

    this.eventLocation,
    this.eventDetails,
    this.importanceOfPublishing,
    this.directorateName,
    this.requiredForPresident,
    this.departmentId,
    this.suggestedPhotography,
    this.newsSize,
    this.eventObjective,
    this.organizingEntity,
    this.hostedPerson,
    this.audience,
    this.rejectionReason,
    this.documentType,
    this.purposeOfTraining,
    this.dateOfEvent,
    this.startTime,
    this.endTime,
    this.roomType,
    this.numberOfAttendees,
    this.networkSupportRequired,
    this.mealsRequired,
    this.courseName,
    this.noOfParticipants,
    this.courseCost,
    this.totalCost,
    this.reason,
    this.location,
    this.employeeList,
    this.proposedImplementationDate,
    this.typeOfTraining,
    this.typeOfCategory,
    this.noOfAttendees,

    this.durationOfCourse,
    this.instituteName,
    this.courseStartDate,
    this.courseEndDate,

    this.positionToBeTransferred,
    this.effectiveFromDate,
    this.decisionNumber,
    this.employeeName,
    this.jobTitle,
    this.financialGrade,
    this.shiftStartDate,
    this.shiftEndDate,
    this.salaryGrade,
    this.remainingLeaveBalance,
    this.basicSalary,
    this.totalSalaryDue,
    this.endOfServiceDate,
    this.reasonForTermination,

    this.salaryPaymentSource,
    this.socialServiceFundContribution,
    this.positionToBeFilled,
    this.grade,
    this.roleTitle,
    this.educationRequirements,
    this.requiredSkills,
    this.yearsOfExperience,
    this.jobDescription,
    this.currentBasicSalary,
    this.currentJobTitle,
    this.currentSalaryGrade,
    this.proposedBasicSalary,
    this.proposedJobTitle,
    this.proposedSalaryGrade,
    this.certificationTitle,
    this.skillCategory,
    this.issuingAuthority,
    this.skillSummary,
    this.additionalInfoRequested,
    this.cyclePeriod,
    this.cycleYear,
    this.extensionNumber,
    this.quater,
    this.year,
    this.tasks,
    this.durationOfDays,
    this.travellingFromRegion,
    this.travelFrom,
    this.travelTo,
    this.timeOfArrival,
    this.startDateOfStay,
    this.referenceNumber,
    this.otherPurposeSpecification,
    this.officialPurposeOfTravel,
    this.numberOfEmployeesTravelling,
    this.employeeDetails,
    this.unitType,
    this.familySize,
    this.locationOfStay,
    this.durationOfStay,
    this.reasonForRenewal,
    this.requestedRenewalDuration,
    this.approverComment,
    this.handoverDate,
    this.pendingBillsClearanceStatus,
    this.reasonForCancellation,
    this.requestedCancellationDate,
    this.currentContractEndDate,
    this.currentContractStartDate,
    this.currentUnitType,
    this.eventTitle,
    this.locationOfEvent,
    this.typeOfEvent,
    this.eventDepartmentId,
  });
  static List<String> parseStringList(dynamic data) {
    try {
      if (data == null) return [];

      /// Already List
      if (data is List) {
        return data.map((e) => e.toString()).toList();
      }

      /// Single String
      if (data is String) {
        return [data];
      }

      return [];
    } catch (e) {
      print("❌ parseStringList Error: $e");
      print("❌ Value: $data");
      return [];
    }
  }

  factory RequestDetailData.fromJson(
    Map<String, dynamic> json,
  ) => RequestDetailData(
    request: json["request"] == null
        ? null
        : RequestModel.fromJson(json["request"]),
    risk: json['risks'] != null
        ? CyberSecurityRiskModel.fromJson(json['risks'] as Map<String, dynamic>)
        : null,

    workflowDetails:
        (json["workflow_details"] ?? json["workflow_logs"] ?? []) is List
        ? (json["workflow_details"] ?? json["workflow_logs"])
              .map<WorkflowDetailModel>((x) => WorkflowDetailModel.fromJson(x))
              .toList()
        : [],

    // approvalDetails: (json['approval_details'] ?? json['approvals']) == null
    //     ? []
    //     : List<ApprovalDetailModel>.from(
    //         (json['approval_details'] ?? json['approvals']).map(
    //           (x) => ApprovalDetailModel.fromJson(x),
    //         ),
    //       ),
    approvalDetails: ((json['approval_details'] ?? json['approvals']) as List?)
        ?.map((e) {
          final normalizedJson = ApprovalDetailMapper.normalize(
            e as Map<String, dynamic>,
          );
          return ApprovalDetailModel.fromJson(normalizedJson);
        })
        .toList(),

    chatMessages: json["chat_messages"] == null
        ? []
        : List<ChatMessageModel>.from(
            json["chat_messages"]!.map((x) => ChatMessageModel.fromJson(x)),
          ),

    attachments: json["attachments"] == null
        ? []
        : List<AttachmentModel>.from(
            json["attachments"]!.map((x) => AttachmentModel.fromJson(x)),
          ),

    goals: json['goals'] == null
        ? []
        : List<GoalModel>.from(json['goals'].map((x) => GoalModel.fromJson(x))),
    id: json["id"],
    serviceId: json["service_id"],
    subServiceId: json["sub_service_id"],

    description: json["description"],
    status: json["status"],
    priority: json["priority"] ?? json["request_priority"],
    typeOfThreat: json["type_of_threat"] ?? json["typeOfThreat"],

    workflowExecutionId: json["workflow_execution_id"],
    createdBy: json["created_by"],
    createdAt: json["created_at"],
    updatedBy: json["updated_by"],
    updatedAt: json["updated_at"],
    userId: json["user_id"],

    reqUserDepartmentId: json["req_user_department_id"],
    reqUserSectionId: json["req_user_section_id"],

    contactNum: json["contact_number"] ?? json["contact_num"],
    extnNum: json["extension_number"] ?? json["extn_num"],
    email: json["email"],
    personName: json["person_name"],
    personContactNumber: json["person_contact_number"],
    requestFor: json["request_for"],
    problem: json["problem"],
    requestDate: json["request_date"],
    serviceTypeId: json["service_type_id"],
    requestType: json["request_type"],

    category: json["category"],
    vehicleRequiredFor: json["vehicle_required_for"],
    vehicleRequiredLocation: json["vehicle_required_location"],
    title: json["title"],
    purposeOfTravel: json["purpose_of_travel"],
    typeOfVehicleRequired: json["type_of_vehicle_required"],
    typeOfRequest: json["type_of_request"],
    dateOfTravel: json["date_of_travel"],
    timeOfTravel: json["time_of_travel"],
    expDurationOfUseHrs: json["exp_duration_of_use_hrs"],
    expDurationOfUseDays: json["exp_duration_of_use_days"],

    hotelName: json["hotel_name"],
    typeOfAccommodation: json["type_of_accommodation"],
    numberOfGuests: json["number_of_guests"],
    meal: json["meal"] != null ? List<String>.from(json["meal"]) : null,
    price: json["price"],
    requestedBy: json["requested_by"],
    hrApproval: json["hr_approval"],
    prApproval: json["pr_approval"],
    checkInDate: json["check_in_date"],
    checkInTime: json["check_in_time"],
    checkOutDate: json["check_out_date"],
    checkOutTime: json["check_out_time"],
    dateOfRequest: json["date_of_request"],
    visitorName: json["visitor_name"],

    createdByUser: json["created_by_user"] != null
        ? UserModel.fromJson(json["created_by_user"])
        : null,

    serviceType: json["service_type"] != null
        ? ServiceTypeModel.fromJson(json["service_type"])
        : null,

    service: json["service"] != null
        ? ServiceModel.fromJson(json["service"])
        : null,

    subService: json["sub_service"] != null
        ? SubServiceModel.fromJson(json["sub_service"])
        : null,

    reqDepartment: json["req_department"] != null
        ? DepartmentModel.fromJson(json["req_department"])
        : null,

    reqSection: json["req_section"] != null
        ? SectionModel.fromJson(json["req_section"])
        : null,

    dateOfSubmission: json["date_of_submission"],
    phoneNumber: json["phone_number"],
    place: json["place"],
    eventDate: json["event_date"],
    eventTime: json["event_time"],
    mediaCoverageRequired: json["media_coverage_required"],
    nameFullFamilyName: json["name_full_family_name"],
    nationality: json["nationality"],
    dob: json["dob"],
    passportIdCardNo: json["passport_id_card_no"],
    categoryOfPermit: json["category_of_permit"],
    typeOfPermit: json["type_of_permit"],

    permissionToRequiredAreas: json["permission_to_required_areas"] != null
        ? List<String>.from(json["permission_to_required_areas"])
        : null,

    occupationStaff: json["occupation_staff"],
    temporaryStartTime: json["temporary_start_time"],
    temporaryDuration: json["temporary_duration"],

    forVisitor: json["for_visitor"] != null
        ? List<String>.from(json["for_visitor"])
        : null,

    acknowledgeSecurityPolicies: json["acknowledge_security_policies"],
    acknowledgeDisciplinaryAction: json["acknowledge_disciplinary_action"],
    consentApproveToIssuePermit: json["consent_approve_to_issue_permit"],
    consentDoNotApproveToIssuePermit:
        json["consent_do_not_approve_to_issue_permit"],
    consentJustification: json["consent_justification"],

    requestId: json["request_id"],
    expirationDate: json["expiration_date"],
    attachmentUrl: json["attachment_url"],
    isDeleted: json["is_deleted"],

    assignedToUserId: json["assigned_to_user_id"],
    assignedAt: json["assigned_at"],
    reviewerUserId: json["reviewer_user_id"],

    assignedEmployeeName: json["assigned_employee_name"],
    civilIdCardNumber: json["civil_id_card_number"],
    employeeId: json["employee_id"],
    currentJobPosition: json["current_job_position"],
    assignedJobPosition: json["assigned_job_position"],

    startDate: json["start_date"],
    endDate: json["end_date"],
    assignmentAllowance: json["assignment_allowance"]?.toString(),
    reasonForRequest: parseStringList(json['reason_for_request']),
    isReplaced: json["is_replaced"],
    replacementEmployeeName: json["replacement_employee_name"],
    replacementEmployeeId: json["replacement_employee_id"],
    replacementCivilIdCardNumber: json["replacement_civil_id_card_number"],
    replacementReason: json["replacement_reason"],
    replacedByUserId: json["replaced_by_user_id"],
    replacedAt: json["replaced_at"],
    reqUserPositionId: json["req_user_position_id"],

    originalDepartmentId: json["original_department_id"],
    assignedDepartmentId: json["assigned_department_id"],

    fromEntity: json["from_entity"],
    toEntity: json["to_entity"],

    assignedToRole: json["assigned_to_role"],
    currentEntity: json['current_entity'],
    transferredToEntity: json['transferred_to_entity'],

    salaryDetails: json['salary_details'],
    salaryDetailsDescription: json['salary_details_description'],
    // ───────── TASK MANAGEMENT ─────────
    taskTitle: json["task_title"],
    taskDescription: json["task_description"] ?? json["description"],
    completionDate: json["completion_date"],
    employeesDetails: json['employees_details'] != null
        ? (json['employees_details'] as List)
              .map((e) => EmployeeDutyMission.fromJson(e))
              .toList()
        : null,

    airTicketDetails: json['air_ticket_details'] != null
        ? (json['air_ticket_details'] as List)
              .map((e) => AirTicketDetail.fromJson(e))
              .toList()
        : null,
    tripType: json['trip_type'],
    chooseType: json['choose_type'],

    missionSponsoredBy: json['mission_sponsored_by'],
    missionPurpose: json['mission_purpose'],
    missionNumber: json['mission_number'],
    missionId: json['mission_id'],

    missionStartDate: json['mission_start_date'],
    missionEndDate: json['mission_end_date'],

    travellingAreaFrom: json['travelling_area_from'],
    travellingAreaTo: json['travelling_area_to'],

    fromCountry: json['from_country'],
    toCountry: json['to_country'],
    travelPlace: json['travel_place'],

    travelStartDate: json['travel_start_date'],
    travelReturnDate: json['travel_return_date'],

    missionDays: json['mission_days'],
    distance: json['distance'],

    ifSponsored: json['if_sponsored'],
    allowancePercentage: json['allowance_percentage'],
    airTicketRequired: json['air_ticket_required'],
    vehicleRequired: json['vehicle_required'],
    remarks: json['remarks'],
    // ───── MEDIA COVERAGE ─────
    eventLocation: json['event_location'],
    eventDetails: json['event_details'],
    importanceOfPublishing: json['importance_of_publishing'],
    directorateName: json['directorate_name'],
    requiredForPresident: json['required_for_president'],
    departmentId: json['department_id'],
    suggestedPhotography: json['suggested_photography'],
    newsSize: json['news_size'],
    eventObjective: json['event_objective'],
    organizingEntity: json['organizing_entity'],
    hostedPerson: json['hosted_person'],
    audience: json['audience'],
    rejectionReason: json['rejection_reason'],
    documentType: json['document_event'],
    purposeOfTraining: json['purpose_of_training'],
    dateOfEvent: json['date_of_event'],
    startTime: json['start_time'],
    endTime: json['end_time'],
    roomType: json['room_type'],
    numberOfAttendees: json['number_of_attendees'],
    networkSupportRequired: json['network_support_required'],
    mealsRequired: json['meals_required'],
    courseName: json['course_name'],
    noOfParticipants: json['no_of_participants'],
    courseCost: json['course_cost'],
    totalCost: json['total_cost'],
    reason: json['reason'],
    location: json['location'],
    employeeList: json['employee_list'],
    proposedImplementationDate: json['proposed_implementation_date'],
    typeOfTraining: json['type_of_training'],
    typeOfCategory: json['type_of_category'],
    noOfAttendees: json['no_of_attendees'],
    durationOfCourse: json['duration_of_course'],
    instituteName: json['institute_name'],
    courseStartDate: json['course_start_date'],
    courseEndDate: json['course_end_date'],

    positionToBeTransferred: json['position_to_be_transferred'],
    effectiveFromDate: json['effective_from_date'],
    decisionNumber: json['decision_number'],
    employeeName: json['employee_name'],
    jobTitle: json['job_title'],
    financialGrade: json['financial_grade'],

    shiftStartDate: json['shift_start_date'] != null
        ? DateTime.tryParse(json['shift_start_date'])
        : null,
    shiftEndDate: json['shift_end_date'] != null
        ? DateTime.tryParse(json['shift_end_date'])
        : null,
    salaryGrade: json['salary_grade'],

    remainingLeaveBalance: json['remaining_leave_balance'],
    basicSalary: json['basic_salary'],
    totalSalaryDue: json['total_salary_due'],

    endOfServiceDate: json['end_of_service_date'] != null
        ? DateTime.tryParse(json['end_of_service_date'])
        : null,

    reasonForTermination: json['reason_for_termination'],

    salaryPaymentSource: json['salary_payment_source'],
    socialServiceFundContribution: json['social_service_fund_contribution'],
    positionToBeFilled: json['position_to_be_filled'] as String?,
    grade: json['grade'] as String?,
    roleTitle: json['role_title'] as String?,
    educationRequirements: json['education_requirements'] as String?,
    requiredSkills: json['required_skills'] as String?,
    yearsOfExperience: json['years_of_experience'] as String?,
    jobDescription: json['job_description'] as String?,
    currentBasicSalary: json['current_basic_salary'] as String?,
    currentJobTitle: json['current_job_title'] as String?,
    currentSalaryGrade: json['current_salary_grade'] as String?,

    proposedBasicSalary: json['proposed_basic_salary'] as String?,
    proposedJobTitle: json['proposed_job_title'] as String?,
    proposedSalaryGrade: json['proposed_salary_grade'] as String?,
    certificationTitle: json['certification_title'] as String?,
    skillCategory: json['skill_category'] as String?,
    issuingAuthority: json['issuing_authority'] as String?,
    skillSummary: json['skill_summary'] as String?,
    additionalInfoRequested: json['additional_info_requested'] as String?,
    cyclePeriod: json['cycle_period'] as String?,
    cycleYear: json['cycle_year'] as int?,
    extensionNumber: json['extension_number'] as String?,
    quater: json['quater'] as String?,
    year: json['year'] as int?,
    tasks: (json['tasks'] as List?)
        ?.map((e) => TaskModel.fromJson(e as Map<String, dynamic>?))
        .toList(),
    durationOfDays: json['duration_of_days'] as int?,
    travellingFromRegion: json['travelling_from_region'] as String?,
    travelFrom: json['travel_from'] as String?,
    travelTo: json['travel_to'] as String?,
    timeOfArrival: json['time_of_arrival'] as String?,
    startDateOfStay: json['start_date_of_stay'] as String?,
    referenceNumber: json['reference_number'] as String?,
    otherPurposeSpecification: json['other_purpose_specification'] as String?,
    officialPurposeOfTravel: json['official_purpose_of_travel'] as String?,
    numberOfEmployeesTravelling: json['number_of_employees_travelling'] as int?,
    employeeDetails: (json['employee_details'] as List?)
        ?.map(
          (e) =>
              AccommodationEmployeeDetails.fromJson(e as Map<String, dynamic>?),
        )
        .toList(),
    unitType: json['requested_unit_type'] as String?,
    locationOfStay: json['location_of_unit'] as String?,
    familySize: json['family_size'] as int?,
    durationOfStay: json['duration_of_stay'] as String?,
    reasonForRenewal: json['reason_for_renewal'] as String?,
    requestedRenewalDuration: json['requested_renewal_duration'] as String?,
    approverComment: json['approver_comment'],
    handoverDate: json['handover_date'],
    pendingBillsClearanceStatus: json['pending_bills_clearance_status'],
    reasonForCancellation: json['reason_for_cancellation'],
    requestedCancellationDate: json['requested_cancellation_date'],
    currentContractEndDate: json['current_contract_end_date'],
    currentContractStartDate: json['current_contract_start_date'],
    currentUnitType: json['current_unit_type'] as String?,
    eventTitle: json['event_title'],
    locationOfEvent: json['location_of_event'],
    typeOfEvent: json['type_of_event'],
    eventDepartmentId: json['event_department_id'],
  );

  Map<String, dynamic> toJson() => {
    "workflow_details": workflowDetails == null
        ? []
        : List<dynamic>.from(workflowDetails!.map((x) => x.toJson())),
    "approval_details": approvalDetails == null
        ? []
        : List<dynamic>.from(approvalDetails!.map((x) => x.toJson())),
    "chat_messages": chatMessages == null
        ? []
        : List<dynamic>.from(chatMessages!.map((x) => x.toJson())),
    "attachments": attachments == null
        ? []
        : List<dynamic>.from(attachments!.map((x) => x.toJson())),
  };
}

class RequestModel {
  // ─────────────────────────────
  // COMMON FIELDS
  // ─────────────────────────────
  final int? id;
  final int? serviceId;
  final int? subServiceId;

  final String? description;
  final String? status;
  final String? priority; // NEW
  final int? typeOfThreat; // NEW

  final String? workflowExecutionId;
  final int? createdBy;
  final String? createdAt;
  final int? updatedBy;
  final String? updatedAt;
  final int? userId;

  final int? reqUserDepartmentId;
  final int? reqUserSectionId;

  // ─────────────────────────────
  // CONTACT INFO (Salalah)
  // ─────────────────────────────
  final String? contactNum; // contact_number / contact_num
  final String? extnNum; // extension_number
  final String? email;
  final String? personName;
  final String? personContactNumber;
  final String? requestFor;
  final String? problem;
  final String? requestDate;
  final int? serviceTypeId;
  final String? requestType;
  final String? workflowInstanceId;

  // ─────────────────────────────
  // LOGISTICS FIELDS
  // ─────────────────────────────
  final String? category;
  final String? vehicleRequiredFor;
  final String? vehicleRequiredLocation;
  final String? title;
  final String? purposeOfTravel;
  final String? typeOfVehicleRequired;
  final String? typeOfRequest;
  final String? dateOfTravel;
  final String? timeOfTravel;
  final int? expDurationOfUseHrs;
  final int? expDurationOfUseDays;
  final String? vehicleNumber;
  final String? fuelCard;
  final String? expectedVehicleReturnTime;
  final String? expectedReturnDate;
  final String? actualVehicleReturnTime;
  final String? actualReturnDate;
  final String? vehicleCondition;
  final String? reason;
  final String? driverName;
  final String? travelDateFrom;
  final String? travelDateTo;
  final int? duration;
  final String? locationOfEvent;

  // ─────────────────────────────
  // ACCOMMODATION FIELDS
  // ─────────────────────────────
  final String? hotelName;
  final String? typeOfAccommodation;
  final int? numberOfGuests;
  final List<String>? meal;
  final String? price;
  final String? requestedBy;
  final bool? hrApproval;
  final bool? prApproval;
  final String? checkInDate;
  final String? checkInTime;
  final String? checkOutDate;
  final String? checkOutTime;
  final String? dateOfRequest;
  final String? visitorName;

  // ─────────────────────────────
  // SECURITY AWARENESS FIELDS
  // ─────────────────────────────
  final String? dateOfSubmission;
  final String? phoneNumber;
  final String? place;
  final String? eventDate;
  final String? eventTime;
  final String? mediaCoverageRequired;

  // ─────────────────────────────
  // AIRPORT ENTRY / PERMIT FIELDS
  // ─────────────────────────────

  // ─────────────────────────────
  // CONSENTS / FLAGS
  // ─────────────────────────────
  final bool? acknowledgeSecurityPolicies;
  final bool? acknowledgeDisciplinaryAction;
  final bool? consentApproveToIssuePermit;
  final bool? consentDoNotApproveToIssuePermit;
  final String? consentJustification;

  // ─────────────────────────────
  // META
  // ─────────────────────────────
  final String? requestId;
  final String? expirationDate;
  final String? attachmentUrl;

  // ─────────────────────────────
  // NESTED OBJECTS
  // ─────────────────────────────
  final UserModel? createdByUser;
  final ServiceTypeModel? serviceType;
  final ServiceModel? service;
  final SubServiceModel? subService;
  final DepartmentModel? reqDepartment;
  final SectionModel? reqSection;

  // ─────────────────────────────
  // ASSIGNMENT DECISION FIELDS
  // ─────────────────────────────
  final bool? isDeleted;

  final int? assignedToUserId;
  final String? assignedAt;
  final int? reviewerUserId;

  final String? assignedEmployeeName;
  final String? civilIdCardNumber;
  final String? employeeId;
  final String? currentJobPosition;
  final String? assignedJobPosition;

  final String? startDate;
  final String? endDate;
  final String? assignmentAllowance;
  final List<String>? reasonForRequest;

  // Replacement
  final bool? isReplaced;
  final String? replacementEmployeeName;
  final String? replacementEmployeeId;
  final String? replacementCivilIdCardNumber;
  final String? replacementReason;
  final int? replacedByUserId;
  final String? replacedAt;
  final int? reqUserPositionId;
  final int? originalDepartmentId;
  final int? assignedDepartmentId;
  final String? fromEntity;
  final String? toEntity;
  final dynamic assignedToRole;

  /// ─────────────────────────────
  /// TASK MANAGEMENT FIELDS (NEW)
  /// ─────────────────────────────
  final String? taskTitle;
  final String? taskDescription;
  final String? completionDate;

  // ─────────────────────────────
  // DUTY MISSION FIELDS (NEW)
  // ─────────────────────────────
  final String? tripType;
  final String? chooseType;

  final String? missionSponsoredBy;
  final String? missionPurpose;
  final String? missionNumber;
  final String? missionId;

  final String? missionStartDate;
  final String? missionEndDate;

  final String? travellingAreaFrom;
  final String? travellingAreaTo;

  final String? fromCountry;
  final String? toCountry;
  final String? travelPlace;

  final String? travelStartDate;
  final String? travelReturnDate;

  final int? missionDays;
  final String? distance;

  final String? ifSponsored;
  final String? allowancePercentage;
  final String? airTicketRequired;
  final String? vehicleRequired;
  final String? remarks;

  // ─────────────────────────────
  // DUTY MISSION NESTED LISTS
  // ─────────────────────────────
  final List<EmployeeDutyMission>? employeesDetails;
  final List<AirTicketDetail>? airTicketDetails;

  // ─────────────────────────────
  // REQUEST FOR COVERAGE (MEDIA) FIELDS
  // ─────────────────────────────
  final String? eventLocation;
  final String? eventDetails;
  final String? importanceOfPublishing;
  final String? directorateName;
  final bool? requiredForPresident;
  final int? departmentId; // Media / Communication department
  final String? suggestedPhotography;
  final String? newsSize;
  final String? eventObjective;
  final String? organizingEntity;
  final String? hostedPerson;
  final String? audience;
  final String? rejectionReason;
  final String? documentType;

  // ─────────────────────────────
  // TRAINING ROOM BOOKING FIELDS
  // ─────────────────────────────
  final String? purposeOfTraining;
  final String? dateOfEvent;
  final String? startTime;
  final String? endTime;
  final String? roomType;
  final int? numberOfAttendees;
  final bool? networkSupportRequired;
  final bool? mealsRequired;

  /// ─────────────────────────────
  /// TRAINING DETAILS (MISSING FIELDS ADDED)
  /// ─────────────────────────────
  final String? courseName;
  final int? noOfParticipants;
  final String? courseCost;
  final String? totalCost;
  final String? location;
  final List<dynamic>? employeeList;
  final String? proposedImplementationDate;

  /// ─────────────────────────────
  /// TRAINING REQUEST (CAA015) FIELDS
  /// ─────────────────────────────
  final String? typeOfTraining;
  final String? typeOfCategory;

  final int? noOfAttendees;

  final String? durationOfCourse;
  final String? instituteName;
  final String? courseStartDate;
  final String? courseEndDate;

  /// Transfer specific fields only
  final String? positionToBeTransferred;
  final String? effectiveFromDate;
  final String? decisionNumber;

  /// Employee info
  final String? employeeName;
  final String? jobTitle;
  final String? financialGrade;

  /// Shift details
  final DateTime? shiftStartDate;
  final DateTime? shiftEndDate;

  /// Employee Info
  ///
  final String? salaryGrade;

  /// Leave Calculation Fields
  final String? remainingLeaveBalance;
  final String? basicSalary;
  final String? totalSalaryDue;
  final DateTime? endOfServiceDate;
  final String? reasonForTermination;
  final String? positionToBeFilled;
  final String? grade;
  final String? roleTitle;
  final String? educationRequirements;
  final String? requiredSkills;
  final String? yearsOfExperience;
  final String? jobDescription;

  /// Current Details
  final String? currentBasicSalary;
  final String? currentJobTitle;
  final String? currentSalaryGrade;

  /// Proposed Details
  final String? proposedBasicSalary;
  final String? proposedJobTitle;
  final String? proposedSalaryGrade;

  final String? certificationTitle;
  final String? skillCategory;
  final String? issuingAuthority;
  final String? skillSummary;
  final String? additionalInfoRequested;

  /// Performance Management Fields
  final String? cyclePeriod;
  final int? cycleYear;
  final String? extensionNumber;
  final String? quater;
  final int? year;
  final List<TaskModel>? tasks;

  /// Accommodation in Muscat specific fields
  ///
  ///
  final String? nameFullFamilyName;
  final String? nationality;
  final String? dob;
  final String? passportIdCardNo;
  final String? categoryOfPermit;
  final String? typeOfPermit;
  final List<PermissionToRequiredAreas>? permissionToRequiredAreas;
  final String? details;
  final String? occupationStaff;
  final String? temporaryStartTime;
  final String? temporaryDuration;
  final dynamic forVisitor;
  final List<String>? additionalServices;
  final dynamic deviceSerialNumber;
  final dynamic newPermitIssuanceFile;
  final dynamic formsAttachmentFile;
  final dynamic permitRenewalFile;

  ///   final int? durationOfDays;
  final String? travellingFromRegion;
  final String? travelFrom;
  final String? travelTo;
  final String? timeOfArrival;
  final String? startDateOfStay;
  final String? referenceNumber;
  final String? otherPurposeSpecification;
  final String? officialPurposeOfTravel;
  final int? numberOfEmployeesTravelling;
  final List<AccommodationEmployeeDetails>? employeeDetails;
  final String? durationOfStay;
  final String? locationOfStay;
  final String? reasonForRenewal;
  final String? requestedRenewalDuration;
  final String? approverComment;
  final String? handoverDate;
  final String? pendingBillsClearanceStatus;
  final String? reasonForCancellation;
  final String? requestedCancellationDate;
  final String? currentContractEndDate;
  final String? currentContractStartDate;
  final String? phone;
  final String? titleOfProject;
  final String? applicationUrl;
  final String? ipAddress;
  final String? link;
  final String? submissionDate;
  final String? applicationName;
  final String? requestClassification;
  final String? applicationToBeAudited;
  final String? applicationToBeAuditedOther;

  final bool? acknowledgement;
  final String? hosOrDepartmentName;
  final String? requestTitle;
  final String? titleOfComplaint;
  final String? appealAgainstDecision;
  final String? decisionDate;
  final String? decisionSubject;
  final String? grievanceDetails;
  final String? individualsInvolved;
  final List<String>? times;
  final String? dates;
  final String? requests;
  final String? events;
  final String? grievantName;
  final String? grievantEmployeeNumber;
  final int? grievantDirectorateId;
  final int? grievantDepartmentId;
  final int? grievantSectionId;
  final String? grievantRelationshipToMatter;
  final bool? declarationAcknowledged;

  // Tender Service
  final String? titleOfEnquiry;
  final String? tenderDateOfSubmission;
  final String? tenderPhone;
  final String? budgetCode;
  final String? estimatedCost;
  final String? implementationPeriod;
  final String? requestingEntity;
  final String? projectCodeBudgetCode;
  final String? companyName;
  final String? eventTitle;

  // vehicle Maintenance
  final String? typeOfMaintenanceRequired;
  final String? issueDescription;
  final String? preferredMaintenanceDate;
  final String? requestSubmissionDate;

  //  Request for Study Leave
  final bool? alreadySubmittedInMinistryOfEducationSystem;

  final String? areaName;
  final String? countryName;

  final String? qualificationRequired;

  final bool? haveYouEverReceivedAuthority;
  final String? scholarship;

  ///Security Threat

  final String? contactNumber;

  final String? ticketName;

  final String? sourceOfIncident;

  final List<String>? typeOfIncidentDetected;

  final List<String>? incidentNotificationInCaa;

  final String? identificationMeasures;

  final String? evidenceCollected;

  final String? eradicationMitigationMeasures;

  final String? recoveryMeasures;

  final String? otherMitigationMeasures;

  // foreign employee
  final int? numberOfPassengers;

  final String? employeeIdPassport;
  final String? originCity;
  final String? destinationCity;

  final String? arrivalDepartureDatetime;

  final String? specialInstructions;
  // ─────────────────────────────
  // CONSTRUCTOR
  // ─────────────────────────────

  RequestModel({
    this.id,
    this.serviceId,
    this.subServiceId,
    this.description,
    this.status,
    this.priority,
    this.typeOfThreat,
    this.workflowExecutionId,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.userId,
    this.reqUserDepartmentId,
    this.reqUserSectionId,
    this.workflowInstanceId,
    this.contactNum,
    this.extnNum,
    this.email,
    this.personName,
    this.personContactNumber,
    this.requestFor,
    this.problem,
    this.requestDate,
    this.serviceTypeId,
    this.requestType,

    this.category,
    this.vehicleRequiredFor,
    this.vehicleRequiredLocation,
    this.title,
    this.locationOfEvent,
    this.purposeOfTravel,
    this.typeOfVehicleRequired,
    this.eventTitle,
    this.typeOfRequest,
    this.dateOfTravel,
    this.timeOfTravel,
    this.expDurationOfUseHrs,
    this.expDurationOfUseDays,
    this.vehicleNumber,
    this.fuelCard,
    this.expectedVehicleReturnTime,
    this.expectedReturnDate,
    this.actualVehicleReturnTime,
    this.actualReturnDate,
    this.vehicleCondition,
    this.driverName,

    this.hotelName,
    this.typeOfAccommodation,
    this.numberOfGuests,
    this.meal,
    this.price,
    this.requestedBy,
    this.hrApproval,
    this.prApproval,
    this.checkInDate,
    this.checkInTime,
    this.checkOutDate,
    this.checkOutTime,
    this.dateOfRequest,
    this.visitorName,

    this.createdByUser,
    this.serviceType,
    this.service,
    this.subService,
    this.reqDepartment,
    this.reqSection,

    this.dateOfSubmission,
    this.phoneNumber,
    this.place,
    this.eventDate,
    this.eventTime,
    this.mediaCoverageRequired,

    this.acknowledgeSecurityPolicies,
    this.acknowledgeDisciplinaryAction,
    this.consentApproveToIssuePermit,
    this.consentDoNotApproveToIssuePermit,
    this.consentJustification,
    this.requestId,
    this.expirationDate,
    this.attachmentUrl,

    this.isDeleted,

    this.assignedToUserId,
    this.assignedAt,
    this.reviewerUserId,

    this.assignedEmployeeName,
    this.civilIdCardNumber,
    this.employeeId,
    this.currentJobPosition,
    this.assignedJobPosition,

    this.nameFullFamilyName,
    this.nationality,
    this.dob,
    this.passportIdCardNo,
    this.categoryOfPermit,
    this.location,
    this.typeOfPermit,
    this.permissionToRequiredAreas,
    this.details,
    this.occupationStaff,
    this.temporaryStartTime,
    this.temporaryDuration,
    this.forVisitor,
    this.additionalServices,
    this.endDate,
    this.deviceSerialNumber,
    this.newPermitIssuanceFile,
    this.formsAttachmentFile,
    this.permitRenewalFile,

    this.startDate,
    this.assignmentAllowance,
    this.reasonForRequest,

    this.isReplaced,
    this.replacementEmployeeName,
    this.replacementEmployeeId,
    this.replacementCivilIdCardNumber,
    this.replacementReason,
    this.replacedByUserId,
    this.replacedAt,
    this.reqUserPositionId,
    this.originalDepartmentId,
    this.assignedDepartmentId,
    this.fromEntity,
    this.toEntity,
    this.assignedToRole,

    this.taskTitle,
    this.taskDescription,
    this.completionDate,

    this.tripType,
    this.chooseType,
    this.missionSponsoredBy,
    this.missionPurpose,
    this.missionNumber,
    this.missionId,
    this.missionStartDate,
    this.missionEndDate,
    this.travellingAreaFrom,
    this.travellingAreaTo,
    this.fromCountry,
    this.toCountry,
    this.travelPlace,
    this.travelStartDate,
    this.travelReturnDate,
    this.missionDays,
    this.distance,
    this.ifSponsored,
    this.allowancePercentage,
    this.airTicketRequired,
    this.vehicleRequired,
    this.remarks,
    this.employeesDetails,
    this.airTicketDetails,

    this.eventLocation,
    this.eventDetails,
    this.importanceOfPublishing,
    this.directorateName,
    this.requiredForPresident,
    this.departmentId,
    this.suggestedPhotography,
    this.newsSize,
    this.eventObjective,
    this.organizingEntity,
    this.hostedPerson,
    this.audience,
    this.rejectionReason,
    this.documentType,
    this.purposeOfTraining,
    this.dateOfEvent,
    this.startTime,
    this.endTime,
    this.roomType,
    this.numberOfAttendees,
    this.networkSupportRequired,
    this.mealsRequired,
    this.courseName,
    this.noOfParticipants,
    this.courseCost,
    this.totalCost,
    this.reason,
    this.employeeList,
    this.proposedImplementationDate,
    this.typeOfTraining,
    this.typeOfCategory,
    this.noOfAttendees,

    this.durationOfCourse,
    this.instituteName,
    this.courseStartDate,
    this.courseEndDate,

    this.positionToBeTransferred,
    this.effectiveFromDate,
    this.decisionNumber,
    this.employeeName,
    this.jobTitle,
    this.financialGrade,
    this.shiftStartDate,
    this.shiftEndDate,
    this.salaryGrade,
    this.remainingLeaveBalance,
    this.basicSalary,
    this.totalSalaryDue,
    this.endOfServiceDate,
    this.reasonForTermination,
    this.positionToBeFilled,
    this.grade,
    this.roleTitle,
    this.educationRequirements,
    this.requiredSkills,
    this.yearsOfExperience,
    this.jobDescription,
    this.currentBasicSalary,
    this.currentJobTitle,
    this.currentSalaryGrade,
    this.proposedBasicSalary,
    this.proposedJobTitle,
    this.proposedSalaryGrade,
    this.certificationTitle,
    this.skillCategory,
    this.issuingAuthority,
    this.skillSummary,
    this.additionalInfoRequested,
    this.cyclePeriod,
    this.cycleYear,
    this.extensionNumber,
    this.quater,
    this.year,
    this.tasks,
    this.travellingFromRegion,
    this.travelFrom,
    this.travelTo,
    this.timeOfArrival,
    this.startDateOfStay,
    this.referenceNumber,
    this.otherPurposeSpecification,
    this.officialPurposeOfTravel,
    this.numberOfEmployeesTravelling,
    this.employeeDetails,
    this.durationOfStay,
    this.locationOfStay,
    this.reasonForRenewal,
    this.requestedRenewalDuration,
    this.approverComment,
    this.handoverDate,
    this.pendingBillsClearanceStatus,
    this.reasonForCancellation,
    this.requestedCancellationDate,
    this.currentContractEndDate,
    this.currentContractStartDate,
    this.phone,
    this.titleOfProject,
    this.applicationUrl,
    this.ipAddress,
    this.link,
    this.submissionDate,
    this.applicationName,
    this.requestClassification,
    this.applicationToBeAudited,
    this.applicationToBeAuditedOther,
    this.acknowledgement,
    this.hosOrDepartmentName,
    this.requestTitle,
    this.titleOfComplaint,
    this.appealAgainstDecision,

    this.decisionDate,
    this.decisionSubject,
    this.grievanceDetails,
    this.individualsInvolved,
    this.times,
    this.dates,
    this.requests,
    this.events,
    this.grievantName,
    this.grievantEmployeeNumber,
    this.grievantDirectorateId,
    this.grievantDepartmentId,
    this.grievantSectionId,
    this.grievantRelationshipToMatter,
    this.declarationAcknowledged,
    // Tender Service
    this.titleOfEnquiry,
    this.tenderDateOfSubmission,
    this.tenderPhone,
    this.budgetCode,
    this.estimatedCost,
    this.implementationPeriod,
    this.requestingEntity,
    this.projectCodeBudgetCode,
    this.companyName,
    // Vehicle Maintenance
    this.typeOfMaintenanceRequired,
    this.issueDescription,
    this.preferredMaintenanceDate,
    this.requestSubmissionDate,
    // Request for Study Leave
    this.alreadySubmittedInMinistryOfEducationSystem,
    this.areaName,
    this.countryName,
    this.qualificationRequired,
    this.haveYouEverReceivedAuthority,
    this.scholarship,
    this.travelDateFrom,
    this.travelDateTo,
    this.duration,
    this.contactNumber,

    this.ticketName,

    this.sourceOfIncident,

    this.typeOfIncidentDetected,

    this.incidentNotificationInCaa,

    this.identificationMeasures,

    this.evidenceCollected,

    this.eradicationMitigationMeasures,

    this.recoveryMeasures,

    this.otherMitigationMeasures,
    this.numberOfPassengers,
    this.employeeIdPassport,
    this.originCity,
    this.destinationCity,
    this.arrivalDepartureDatetime,
    this.specialInstructions,
  });

  static List<String> parseStringList(dynamic data) {
    try {
      if (data == null) return [];

      /// Already List
      if (data is List) {
        return data.map((e) => e.toString()).toList();
      }

      /// Single String
      if (data is String) {
        return [data];
      }

      return [];
    } catch (e) {
      print("❌ parseStringList Error: $e");
      print("❌ Value: $data");
      return [];
    }
  }

  // ─────────────────────────────
  // FROM JSON (supports BOTH KEY versions)
  // ─────────────────────────────

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      id: json["id"],
      serviceId: json["service_id"],
      subServiceId: json["sub_service_id"],

      description: json["description"],
      status: json["status"],
      priority: json["priority"] ?? json["request_priority"],
      typeOfThreat: json["type_of_threat"] ?? json["typeOfThreat"],

      workflowExecutionId: json["workflow_execution_id"],
      createdBy: json["created_by"],
      createdAt: json["created_at"],
      updatedBy: json["updated_by"],
      updatedAt: json["updated_at"],
      userId: json["user_id"],

      reqUserDepartmentId: json["req_user_department_id"],
      reqUserSectionId: json["req_user_section_id"],

      contactNum: json["contact_number"] ?? json["contact_num"],
      extnNum: json["extension_number"] ?? json["extn_num"],
      email: json["email"],
      personName: json["person_name"],
      personContactNumber: json["person_contact_number"],
      requestFor: json["request_for"],
      problem: json["problem"],
      requestDate: json["request_date"],
      serviceTypeId: json["service_type_id"],
      requestType: json["request_type"],

      category: json["category"],
      vehicleRequiredFor: json["vehicle_required_for"],
      vehicleRequiredLocation: json["vehicle_required_location"],
      title: json["title"],
      purposeOfTravel: json["purpose_of_travel"],
      typeOfVehicleRequired: json["type_of_vehicle_required"],
      typeOfRequest: json["type_of_request"],
      dateOfTravel: json["date_of_travel"],
      timeOfTravel: json["time_of_travel"],
      expDurationOfUseHrs: json["exp_duration_of_use_hrs"],
      expDurationOfUseDays: json["exp_duration_of_use_days"],

      hotelName: json["hotel_name"],
      typeOfAccommodation: json["type_of_accommodation"],
      numberOfGuests: json["number_of_guests"],
      meal: json["meal"] != null ? List<String>.from(json["meal"]) : null,
      price: json["price"],
      requestedBy: json["requested_by"],
      hrApproval: json["hr_approval"],
      prApproval: json["pr_approval"],
      checkInDate: json["check_in_date"],
      checkInTime: json["check_in_time"],
      checkOutDate: json["check_out_date"],
      checkOutTime: json["check_out_time"],
      dateOfRequest: json["date_of_request"],
      visitorName: json["visitor_name"],

      createdByUser: json["created_by_user"] != null
          ? UserModel.fromJson(json["created_by_user"])
          : null,

      serviceType: json["service_type"] != null
          ? ServiceTypeModel.fromJson(json["service_type"])
          : null,

      service: json["service"] != null
          ? ServiceModel.fromJson(json["service"])
          : null,

      subService: json["sub_service"] != null
          ? SubServiceModel.fromJson(json["sub_service"])
          : null,

      reqDepartment: json["req_department"] != null
          ? DepartmentModel.fromJson(json["req_department"])
          : null,

      reqSection: json["req_section"] != null
          ? SectionModel.fromJson(json["req_section"])
          : null,

      dateOfSubmission: json["date_of_submission"],
      phoneNumber: json["phone_number"],
      place: json["place"],
      eventDate: json["event_date"],
      eventTime: json["event_time"],
      mediaCoverageRequired: json["media_coverage_required"],

      acknowledgeSecurityPolicies: json["acknowledge_security_policies"],
      acknowledgeDisciplinaryAction: json["acknowledge_disciplinary_action"],
      consentApproveToIssuePermit: json["consent_approve_to_issue_permit"],
      consentDoNotApproveToIssuePermit:
          json["consent_do_not_approve_to_issue_permit"],
      consentJustification: json["consent_justification"],
      eventTitle: json["event_title"],

      requestId: json["request_id"],
      expirationDate: json["expiration_date"],
      attachmentUrl: json["attachment_url"],
      isDeleted: json["is_deleted"],

      assignedToUserId: json["assigned_to_user_id"],
      assignedAt: json["assigned_at"],
      reviewerUserId: json["reviewer_user_id"],

      assignedEmployeeName: json["assigned_employee_name"],
      civilIdCardNumber: json["civil_id_card_number"],
      employeeId: json["employee_id"],
      currentJobPosition: json["current_job_position"],
      assignedJobPosition: json["assigned_job_position"],
      workflowInstanceId: json["workflow_execution_id"],
      locationOfEvent: json['location_of_event'],

      startDate: json["start_date"],
      endDate: json["end_date"],
      assignmentAllowance: json["assignment_allowance"]?.toString(),
      reasonForRequest: parseStringList(json['reason_for_request']),
      isReplaced: json["is_replaced"],
      replacementEmployeeName: json["replacement_employee_name"],
      replacementEmployeeId: json["replacement_employee_id"],
      replacementCivilIdCardNumber: json["replacement_civil_id_card_number"],
      replacementReason: json["replacement_reason"],
      replacedByUserId: json["replaced_by_user_id"],
      replacedAt: json["replaced_at"],
      reqUserPositionId: json["req_user_position_id"],

      originalDepartmentId: json["original_department_id"],
      assignedDepartmentId: json["assigned_department_id"],

      fromEntity: json["from_entity"],
      toEntity: json["to_entity"],

      assignedToRole: json["assigned_to_role"],

      // airport entry / permit fields will be added here when needed
      nameFullFamilyName: json['name_full_family_name'] as String?,
      nationality: json['nationality'] as String?,
      dob: json['dob'] as String?,
      passportIdCardNo: json['passport_id_card_no'] as String?,
      categoryOfPermit: json['category_of_permit'] as String?,
      location: json['location'] as String?,
      typeOfPermit: json['type_of_permit'] as String?,
      permissionToRequiredAreas: json['permission_to_required_areas'] != null
          ? (json['permission_to_required_areas'] as List)
                .map((e) => PermissionToRequiredAreas.fromJson(e))
                .toList()
          : [],
      details: json['details'] as String?,
      occupationStaff: json['occupation_staff'] as String?,

      temporaryStartTime: json['temporary_start_time'] as String?,
      temporaryDuration: json['temporary_duration'] as String?,
      forVisitor: json['for_visitor'],
      additionalServices: json['additional_services'] != null
          ? List<String>.from(json['additional_services'])
          : [],
      deviceSerialNumber: json['device_serial_number'],
      newPermitIssuanceFile: json['new_permit_issuance_file'],
      formsAttachmentFile: json['forms_attachment_file'],
      permitRenewalFile: json['permit_renewal_file'],

      // ───────── TASK MANAGEMENT ─────────
      taskTitle: json["task_title"],
      taskDescription: json["task_description"] ?? json["description"],
      completionDate: json["completion_date"],
      employeesDetails: json['employees_details'] != null
          ? (json['employees_details'] as List)
                .map((e) => EmployeeDutyMission.fromJson(e))
                .toList()
          : null,

      airTicketDetails: json['air_ticket_details'] != null
          ? (json['air_ticket_details'] as List)
                .map((e) => AirTicketDetail.fromJson(e))
                .toList()
          : null,
      tripType: json['trip_type'],
      chooseType: json['choose_type'],

      missionSponsoredBy: json['mission_sponsored_by'],
      missionPurpose: json['mission_purpose'],
      missionNumber: json['mission_number'],
      missionId: json['mission_id'],

      missionStartDate: json['mission_start_date'],
      missionEndDate: json['mission_end_date'],

      travellingAreaFrom: json['travelling_area_from'],
      travellingAreaTo: json['travelling_area_to'],

      fromCountry: json['from_country'],
      toCountry: json['to_country'],
      travelPlace: json['travel_place'],

      travelStartDate: json['travel_start_date'],
      travelReturnDate: json['travel_return_date'],

      missionDays: json['mission_days'],
      distance: json['distance'],

      ifSponsored: json['if_sponsored'],
      allowancePercentage: json['allowance_percentage'],
      airTicketRequired: json['air_ticket_required'],
      vehicleRequired: json['vehicle_required'],
      remarks: json['remarks'],
      // ───── MEDIA COVERAGE ─────
      eventLocation: json['event_location'],
      eventDetails: json['event_details'],
      importanceOfPublishing: json['importance_of_publishing'],
      directorateName: json['directorate_name'],
      requiredForPresident: json['required_for_president'],
      departmentId: json['department_id'],
      suggestedPhotography: json['suggested_photography'],
      newsSize: json['news_size'],
      eventObjective: json['event_objective'],
      organizingEntity: json['organizing_entity'],
      hostedPerson: json['hosted_person'],
      audience: json['audience'],
      rejectionReason: json['rejection_reason'],
      documentType: json['document_event'],
      purposeOfTraining: json['purpose_of_training'],
      dateOfEvent: json['date_of_event'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      roomType: json['room_type'],
      numberOfAttendees: json['number_of_attendees'],
      networkSupportRequired: json['network_support_required'],
      mealsRequired: json['meals_required'],
      courseName: json['course_name'],
      noOfParticipants: json['no_of_participants'],
      courseCost: json['course_cost'],
      totalCost: json['total_cost'],
      reason: json['reason'],
      employeeList: json['employee_list'],
      proposedImplementationDate: json['proposed_implementation_date'],
      typeOfTraining: json['type_of_training'],
      typeOfCategory: json['type_of_category'],
      noOfAttendees: json['no_of_attendees'],
      durationOfCourse: json['duration_of_course'],
      instituteName: json['institute_name'],
      courseStartDate: json['course_start_date'],
      courseEndDate: json['course_end_date'],
      vehicleNumber: json['vehicle_number'],
      fuelCard: json['fuel_card'],
      expectedVehicleReturnTime: json['expected_vehicle_return_time'],
      expectedReturnDate: json['expected_return_date'],
      actualVehicleReturnTime: json['actual_vehicle_return_time'],
      actualReturnDate: json['actual_return_date'],
      vehicleCondition: json['vehicle_condition'],
      driverName: json['driver_name'],

      positionToBeTransferred: json['position_to_be_transferred'],
      effectiveFromDate: json['effective_from_date'],
      decisionNumber: json['decision_number'],
      employeeName: json['employee_name'],
      jobTitle: json['job_title'],
      financialGrade: json['financial_grade'],

      shiftStartDate: json['shift_start_date'] != null
          ? DateTime.tryParse(json['shift_start_date'])
          : null,
      shiftEndDate: json['shift_end_date'] != null
          ? DateTime.tryParse(json['shift_end_date'])
          : null,
      salaryGrade: json['salary_grade'],

      remainingLeaveBalance: json['remaining_leave_balance'],
      basicSalary: json['basic_salary'],
      totalSalaryDue: json['total_salary_due'],

      endOfServiceDate: json['end_of_service_date'] != null
          ? DateTime.tryParse(json['end_of_service_date'])
          : null,

      reasonForTermination: json['reason_for_termination'],
      positionToBeFilled: json['position_to_be_filled'] as String?,
      grade: json['grade'] as String?,
      roleTitle: json['role_title'] as String?,
      educationRequirements: json['education_requirements'] as String?,
      requiredSkills: json['required_skills'] as String?,
      yearsOfExperience: json['years_of_experience'] as String?,
      jobDescription: json['job_description'] as String?,
      currentBasicSalary: json['current_basic_salary'] as String?,
      currentJobTitle: json['current_job_title'] as String?,
      currentSalaryGrade: json['current_salary_grade'] as String?,

      proposedBasicSalary: json['proposed_basic_salary'] as String?,
      proposedJobTitle: json['proposed_job_title'] as String?,
      proposedSalaryGrade: json['proposed_salary_grade'] as String?,
      certificationTitle: json['certification_title'] as String?,
      skillCategory: json['skill_category'] as String?,
      issuingAuthority: json['issuing_authority'] as String?,
      skillSummary: json['skill_summary'] as String?,
      additionalInfoRequested: json['additional_info_requested'] as String?,
      cyclePeriod: json['cycle_period'] as String?,
      cycleYear: json['cycle_year'] as int?,
      extensionNumber: json['extension_number'] as String?,
      quater: json['quater'] as String?,
      year: json['year'] as int?,
      tasks: (json['tasks'] as List?)
          ?.map((e) => TaskModel.fromJson(e as Map<String, dynamic>?))
          .toList(),
      travellingFromRegion: json['travelling_from_region'] as String?,
      travelFrom: json['travel_from'] as String?,
      travelTo: json['travel_to'] as String?,
      timeOfArrival: json['time_of_arrival'] as String?,
      startDateOfStay: json['start_date_of_stay'] as String?,
      referenceNumber: json['reference_number'] as String?,
      otherPurposeSpecification: json['other_purpose_specification'] as String?,
      officialPurposeOfTravel: json['official_purpose_of_travel'] as String?,
      numberOfEmployeesTravelling:
          json['number_of_employees_travelling'] as int?,
      employeeDetails: (json['employee_details'] as List?)
          ?.map(
            (e) => AccommodationEmployeeDetails.fromJson(
              e as Map<String, dynamic>?,
            ),
          )
          .toList(),
      durationOfStay: json['duration_of_stay'] as String?,
      locationOfStay: json['location_of_stay'] as String?,
      reasonForRenewal: json['reason_for_renewal'] as String?,
      requestedRenewalDuration: json['requested_renewal_duration'] as String?,
      approverComment: json['approver_comment'],
      handoverDate: json['handover_date'],
      pendingBillsClearanceStatus: json['pending_bills_clearance_status'],
      reasonForCancellation: json['reason_for_cancellation'],
      requestedCancellationDate: json['requested_cancellation_date'],
      currentContractEndDate: json['current_contract_end_date'],
      currentContractStartDate: json['current_contract_start_date'],
      phone: json['phone'] as String?,
      titleOfProject: json['title_of_project'] as String?,
      applicationUrl: json['application_url'] as String?,
      ipAddress: json['ip_address'] as String?,
      link: json['link'] as String?,
      submissionDate: json['submission_date'] as String?,
      applicationName: json['application_name'] as String?,
      requestClassification: json['request_classification'] as String?,
      applicationToBeAudited: json['application_to_be_audited'] as String?,
      applicationToBeAuditedOther:
          json['application_to_be_audited_other'] as String?,
      acknowledgement: json['acknowledgement'] as bool?,
      hosOrDepartmentName: json['hos_or_department_name'] as String?,
      requestTitle: json['request_title'] as String?,
      titleOfComplaint: json['title_of_complaint'],
      appealAgainstDecision: json['appeal_against_decision'],
      decisionDate: json['decision_date'],
      decisionSubject: json['decision_subject'],
      grievanceDetails: json['grievance_details'],
      individualsInvolved: json['individuals_involved'],
      times: json['times'] != null ? List<String>.from(json['times']) : [],
      dates: json['dates'],
      requests: json['requests'],
      events: json['events'],
      grievantName: json['grievant_name'],
      grievantEmployeeNumber: json['grievant_employee_number'],
      grievantDirectorateId: json['grievant_directorate_id'],
      grievantDepartmentId: json['grievant_department_id'],
      grievantSectionId: json['grievant_section_id'],
      grievantRelationshipToMatter: json['grievant_relationship_to_matter'],
      declarationAcknowledged: json['declaration_acknowledged'],
      // Tender Service
      titleOfEnquiry: json['title_of_enquiry'],
      tenderDateOfSubmission: json['tender_date_of_submission'],
      tenderPhone: json['tender_phone'],
      budgetCode: json['budget_code'],
      estimatedCost: json['estimated_cost'],
      implementationPeriod: json['implementation_period'],
      requestingEntity: json['requesting_entity'],
      projectCodeBudgetCode:
          (json['project_code_budget_code'] ?? json['project_or_budget_code']),
      companyName: json['company_name'],
      // Vehicle Maintenance
      typeOfMaintenanceRequired: json['type_of_maintenance_required'],

      issueDescription: json['issue_description'],

      preferredMaintenanceDate: json['preferred_maintenance_date'],

      requestSubmissionDate: json['request_submission_date'],
      // Request for Study Leave
      alreadySubmittedInMinistryOfEducationSystem:
          json['already_submitted_in_ministry_of_education_system'],
      areaName: json['area_name'],
      countryName: json['country_name'],
      qualificationRequired: json['qualification_required'],
      haveYouEverReceivedAuthority: json['have_you_ever_received_authority'],
      scholarship: json['scholarship'],
      travelDateFrom: json['travel_date_from'],
      travelDateTo: json['travel_date_to'],
      duration: json['duration'],

      // security threat
      contactNumber: json['contact_number'],

      ticketName: json['ticket_name'],

      sourceOfIncident: json['source_of_incident'],

      typeOfIncidentDetected: (json['type_of_incident_detected'] as List?)
          ?.map((e) => e.toString())
          .toList(),

      incidentNotificationInCaa: (json['incident_notification_in_caa'] as List?)
          ?.map((e) => e.toString())
          .toList(),

      identificationMeasures: json['identification_measures'],

      evidenceCollected: json['evidence_collected'],

      eradicationMitigationMeasures: json['eradication_mitigation_measures'],

      recoveryMeasures: json['recovery_measures'],

      otherMitigationMeasures: json['other_mitigation_measures'],
      numberOfPassengers: json['number_of_passengers'],

      employeeIdPassport: json['employee_id_passport'],

      originCity: json['origin_city'],
      destinationCity: json['destination_city'],

      arrivalDepartureDatetime: json['arrival_departure_datetime'],

      specialInstructions: json['special_instructions'],
    );
  }

  // ─────────────────────────────
  // TO JSON
  // ─────────────────────────────

  // ─────────────────────────────
  // COPYWITH
  // ─────────────────────────────
  RequestModel copyWith({
    int? id,
    int? serviceId,
    int? subServiceId,

    String? description,
    String? status,
    String? priority,
    int? typeOfThreat,

    String? workflowExecutionId,
    int? createdBy,
    String? createdAt,
    int? updatedBy,
    String? updatedAt,
    int? userId,

    int? reqUserDepartmentId,
    int? reqUserSectionId,

    String? contactNum,
    String? extnNum,
    String? email,
    String? personName,
    String? personContactNumber,
    String? requestFor,
    String? problem,
    String? requestDate,
    int? serviceTypeId,
    String? requestType,

    String? category,
    String? vehicleRequiredFor,
    String? vehicleRequiredLocation,
    String? title,
    String? purposeOfTravel,
    String? typeOfVehicleRequired,
    String? typeOfRequest,
    String? dateOfTravel,
    String? timeOfTravel,
    int? expDurationOfUseHrs,
    int? expDurationOfUseDays,

    String? hotelName,
    String? typeOfAccommodation,
    int? numberOfGuests,
    List<String>? meal,
    String? price,
    String? requestedBy,
    bool? hrApproval,
    bool? prApproval,
    String? checkInDate,
    String? checkInTime,
    String? checkOutDate,
    String? checkOutTime,
    String? dateOfRequest,
    String? visitorName,

    UserModel? createdByUser,
    ServiceTypeModel? serviceType,
    ServiceModel? service,
    SubServiceModel? subService,
    DepartmentModel? reqDepartment,
    SectionModel? reqSection,

    String? dateOfSubmission,
    String? phoneNumber,
    String? place,
    String? eventDate,
    String? eventTime,
    String? mediaCoverageRequired,
  }) {
    return RequestModel(
      id: id ?? this.id,
      serviceId: serviceId ?? this.serviceId,
      subServiceId: subServiceId ?? this.subServiceId,

      description: description ?? this.description,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      typeOfThreat: typeOfThreat ?? this.typeOfThreat,

      workflowExecutionId: workflowExecutionId ?? this.workflowExecutionId,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedBy: updatedBy ?? this.updatedBy,
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,

      reqUserDepartmentId: reqUserDepartmentId ?? this.reqUserDepartmentId,
      reqUserSectionId: reqUserSectionId ?? this.reqUserSectionId,

      contactNum: contactNum ?? this.contactNum,
      extnNum: extnNum ?? this.extnNum,
      email: email ?? this.email,
      personName: personName ?? this.personName,
      personContactNumber: personContactNumber ?? this.personContactNumber,
      requestFor: requestFor ?? this.requestFor,
      problem: problem ?? this.problem,
      requestDate: requestDate ?? this.requestDate,
      serviceTypeId: serviceTypeId ?? this.serviceTypeId,
      requestType: requestType ?? this.requestType,

      category: category ?? this.category,
      vehicleRequiredFor: vehicleRequiredFor ?? this.vehicleRequiredFor,
      vehicleRequiredLocation:
          vehicleRequiredLocation ?? this.vehicleRequiredLocation,
      title: title ?? this.title,
      purposeOfTravel: purposeOfTravel ?? this.purposeOfTravel,
      typeOfVehicleRequired:
          typeOfVehicleRequired ?? this.typeOfVehicleRequired,
      typeOfRequest: typeOfRequest ?? this.typeOfRequest,
      dateOfTravel: dateOfTravel ?? this.dateOfTravel,
      timeOfTravel: timeOfTravel ?? this.timeOfTravel,
      expDurationOfUseHrs: expDurationOfUseHrs ?? this.expDurationOfUseHrs,
      expDurationOfUseDays: expDurationOfUseDays ?? this.expDurationOfUseDays,

      hotelName: hotelName ?? this.hotelName,
      typeOfAccommodation: typeOfAccommodation ?? this.typeOfAccommodation,
      numberOfGuests: numberOfGuests ?? this.numberOfGuests,
      meal: meal ?? this.meal,
      price: price ?? this.price,
      requestedBy: requestedBy ?? this.requestedBy,
      hrApproval: hrApproval ?? this.hrApproval,
      prApproval: prApproval ?? this.prApproval,
      checkInDate: checkInDate ?? this.checkInDate,
      checkInTime: checkInTime ?? this.checkInTime,
      checkOutDate: checkOutDate ?? this.checkOutDate,
      checkOutTime: checkOutTime ?? this.checkOutTime,
      dateOfRequest: dateOfRequest ?? this.dateOfRequest,
      visitorName: visitorName ?? this.visitorName,

      createdByUser: createdByUser ?? this.createdByUser,
      serviceType: serviceType ?? this.serviceType,
      service: service ?? this.service,
      subService: subService ?? this.subService,
      reqDepartment: reqDepartment ?? this.reqDepartment,
      reqSection: reqSection ?? this.reqSection,
      dateOfSubmission: dateOfSubmission ?? this.dateOfSubmission,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      place: place ?? this.place,
      eventDate: eventDate ?? this.eventDate,
      eventTime: eventTime ?? this.eventTime,
      mediaCoverageRequired:
          mediaCoverageRequired ?? this.mediaCoverageRequired,
    );
  }
}

class UserModel {
  final int? id;
  final String? employeeId;
  final String? civilEmployeeId;
  final String? employeeName;
  final String? employeeArabicName;
  final String? personType;
  final String? dateOfBirth;
  final String? regionOfBirth;
  final String? countryOfBirth;
  final String? dateOfJoining;
  final String? lastPromotionDate;
  final String? gender;
  final String? qualification;
  final String? maritalStatus;
  final String? nationality;
  final String? email;
  final String? bloodType;
  final String? nationalId;
  final String? manpowerId;
  final String? mobile;
  final String? officeNumber;

  /// FIXED — department can be ID or object AND API also gives user_department
  final DepartmentModel? department;

  final String? category;
  final String? directorate;

  /// FIXED — section can be ID or object AND API also gives user_section
  final SectionModel? section;

  /// FIXED — position can be ID or object AND API also gives user_position
  final PositionModel? position;

  final String? arabicPosition;
  final int? grade;
  final String? location;
  final String? supervisorEmpId;
  final String? supervisorEmpName;

  final String? passportNumber;
  final String? personalEmail;
  final int? extensionNumber;
  final String? faxNumber;
  final String? diplomaticName;
  final String? avatar;
  final String? fatherName;
  final String? spouseName;
  final String? children1Name;
  final String? children2Name;
  final String? address;
  final String? religion;

  UserModel({
    this.id,
    this.employeeId,
    this.civilEmployeeId,
    this.employeeName,
    this.employeeArabicName,
    this.personType,
    this.dateOfBirth,
    this.regionOfBirth,
    this.countryOfBirth,
    this.dateOfJoining,
    this.lastPromotionDate,
    this.gender,
    this.qualification,
    this.maritalStatus,
    this.nationality,
    this.email,
    this.bloodType,
    this.nationalId,
    this.manpowerId,
    this.mobile,
    this.officeNumber,
    this.department,
    this.category,
    this.directorate,
    this.section,
    this.position,
    this.arabicPosition,
    this.grade,
    this.location,
    this.supervisorEmpId,
    this.supervisorEmpName,
    this.passportNumber,
    this.personalEmail,
    this.extensionNumber,
    this.faxNumber,
    this.diplomaticName,
    this.avatar,
    this.fatherName,
    this.spouseName,
    this.children1Name,
    this.children2Name,
    this.address,
    this.religion,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      employeeId: json['employee_id'],
      civilEmployeeId: json['civil_employee_id'],
      employeeName: json['employee_name'],
      employeeArabicName: json['employee_arabic_name'],
      personType: json['person_type'],
      dateOfBirth: json['date_of_birth'],
      regionOfBirth: json['region_of_birth'],
      countryOfBirth: json['country_of_birth'],
      dateOfJoining: json['date_of_joining'],
      lastPromotionDate: json['last_promotion_date'],
      gender: json['gender'],
      qualification: json['qualification'],
      maritalStatus: json['marital_status'],
      nationality: json['nationality'],
      email: json['email'],
      bloodType: json['blood_type'],
      nationalId: json['national_id'],
      manpowerId: json['manpower_id'],
      mobile: json['mobile'],
      officeNumber: json['office_number'],

      /// FIX 1 — department
      department: json['user_department'] != null
          ? DepartmentModel.fromJson(json['user_department'])
          : (json['department'] is int
                ? DepartmentModel(id: json['department'])
                : json['department'] is Map
                ? DepartmentModel.fromJson(json['department'])
                : null),

      category: json['category'],
      directorate: json['directorate'],

      /// FIX 2 — section
      section: json['user_section'] != null
          ? SectionModel.fromJson(json['user_section'])
          : (json['section'] is int
                ? SectionModel(id: json['section'])
                : json['section'] is Map
                ? SectionModel.fromJson(json['section'])
                : null),

      /// FIX 3 — position
      position: json['user_position'] != null
          ? PositionModel.fromJson(json['user_position'])
          : (json['position'] is int
                ? PositionModel(id: json['position'])
                : json['position'] is Map
                ? PositionModel.fromJson(json['position'])
                : null),

      arabicPosition: json['arabic_position'],
      grade: json['grade'],
      location: json['location'],
      supervisorEmpId: json['supervisor_emp_id'],
      supervisorEmpName: json['supervisor_emp_name'],
      passportNumber: json['passport_number'],
      personalEmail: json['personal_email'],
      extensionNumber: json['extension_number'],
      faxNumber: json['fax_number'],
      diplomaticName: json['diplomatic_name'],
      avatar: json['avatar'],
      fatherName: json['father_name'],
      spouseName: json['spouse_name'],
      children1Name: json['children1_name'],
      children2Name: json['children2_name'],
      address: json['address'],
      religion: json['religion'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employee_id': employeeId,
      'civil_employee_id': civilEmployeeId,
      'employee_name': employeeName,
      'employee_arabic_name': employeeArabicName,
      'person_type': personType,
      'date_of_birth': dateOfBirth,
      'region_of_birth': regionOfBirth,
      'country_of_birth': countryOfBirth,
      'date_of_joining': dateOfJoining,
      'last_promotion_date': lastPromotionDate,
      'gender': gender,
      'qualification': qualification,
      'marital_status': maritalStatus,
      'nationality': nationality,
      'email': email,
      'blood_type': bloodType,
      'national_id': nationalId,
      'manpower_id': manpowerId,
      'mobile': mobile,
      'office_number': officeNumber,

      /// FIXED
      'department': department?.toJson(),
      'category': category,
      'directorate': directorate,

      'section': section?.toJson(),
      'position': position?.toJson(),

      'arabic_position': arabicPosition,
      'grade': grade,
      'location': location,
      'supervisor_emp_id': supervisorEmpId,
      'supervisor_emp_name': supervisorEmpName,
      'passport_number': passportNumber,
      'personal_email': personalEmail,
      'extension_number': extensionNumber,
      'fax_number': faxNumber,
      'diplomatic_name': diplomaticName,
      'avatar': avatar,
      'father_name': fatherName,
      'spouse_name': spouseName,
      'children1_name': children1Name,
      'children2_name': children2Name,
      'address': address,
      'religion': religion,
    };
  }
}

// ------------------ SIMPLE MODELS ------------------
class DepartmentModel {
  final List<String>? jsonIgnore;
  final bool? isDeleted;
  final int? id;
  final String? departmentName;
  final String? departmentCode;
  final String? departmentDescription;
  final int? createdBy;
  final String? createdAt;
  final int? updatedBy;
  final String? updatedAt;

  DepartmentModel({
    this.jsonIgnore,
    this.isDeleted,
    this.id,
    this.departmentName,
    this.departmentCode,
    this.departmentDescription,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    return DepartmentModel(
      jsonIgnore: (json["jsonIgnore"] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      isDeleted: json["is_deleted"],
      id: json["id"],
      departmentName: json["department_name"],
      departmentCode: json["department_code"],
      departmentDescription: json["department_description"],
      createdBy: json["created_by"],
      createdAt: json["created_at"],
      updatedBy: json["updated_by"],
      updatedAt: json["updated_at"],
    );
  }
  Map<String, dynamic> toJson() => {
    'id': id,
    'department_name': departmentName,
    'department_code': departmentCode,
    'department_description': departmentDescription,
  };
}

class SectionModel {
  final List<String>? jsonIgnore;
  final bool? isDeleted;
  final int? id;
  final String? sectionName;
  final String? sectionCode;
  final String? sectionDescription;
  final int? departmentId;
  final int? createdBy;
  final String? createdAt;
  final int? updatedBy;
  final String? updatedAt;

  SectionModel({
    this.jsonIgnore,
    this.isDeleted,
    this.id,
    this.sectionName,
    this.sectionCode,
    this.sectionDescription,
    this.departmentId,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  factory SectionModel.fromJson(Map<String, dynamic> json) {
    return SectionModel(
      jsonIgnore: (json["jsonIgnore"] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      isDeleted: json["is_deleted"],
      id: json["id"],
      sectionName: json["section_name"],
      sectionCode: json["section_code"],
      sectionDescription: json["section_description"],
      departmentId: json["department_id"] is int
          ? json["department_id"]
          : int.tryParse(json["department_id"] ?? "0"),
      createdBy: json["created_by"],
      createdAt: json["created_at"],
      updatedBy: json["updated_by"],
      updatedAt: json["updated_at"],
    );
  }
  Map<String, dynamic> toJson() => {
    'id': id,
    'section_name': sectionName,
    'section_code': sectionCode,
    'section_description': sectionDescription,
    'department_id': departmentId,
  };
}

// class DepartmentModel {
//   final int? id;
//   final String? departmentName;
//   final String? departmentCode;
//   final String? departmentDescription;

//   DepartmentModel({
//     this.id,
//     this.departmentName,
//     this.departmentCode,
//     this.departmentDescription,
//   });

//   factory DepartmentModel.fromJson(Map<String, dynamic> json) =>
//       DepartmentModel(
//         id: json['id'],
//         departmentName: json['department_name'],
//         departmentCode: json['department_code'],
//         departmentDescription: json['department_description'],
//       );

//   Map<String, dynamic> toJson() => {
//     'id': id,
//     'department_name': departmentName,
//     'department_code': departmentCode,
//     'department_description': departmentDescription,
//   };
// }

// class SectionModel {
//   final int? id;
//   final String? sectionName;
//   final String? sectionCode;
//   final String? sectionDescription;
//   final dynamic departmentId; // can be string or int

//   SectionModel({
//     this.id,
//     this.sectionName,
//     this.sectionCode,
//     this.sectionDescription,
//     this.departmentId,
//   });

//   factory SectionModel.fromJson(Map<String, dynamic> json) => SectionModel(
//     id: json['id'],
//     sectionName: json['section_name'],
//     sectionCode: json['section_code'],
//     sectionDescription: json['section_description'],
//     departmentId: json['department_id'],
//   );

//   Map<String, dynamic> toJson() => {
//     'id': id,
//     'section_name': sectionName,
//     'section_code': sectionCode,
//     'section_description': sectionDescription,
//     'department_id': departmentId,
//   };
// }

class PositionModel {
  final int? id;
  final String? name;

  PositionModel({this.id, this.name});

  factory PositionModel.fromJson(Map<String, dynamic> json) =>
      PositionModel(id: json['id'], name: json['name']);

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}

class ServiceTypeModel {
  final int? id;
  final String? name;
  final String? nameInArabic;
  final int? serviceId;
  final int? subServiceId;
  final String? description;
  final bool? isActive;
  final int? departmentId;
  final int? sectionId;

  ServiceTypeModel({
    this.id,
    this.name,
    this.nameInArabic,
    this.serviceId,
    this.subServiceId,
    this.description,
    this.isActive,
    this.departmentId,
    this.sectionId,
  });

  factory ServiceTypeModel.fromJson(Map<String, dynamic> json) {
    return ServiceTypeModel(
      id: json['id'],
      name: json['name'],
      nameInArabic: json['name_in_arabic'],
      serviceId: json['service_id'],
      subServiceId: json['sub_service_id'],
      description: json['description'],
      isActive: json['is_active'],
      departmentId: json['department_id'],
      sectionId: json['section_id'],
    );
  }
}

class ServiceModel {
  final int? id;
  final String? name;
  final String? description;
  final String? code;
  final String? logoUrl;

  ServiceModel({this.id, this.name, this.description, this.code, this.logoUrl});

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
    id: json['id'],
    name: json['name'],
    description: json['description'],
    code: json['code'],
    logoUrl: json['logo_url'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'code': code,
    'logo_url': logoUrl,
  };
}

class SubServiceModel {
  final int? id;
  final String? subServiceName;
  final String? description;
  final int? serviceId;
  final String? logoUrl;
  final String? code;

  SubServiceModel({
    this.id,
    this.subServiceName,
    this.description,
    this.serviceId,
    this.logoUrl,
    this.code,
  });

  factory SubServiceModel.fromJson(Map<String, dynamic> json) =>
      SubServiceModel(
        id: json['id'],
        subServiceName: json['sub_service_name'],
        description: json['description'],
        serviceId: json['service_id'],
        logoUrl: json['logo_url'],
        code: json['code'],
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'sub_service_name': subServiceName,
    'description': description,
    'service_id': serviceId,
    'logo_url': logoUrl,
    'code': code,
  };
}

class WorkflowDetailModel {
  final bool? isDeleted;
  final int? id;
  final int? requestId;
  final int? serviceId;
  final int? subServiceId;

  final String? content;
  final String? status;
  final int? order;

  // -------- Workflow specific --------
  final int? approverRoleId;
  final int? approverUserId;
  final int? approvedBy;

  // -------- Audit --------
  final int? createdBy;
  final String? createdAt;
  final int? updatedBy;
  final String? updatedAt;

  // -------- NEW (workflow timeline) --------
  final UserModel? approvedByUser;
  final RoleModel? approverRole;

  // -------- OLD (backward compatibility) --------
  final UserModel? user;
  final RoleModel? role;
  final DepartmentModel? department;
  final SectionModel? section;

  WorkflowDetailModel({
    this.isDeleted,
    this.id,
    this.requestId,
    this.serviceId,
    this.subServiceId,
    this.content,
    this.status,
    this.order,
    this.approverRoleId,
    this.approverUserId,
    this.approvedBy,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.approvedByUser,
    this.approverRole,
    this.user,
    this.role,
    this.department,
    this.section,
  });

  factory WorkflowDetailModel.fromJson(Map<String, dynamic> json) {
    return WorkflowDetailModel(
      isDeleted: json['is_deleted'] as bool?,
      id: json['id'] as int?,
      requestId: json['request_id'] as int?,
      serviceId: json['service_id'] as int?,
      subServiceId: json['sub_service_id'] as int?,
      content: json['content'] as String?,
      status: json['status'] as String?,
      order: json['order'] as int?,

      approverRoleId: json['approver_role_id'] as int?,
      approverUserId: json['approver_user_id'] as int?,
      approvedBy: json['approved_by'] as int?,

      createdBy: json['created_by'] as int?,
      createdAt: json['created_at'] as String?,
      updatedBy: json['updated_by'] as int?,
      updatedAt: json['updated_at'] as String?,

      // 🔥 NEW
      approvedByUser: json['approved_by_user'] != null
          ? UserModel.fromJson(json['approved_by_user'])
          : null,

      approverRole: json['approver_role'] != null
          ? RoleModel.fromJson(json['approver_role'])
          : null,

      // 🔁 OLD (fallback)
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,

      role: json['role'] != null ? RoleModel.fromJson(json['role']) : null,

      department: json['department'] != null
          ? DepartmentModel.fromJson(json['department'])
          : null,

      section: json['section'] != null
          ? SectionModel.fromJson(json['section'])
          : null,
    );
  }
  Map<String, dynamic> toJson() => {
    'is_deleted': isDeleted,
    'id': id,
    'request_id': requestId,
    'service_id': serviceId,
    'sub_service_id': subServiceId,
    'content': content,
    'status': status,
    // 'user_id': userId,
    // 'role_id': roleId,
    // 'department_id': departmentId,
    // 'section_id': sectionId,
    'created_by': createdBy,
    'created_at': createdAt,
    'updated_by': updatedBy,
    'updated_at': updatedAt,
    'user': user?.toJson(),
    'role': role?.toJson(),
    'department': department?.toJson(),
    'section': section?.toJson(),
  };
}

class RoleModel {
  final bool? isDeleted;
  final int? id;
  final String? name;
  final int? createdBy;
  final String? createdAt;
  final int? updatedBy;
  final String? updatedAt;

  RoleModel({
    this.isDeleted,
    this.id,
    this.name,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(
      isDeleted: json['is_deleted'] as bool?,
      id: json['id'] as int?,
      name: json['name'] as String?,
      createdBy: json['created_by'] as int?,
      createdAt: json['created_at'] as String?,
      updatedBy: json['updated_by'] as int?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'is_deleted': isDeleted,
    'id': id,
    'name': name,
    'created_by': createdBy,
    'created_at': createdAt,
    'updated_by': updatedBy,
    'updated_at': updatedAt,
  };
}

class ApprovalDetailModel {
  final int? id;
  final int? requestId;
  final int? serviceId;
  final int? subServiceId;
  final int? approverUserId;
  final int? approverRoleId;
  final String? comment;
  final String? approvalStatus;
  final int? level;
  final int? departmentId;
  final int? sectionId;
  final int? approvedBy;
  final int? createdBy;
  final String? createdAt;
  final int? updatedBy;
  final String? updatedAt;
  final bool? isDeleted;
  final bool? isManager;
  final bool? isAllowed;
  final bool? isPresident;
  final bool? isReplace;

  final int? delegationUserId; // Salalah
  final int? delegateUserId; // Logistics

  final DepartmentModel? department;
  final SectionModel? section;

  final ApproverUserModel? approverUser;
  final ApproverRoleModel? approverRole;
  final ApproverUserModel? approvedByUser;
  final ApproverUserModel? delegateUser;

  ApprovalDetailModel({
    this.id,
    this.requestId,
    this.serviceId,
    this.subServiceId,
    this.approverUserId,
    this.approverRoleId,
    this.comment,
    this.approvalStatus,
    this.level,
    this.departmentId,
    this.sectionId,
    this.approvedBy,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.isDeleted,
    this.delegationUserId,
    this.delegateUserId,
    this.approverUser,
    this.approverRole,
    this.approvedByUser,
    this.delegateUser,
    this.isManager,
    this.isAllowed,
    this.isPresident,
    this.isReplace,
    this.department,
    this.section,
  });

  factory ApprovalDetailModel.fromJson(Map<String, dynamic> json) {
    return ApprovalDetailModel(
      id: json['id'],
      requestId: json['request_id'],
      serviceId: json['service_id'],
      subServiceId: json['sub_service_id'],
      approverUserId: json['approver_user_id'],
      approverRoleId: json['approver_role_id'],
      comment: json['comment'],
      approvalStatus: json['approval_status'],
      level: json['level'],
      departmentId: json['department_id'],
      sectionId: json['section_id'],
      approvedBy: json['approved_by'],
      isManager: json['is_manager'],
      createdBy: json['created_by'],
      createdAt: json['created_at'],
      updatedBy: json['updated_by'],
      updatedAt: json['updated_at'],
      isDeleted: json['is_deleted'],
      isAllowed: json['is_allowed'],
      isPresident: json['is_president'],
      isReplace: json['is_replace'],

      delegationUserId: json['delegation_user_id'],
      delegateUserId: json['delegate_user_id'],
      department: json['department'] is Map
          ? DepartmentModel.fromJson(json['department'])
          : null,
      section: json['section'] is Map
          ? SectionModel.fromJson(json['section'])
          : null,

      approverUser: json['approver_user'] is Map
          ? ApproverUserModel.fromJson(json['approver_user'])
          : null,

      approverRole: json['approver_role'] is Map
          ? ApproverRoleModel.fromJson(json['approver_role'])
          : null,

      approvedByUser: json['approved_by_user'] is Map
          ? ApproverUserModel.fromJson(json['approved_by_user'])
          : null,

      delegateUser: json['delegate_user'] is Map
          ? ApproverUserModel.fromJson(json['delegate_user'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'request_id': requestId,
    'service_id': serviceId,
    'sub_service_id': subServiceId,
    'approver_user_id': approverUserId,
    'approver_role_id': approverRoleId,
    'comment': comment,
    'approval_status': approvalStatus,
    'level': level,
    'department_id': departmentId,
    'section_id': sectionId,
    'approved_by': approvedBy,
    'created_by': createdBy,
    'created_at': createdAt,
    'updated_by': updatedBy,
    'updated_at': updatedAt,
    'is_deleted': isDeleted,
    'delegation_user_id': delegationUserId,
    'delegate_user_id': delegateUserId,
    'approver_user': approverUser?.toJson(),
    'approver_role': approverRole?.toJson(),
    'approved_by_user': approvedByUser?.toJson(),
    'delegate_user': delegateUser?.toJson(),
  };
}

class ApproverUserModel {
  final int? id;
  final String? employeeId;
  final String? civilEmployeeId;
  final String? employeeName;
  final String? employeeArabicName;
  final String? personType;
  final String? dateOfBirth;
  final String? regionOfBirth;
  final String? countryOfBirth;
  final String? dateOfJoining;
  final String? lastPromotionDate;
  final String? gender;
  final String? qualification;
  final String? maritalStatus;
  final String? nationality;
  final String? email;
  final String? bloodType;
  final String? nationalId;
  final String? manpowerId;
  final String? mobile;
  final String? officeNumber;

  final int? department;
  final String? category;
  final String? directorate;
  final int? section;
  final int? position;

  final String? arabicPosition;
  final int? grade;
  final String? location;
  final String? supervisorEmpId;
  final String? supervisorEmpName;

  final String? passportNumber;
  final String? personalEmail;
  final int? extensionNumber;
  final String? faxNumber;
  final String? diplomaticName;
  final String? avatar;
  final String? fatherName;
  final String? spouseName;
  final String? children1Name;
  final String? children2Name;
  final String? address;
  final String? religion;

  ApproverUserModel({
    this.id,
    this.employeeId,
    this.civilEmployeeId,
    this.employeeName,
    this.employeeArabicName,
    this.personType,
    this.dateOfBirth,
    this.regionOfBirth,
    this.countryOfBirth,
    this.dateOfJoining,
    this.lastPromotionDate,
    this.gender,
    this.qualification,
    this.maritalStatus,
    this.nationality,
    this.email,
    this.bloodType,
    this.nationalId,
    this.manpowerId,
    this.mobile,
    this.officeNumber,
    this.department,
    this.category,
    this.directorate,
    this.section,
    this.position,
    this.arabicPosition,
    this.grade,
    this.location,
    this.supervisorEmpId,
    this.supervisorEmpName,
    this.passportNumber,
    this.personalEmail,
    this.extensionNumber,
    this.faxNumber,
    this.diplomaticName,
    this.avatar,
    this.fatherName,
    this.spouseName,
    this.children1Name,
    this.children2Name,
    this.address,
    this.religion,
  });

  factory ApproverUserModel.fromJson(Map<String, dynamic> json) {
    return ApproverUserModel(
      id: json['id'],
      employeeId: json['employee_id'],
      civilEmployeeId: json['civil_employee_id'],
      employeeName: json['employee_name'],
      employeeArabicName: json['employee_arabic_name'],
      personType: json['person_type'],
      dateOfBirth: json['date_of_birth'],
      regionOfBirth: json['region_of_birth'],
      countryOfBirth: json['country_of_birth'],
      dateOfJoining: json['date_of_joining'],
      lastPromotionDate: json['last_promotion_date'],
      gender: json['gender'],
      qualification: json['qualification'],
      maritalStatus: json['marital_status'],
      nationality: json['nationality'],
      email: json['email'],
      bloodType: json['blood_type'],
      nationalId: json['national_id'],
      manpowerId: json['manpower_id'],
      mobile: json['mobile'],
      officeNumber: json['office_number'],

      department: json['department'],
      category: json['category'],
      directorate: json['directorate'],

      section: json['section'],
      position: json['position'],

      arabicPosition: json['arabic_position'],
      grade: json['grade'],
      location: json['location'],
      supervisorEmpId: json['supervisor_emp_id'],
      supervisorEmpName: json['supervisor_emp_name'],

      passportNumber: json['passport_number'],
      personalEmail: json['personal_email'],
      extensionNumber: json['extension_number'],
      faxNumber: json['fax_number'],
      diplomaticName: json['diplomatic_name'],
      avatar: json['avatar'],
      fatherName: json['father_name'],
      spouseName: json['spouse_name'],
      children1Name: json['children1_name'],
      children2Name: json['children2_name'],
      address: json['address'],
      religion: json['religion'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'employee_id': employeeId,
    'civil_employee_id': civilEmployeeId,
    'employee_name': employeeName,
    'employee_arabic_name': employeeArabicName,
    'person_type': personType,
    'date_of_birth': dateOfBirth,
    'region_of_birth': regionOfBirth,
    'country_of_birth': countryOfBirth,
    'date_of_joining': dateOfJoining,
    'last_promotion_date': lastPromotionDate,
    'gender': gender,
    'qualification': qualification,
    'marital_status': maritalStatus,
    'nationality': nationality,
    'email': email,
    'blood_type': bloodType,
    'national_id': nationalId,
    'manpower_id': manpowerId,
    'mobile': mobile,
    'office_number': officeNumber,
    'department': department,
    'category': category,
    'directorate': directorate,
    'section': section,
    'position': position,
    'arabic_position': arabicPosition,
    'grade': grade,
    'location': location,
    'supervisor_emp_id': supervisorEmpId,
    'supervisor_emp_name': supervisorEmpName,
    'passport_number': passportNumber,
    'personal_email': personalEmail,
    'extension_number': extensionNumber,
    'fax_number': faxNumber,
    'diplomatic_name': diplomaticName,
    'avatar': avatar,
    'father_name': fatherName,
    'spouse_name': spouseName,
    'children1_name': children1Name,
    'children2_name': children2Name,
    'address': address,
    'religion': religion,
  };
}

class ApproverRoleModel {
  final int? id;
  final String? name;
  final int? createdBy;
  final String? createdAt;
  final int? updatedBy;
  final String? updatedAt;

  ApproverRoleModel({
    this.id,
    this.name,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  factory ApproverRoleModel.fromJson(Map<String, dynamic> json) {
    return ApproverRoleModel(
      id: json['id'],
      name: json['name'],
      createdBy: json['created_by'],
      createdAt: json['created_at'],
      updatedBy: json['updated_by'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'created_by': createdBy,
      'created_at': createdAt,
      'updated_by': updatedBy,
      'updated_at': updatedAt,
    };
  }
}

class AttachmentModel {
  final int? id;
  final int? requestId;

  final int? uploadedBy;
  final String? fileUrl;
  final String? fileName;
  final String? fileType;
  final String? fileSize;
  final String? description;

  final int? serviceId;
  final int? subServiceId;

  final int? createdBy;
  final String? createdAt;
  final int? updatedBy;
  final String? updatedAt;

  final UserModel? user;

  AttachmentModel({
    this.id,
    this.requestId,
    this.uploadedBy,
    this.fileUrl,
    this.fileName,
    this.fileType,
    this.fileSize,
    this.description,
    this.serviceId,
    this.subServiceId,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.user,
  });

  factory AttachmentModel.fromJson(Map<String, dynamic> json) {
    return AttachmentModel(
      id: json['id'],
      requestId: json['request_id'],

      uploadedBy: json['uploaded_by'],
      fileUrl: json['file_url'],
      fileName: json['file_name'],
      fileType: json['file_type'],
      fileSize: json['file_size']?.toString(),
      description: json['description'],

      serviceId: json['service_id'],
      subServiceId: json['sub_service_id'],

      createdBy: json['created_by'],
      createdAt: json['created_at'],
      updatedBy: json['updated_by'],
      updatedAt: json['updated_at'],

      user: json['user'] is Map ? UserModel.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'request_id': requestId,
    'uploaded_by': uploadedBy,
    'file_url': fileUrl,
    'file_name': fileName,
    'file_type': fileType,
    'file_size': fileSize,
    'description': description,
    'service_id': serviceId,
    'sub_service_id': subServiceId,
    'created_by': createdBy,
    'created_at': createdAt,
    'updated_by': updatedBy,
    'updated_at': updatedAt,
    'user': user?.toJson(),
  };
}

class ChatMessageModel {
  final int? id;
  final int? requestId;
  final int? serviceId;
  final int? subServiceId;

  final int? userId;
  final int? roleId;

  final String? message;
  final String? messageType;
  final String? status;

  final bool? isInternal;
  final bool? isDeleted; // ✅ added

  final int? createdBy;
  final String? createdAt;
  final int? updatedBy;
  final String? updatedAt;

  final UserModel? user;

  // ✅ added relational models
  // final RequestModel? request;
  // final ServiceModel? service;
  // final SubServiceModel? subService;
  final RoleModel? role;

  ChatMessageModel({
    this.id,
    this.requestId,
    this.serviceId,
    this.subServiceId,
    this.userId,
    this.roleId,
    this.message,
    this.messageType,
    this.status,
    this.isInternal,
    this.isDeleted,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.user,
    // this.request,
    // this.service,
    // this.subService,
    this.role,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['id'],
      requestId: json['request_id'],
      serviceId: json['service_id'],
      subServiceId: json['sub_service_id'],
      userId: json['user_id'],
      roleId: json['role_id'],
      message: json['message'],
      messageType: json['messageType'],
      status: json['status'],
      isInternal: json['is_internal'],
      isDeleted: json['is_deleted'], // ✅ added
      createdBy: json['created_by'],
      createdAt: json['created_at'],
      updatedBy: json['updated_by'],
      updatedAt: json['updated_at'],
      user: json['user'] is Map ? UserModel.fromJson(json['user']) : null,

      // ✅ added parsing
      // request: json['request'] != null
      //     ? RequestModel.fromJson(json['request'])
      //     : null,
      // service: json['service'] != null
      //     ? ServiceModel.fromJson(json['service'])
      //     : null,
      // subService: json['sub_service'] != null
      //     ? SubServiceModel.fromJson(json['sub_service'])
      //     : null,
      role: json['role'] != null ? RoleModel.fromJson(json['role']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'request_id': requestId,
    'service_id': serviceId,
    'sub_service_id': subServiceId,
    'user_id': userId,
    'role_id': roleId,
    'message': message,
    'messageType': messageType,
    'status': status,
    'is_internal': isInternal,
    'is_deleted': isDeleted,
    'created_by': createdBy,
    'created_at': createdAt,
    'updated_by': updatedBy,
    'updated_at': updatedAt,
    'user': user?.toJson(),
    // 'request': request?.toJson(),
    // 'service': service?.toJson(),
    // 'sub_service': subService?.toJson(),
    'role': role?.toJson(),
  };
}

class EmployeeDutyMission {
  final String? employeeId;
  final String? employeeName;
  final String? department;
  final String? grade;
  final String? position;
  final String? percentage;
  final String? allowancePerDay;
  final String? totalAllowance;

  EmployeeDutyMission({
    this.employeeId,
    this.employeeName,
    this.department,
    this.grade,
    this.position,
    this.percentage,
    this.allowancePerDay,
    this.totalAllowance,
  });

  factory EmployeeDutyMission.fromJson(Map<String, dynamic> json) {
    return EmployeeDutyMission(
      employeeId: json['employee_id'],
      employeeName: json['employee_name'],
      department: json['department'],
      grade: json['grade'],
      position: json['position'],
      percentage: json['percentage'],
      allowancePerDay: json['allowance_per_day'],
      totalAllowance: json['total_allowance'],
    );
  }

  Map<String, dynamic> toJson() => {
    'employee_id': employeeId,
    'employee_name': employeeName,
    'department': department,
    'grade': grade,
    'position': position,
    'percentage': percentage,
    'allowance_per_day': allowancePerDay,
    'total_allowance': totalAllowance,
  };
}

class AirTicketDetail {
  final String? employeeId;
  final String? employeeName;
  final String? passportNo;
  final String? ticketType;
  final String? departureDate;
  final String? returnDate;

  AirTicketDetail({
    this.employeeId,
    this.employeeName,
    this.passportNo,
    this.ticketType,
    this.departureDate,
    this.returnDate,
  });

  factory AirTicketDetail.fromJson(Map<String, dynamic> json) {
    return AirTicketDetail(
      employeeId: json['employee_id'],
      employeeName: json['employee_name'],
      passportNo: json['passport_no'],
      ticketType: json['ticket_type'],
      departureDate: json['departure_date'],
      returnDate: json['return_date'],
    );
  }

  Map<String, dynamic> toJson() => {
    'employee_id': employeeId,
    'employee_name': employeeName,
    'passport_no': passportNo,
    'ticket_type': ticketType,
    'departure_date': departureDate,
    'return_date': returnDate,
  };
}

class EmployeeDetailModel {
  final int? id;
  final bool? isDeleted;

  final int? requestId;
  final int? serviceId;
  final int? subServiceId;

  final String? employeeId;
  final String? employeeName;
  final String? department;
  final String? grade;
  final String? position;

  final String? percentage;
  final String? allowancePerDay;
  final String? totalAllowance;

  final int? createdBy;
  final int? updatedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const EmployeeDetailModel({
    this.id,
    this.isDeleted,
    this.requestId,
    this.serviceId,
    this.subServiceId,
    this.employeeId,
    this.employeeName,
    this.department,
    this.grade,
    this.position,
    this.percentage,
    this.allowancePerDay,
    this.totalAllowance,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory EmployeeDetailModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const EmployeeDetailModel();

    return EmployeeDetailModel(
      id: json['id'],
      isDeleted: json['is_deleted'],
      requestId: json['request_id'],
      serviceId: json['service_id'],
      subServiceId: json['sub_service_id'],
      employeeId: json['employee_id'],
      employeeName: json['employee_name'],
      department: json['department'],
      grade: json['grade'],
      position: json['position'],
      percentage: json['percentage'],
      allowancePerDay: json['allowance_per_day'],
      totalAllowance: json['total_allowance'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }
}

class AirTicketDetailModel {
  final int? id;
  final bool? isDeleted;

  final int? requestId;
  final int? serviceId;
  final int? subServiceId;

  final String? employeeId;
  final String? employeeName;
  final String? passportNo;
  final String? ticketType;

  final String? decisionDate;
  final String? departureDate;
  final String? returnDate;
  final String? decisionNumber;
  final String? missionNumber;
  final String? passportIssueDate;
  final String? passportExpiryDate;

  final int? createdBy;
  final int? updatedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const AirTicketDetailModel({
    this.id,
    this.isDeleted,
    this.requestId,
    this.serviceId,
    this.subServiceId,
    this.employeeId,
    this.employeeName,
    this.passportNo,
    this.ticketType,
    this.decisionDate,
    this.departureDate,
    this.returnDate,
    this.decisionNumber,
    this.missionNumber,
    this.passportIssueDate,
    this.passportExpiryDate,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory AirTicketDetailModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const AirTicketDetailModel();

    return AirTicketDetailModel(
      id: json['id'],
      isDeleted: json['is_deleted'],
      requestId: json['request_id'],
      serviceId: json['service_id'],
      subServiceId: json['sub_service_id'],
      employeeId: json['employee_id'],
      employeeName: json['employee_name'],
      passportNo: json['passport_no'],
      ticketType: json['ticket_type'],
      decisionDate: json['decision_date'],
      departureDate: json['departure_date'],
      returnDate: json['return_date'],
      decisionNumber: json['decision_number'],
      missionNumber: json['mission_number'],
      passportIssueDate: json['passport_issue_date'],
      passportExpiryDate: json['passport_expiry_date'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }
}
