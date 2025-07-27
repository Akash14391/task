import 'package:demo/api/api_service.dart';
import 'package:demo/models/user_model.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final ApiService apiService = ApiService();

  var users = <User>[].obs;
  var allUsers = <User>[]; // Keep original data
  var isLoding = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  void fetchUsers() async {
    try {
      isLoding(true);
      final result = await apiService.fetchUsers();
      allUsers = result;
      users.assignAll(result);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoding(false);
    }
  }

  void filterUsers(String query) {
    if (query.isEmpty) {
      users.assignAll(allUsers);
    } else {
      final filtered =
          allUsers
              .where(
                (user) =>
                    user.title?.toLowerCase().contains(query.toLowerCase()) ??
                    false,
              )
              .toList();
      users.assignAll(filtered);
    }
  }
}
