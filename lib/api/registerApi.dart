import 'package:dinebot/user/loginscreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

 String baseurl = "";
Future<void> registerapi({
  required BuildContext context,
  required String name,
  required String email,
  required String number,

  required String place,
  required String username,
  required String password,
}) async {
  try {
    var data = {
      "name": name,
      "email": email,
      "place": place,
      "phoneno": number,
      "username": username,
      "password": password,
    };

    var response = await Dio().post('$baseurl/userregister', data: data);
    print(response);
    if (response.statusCode == 200 || response.statusCode == 201) {
      // On success, maybe show a dialog or navigate to login
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Registration Successful")));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registration failed. Try again.")),
      );
    }
  } catch (e) {
    print("Error: $e");
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Error: $e")));
  }
}
