import 'package:code_setup/presentation/models/models.dart';
import 'package:code_setup/presentation/models/sections.dart';
import 'package:code_setup/presentation/models/userIdModel.dart';
import 'package:code_setup/presentation/screens/home_screen/approvals/model/actionItems.dart';
import 'package:code_setup/presentation/screens/home_screen/dashboard/models/announcementsModels.dart';
import 'package:code_setup/presentation/screens/home_screen/dashboard/models/bookmarksModel.dart';
import 'package:code_setup/presentation/screens/home_screen/dashboard/models/servicesModel.dart';
import 'package:code_setup/presentation/screens/home_screen/dashboard/models/userModel.dart';
import 'package:code_setup/repository/dashboard/data/dashboardImplementation.dart';

abstract class DashboardRepository {
  factory DashboardRepository() => DashboardRepositoryImplementation();
  Future<List<Bookmarksmodel>> getBookmarks();
  Future<List<DepartmentResponse>> getDepartmentsUsersCount();
  Future<List<DepartmentListResponse>> getDepartments();
  // Future<ServiceModel> getServices();
  Future<UserModel> getUser(int id);
  Future<List<EmployeesResponse>> getUserById();
  Future<List<SectionResponse>> getSections();
  Future<List<AnnouncementModel>> getModels();
  Future<void> updateBookmark({required int userId, required int serviceId});
  Future<List<ActionItemData>> getActionItems({required int userId});
}
