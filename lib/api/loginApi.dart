import 'package:dinebot/Restaurant/homescreen.dart';
import 'package:dinebot/api/registerApi.dart';
import 'package:dinebot/user/homescreen.dart';
import 'package:dinebot/user/loginscreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? lid;
Future<void> loginApi(
  String email,
  String password,
  BuildContext context,
) async {
  final dio = Dio();
  try {
    final response = await dio.post(
      "$baseurl/logincheck",
      data: {"email": email, "password": password},
    );
    print(response);
    print(response.statusCode);
    if (response.statusCode == 201 || response.statusCode == 200) {
      String usertype = response.data["type"];
      lid = response.data["loginid"];

      // Save to shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', email);
      await prefs.setString('usertype', usertype);

      // Navigate based on usertype
      if (usertype == "user") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ), // Change this to actual UserHomeScreen
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => RestaurantHomeScreen()),
        );
      }
    } else {
      // Handle error responses
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login failed. Please try again.")),
      );
    }
  } catch (e) {
    print(e);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Something went wrong. Please try again. Check credentials")),
    );
  }
}
