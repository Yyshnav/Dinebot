import 'package:dinebot/Restaurant/homescreen.dart';
import 'package:dinebot/api/loginApi.dart';
import 'package:dinebot/user/homescreen.dart';
import 'package:dinebot/user/registerscreen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RestaurantLoginPage extends StatefulWidget {
  const RestaurantLoginPage({Key? key}) : super(key: key);

  @override
  State<RestaurantLoginPage> createState() => _RestaurantLoginPageState();
}

class _RestaurantLoginPageState extends State<RestaurantLoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage('assets/restsnt.jpeg'),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Restaurant Panel',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber,
                    ),
                  ),
                  SizedBox(height: 40),
                  buildTextField(
                    Icons.email,
                    'Enter your username',
                    false,
                    emailController,
                  ),
                  SizedBox(height: 20),
                  buildTextField(
                    Icons.lock,
                    'Enter your password',
                    true,
                    passController,
                  ),
                  SizedBox(height: 30),
                  loginButton(),
                  SizedBox(height: 20),
                  // buildFooter(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
    IconData icon,
    String hint,
    bool isPassword,
    TextEditingController controller,
  ) {
    return TextField(
      controller: controller, // Add the controller here
      obscureText: isPassword ? _isObscure : false,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.amber),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[400]),
        filled: true,
        fillColor: Colors.grey[900],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        suffixIcon:
            isPassword
                ? IconButton(
                  icon: Icon(
                    _isObscure ? Icons.visibility_off : Icons.visibility,
                    color: Colors.amber,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                )
                : null,
      ),
    );
  }

  Widget loginButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.amber,
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: () {
        loginApi(emailController.text, passController.text, context);
      },
      child: Text(
        'Login',
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget buildFooter() {
    return Text.rich(
      TextSpan(
        text: "Don't have an account? ",
        style: TextStyle(color: Colors.white),
        children: [
          TextSpan(
            text: 'Sign up',
            style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
            recognizer:
                TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupPage()),
                    );
                  },
          ),
        ],
      ),
    );
  }
}
