// import your existing models:

import 'package:code_setup/presentation/models/details_models.dart';

class HotelReservationListResponse {
  String? status;
  List<HotelReservationRequestModel>? data;
  int? totalCount;

  HotelReservationListResponse({this.status, this.data, this.totalCount});

  factory HotelReservationListResponse.fromJson(Map<String, dynamic> json) {
    return HotelReservationListResponse(
      status: json["status"],
      data: json["data"] == null
          ? []
          : List<HotelReservationRequestModel>.from(
              json["data"].map((x) => HotelReservationRequestModel.fromJson(x)),
            ),
      totalCount: json["total_count"],
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    // "data": data?.map((e) => e.toJson()).toList() ?? [],
    "total_count": totalCount,
  };
}

class HotelReservationRequestModel {
  List<String>? jsonIgnore;
  bool? isDeleted;
  int? id;

  String? typeOfAccommodation;
  String? price;
  List<String>? meal;

  ServiceModel? service;

  DateTime? dateOfRequest;
  String? hotelName;
  String? checkInDate;
  String? checkInTime;
  String? checkOutDate;
  String? checkOutTime;

  int? numberOfGuests;
  String? description;
  String? requestedBy;
  String? visitorName;
  int? userId;

  String? status;

  bool? hrApproval;
  bool? prApproval;

  int? serviceId;
  int? subServiceId;
  String? serviceType;

  String? workflowExecutionId;

  int? reqUserDepartmentId;
  int? reqUserSectionId;

  String? attachmentUrl;
  String? bookingDate;

  int? createdBy;
  DateTime? createdAt;
  int? updatedBy;
  DateTime? updatedAt;

  UserModel? createdByUser;

  DepartmentModel? reqDepartment;
  SectionModel? reqSection;

  ServiceModel? subService;

  List<WorkflowDetailModel>? workflowLogs;
  List<ApprovalDetailModel>? approvalDetails;
  List<ChatMessageModel>? chatMessages;
  List<AttachmentModel>? attachments;

  HotelReservationRequestModel({
    this.jsonIgnore,
    this.isDeleted,
    this.id,
    this.typeOfAccommodation,
    this.price,
    this.meal,
    this.service,
    this.dateOfRequest,
    this.hotelName,
    this.checkInDate,
    this.checkInTime,
    this.checkOutDate,
    this.checkOutTime,
    this.numberOfGuests,
    this.description,
    this.requestedBy,
    this.visitorName,
    this.userId,
    this.status,
    this.hrApproval,
    this.prApproval,
    this.serviceId,
    this.subServiceId,
    this.serviceType,
    this.workflowExecutionId,
    this.reqUserDepartmentId,
    this.reqUserSectionId,
    this.attachmentUrl,
    this.bookingDate,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.createdByUser,
    this.reqDepartment,
    this.reqSection,
    this.subService,
    this.workflowLogs,
    this.approvalDetails,
    this.chatMessages,
    this.attachments,
  });

  factory HotelReservationRequestModel.fromJson(Map<String, dynamic> json) =>
      HotelReservationRequestModel(
        jsonIgnore: json["jsonIgnore"] == null
            ? []
            : List<String>.from(json["jsonIgnore"].map((x) => x.toString())),

        isDeleted: json["is_deleted"],
        id: json["id"],

        typeOfAccommodation: json["type_of_accommodation"],
        price: json["price"],

        meal: json["meal"] == null
            ? []
            : List<String>.from(json["meal"].map((x) => x.toString())),

        service: json["service"] == null
            ? null
            : ServiceModel.fromJson(json["service"]),

        dateOfRequest: json["date_of_request"] == null
            ? null
            : DateTime.tryParse(json["date_of_request"]),

        hotelName: json["hotel_name"],
        checkInDate: json["check_in_date"],
        checkInTime: json["check_in_time"],
        checkOutDate: json["check_out_date"],
        checkOutTime: json["check_out_time"],

        numberOfGuests: json["number_of_guests"],
        description: json["description"],
        requestedBy: json["requested_by"]?.toString(),
        visitorName: json["visitor_name"]?.toString(),
        userId: json["user_id"],

        status: json["status"],
        hrApproval: json["hr_approval"],
        prApproval: json["pr_approval"],

        serviceId: json["service_id"],
        subServiceId: json["sub_service_id"],
        serviceType: json["service_type"]?.toString(),

        workflowExecutionId: json["workflow_execution_id"],

        reqUserDepartmentId: json["req_user_department_id"],
        reqUserSectionId: json["req_user_section_id"],

        attachmentUrl: json["attachment_url"],
        bookingDate: json["booking_date"],

        createdBy: json["created_by"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.tryParse(json["created_at"]),
        updatedBy: json["updated_by"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.tryParse(json["updated_at"]),

        createdByUser: json["created_by_user"] == null
            ? null
            : UserModel.fromJson(json["created_by_user"]),

        reqDepartment: json["req_department"] == null
            ? null
            : DepartmentModel.fromJson(json["req_department"]),

        reqSection: json["req_section"] == null
            ? null
            : SectionModel.fromJson(json["req_section"]),

        subService: json["sub_service"] == null
            ? null
            : ServiceModel.fromJson(json["sub_service"]),

        approvalDetails: json["approval_details"] == null
            ? []
            : List<ApprovalDetailModel>.from(
                json["approval_details"].map(
                  (x) => ApprovalDetailModel.fromJson(x),
                ),
              ),

        chatMessages: json["chat_messages"] == null
            ? []
            : List<ChatMessageModel>.from(
                json["chat_messages"].map((x) => ChatMessageModel.fromJson(x)),
              ),

        attachments: json["attachments"] == null
            ? []
            : List<AttachmentModel>.from(
                json["attachments"].map((x) => AttachmentModel.fromJson(x)),
              ),
        workflowLogs: json["workflow_logs"] == null
            ? []
            : List<WorkflowDetailModel>.from(
                json["workflow_logs"].map(
                  (x) => WorkflowDetailModel.fromJson(x),
                ),
              ),
      );
}
