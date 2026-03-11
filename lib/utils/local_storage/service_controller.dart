// import 'package:code_setup/presentation/screens/services/controller.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hive/hive.dart';

// final servicesProvider =
//     StateNotifierProvider<ServicesController, List<Map<String, dynamic>>>(
//       (ref) => ServicesController(),
//     );

// class ServicesController extends StateNotifier<List<Map<String, dynamic>>> {
//   final Box bookmarksBox = Hive.box('bookmarks');

//   ServicesController() : super(sampleData) {
//     _updateStateWithBookmarks();
//   }

//   /// Add bookmark state to each service
//   void _updateStateWithBookmarks() {
//     final bookmarkedIds = bookmarksBox.keys.cast<int>().toSet();

//     state = state.map((service) {
//       return {
//         ...service,
//         "isBookmarked": bookmarkedIds.contains(service["id"]),
//       };
//     }).toList();
//   }

//   /// Toggle bookmark in Hive + refresh state
//   Future<void> toggleBookmark(int id) async {
//     if (bookmarksBox.containsKey(id)) {
//       await bookmarksBox.delete(id);
//     } else {
//       await bookmarksBox.put(id, true);
//     }
//     _updateStateWithBookmarks();
//   }
// }
