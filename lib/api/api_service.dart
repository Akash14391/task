import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:demo/models/user_model.dart';

class ApiService {
  final dummyUrl = "https://jsonplaceholder.typicode.com/posts";

  Future<List<User>> fetchUsers() async {
    final response = await http.get(
      Uri.parse(dummyUrl),
      headers: {
        // 'Authorization': 'Bearer your_token_here',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> decoded = jsonDecode(response.body);
      return decoded.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception(
        "Failed to fetch user data. Status code: ${response.statusCode}",
      );
    }
  }
}
