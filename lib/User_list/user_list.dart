import 'package:demo/User_list/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserList extends StatelessWidget {
  UserList({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController controller = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 0.5, color: Colors.black),
          ),
          child: TextField(
            onChanged: controller.filterUsers,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.only(left: 10),
              hintText: 'Search user',
              border: InputBorder.none,
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoding.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.users.isEmpty) {
          return const Center(child: Text('No users found.'));
        }
        return ListView.builder(
          itemCount: controller.users.length,
          itemBuilder: (_, index) {
            final user = controller.users[index];
            return ListTile(
              title: Text(user.title ?? 'No Title'), // ✅ safe access
              subtitle: Text(user.body ?? ''), // Optional: show more data
            );
          },
        );
      }),
    );
  }
}
