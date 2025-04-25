import 'package:dinebot/api/loginApi.dart';
import 'package:dinebot/user/homescreen.dart';
import 'package:dinebot/user/registerscreen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 135, 3, 3),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: SizedBox(
            height: size.height,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: size.height / 12),
                  logo(size.height / 5, size.height / 5),
                  richText(26),
                  SizedBox(height: 10),
                  Text(
                    'Login to enjoy delicious food!',
                    style: GoogleFonts.inter(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: size.height / 18),
                  emailTextField(size),
                  SizedBox(height: 10),
                  passwordTextField(size),
                  SizedBox(height: 26),
                  signInButton(size),
                  SizedBox(height: 16),
                  buildFooter(size),
                  SizedBox(height: size.height / 18),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget logo(double height_, double width_) {
    return Container(
      height: height_,
      width: width_,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
      child: ClipOval(
        child: Image.asset('assets/resss.jpeg', fit: BoxFit.cover),
      ),
    );
  }

  Widget richText(double fontSize) {
    return Text(
      'DineBot',
      style: GoogleFonts.pacifico(
        fontSize: fontSize,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget emailTextField(Size size) {
    return buildTextField(
      size,
      Icons.mail_rounded,
      'Enter your username',
      controller: emailController,
    );
  }

  Widget passwordTextField(Size size) {
    return buildTextField(
      size,
      Icons.lock,
      'Enter your password',
      isPassword: true,
      controller: passController,
    );
  }

  Widget buildTextField(
    Size size,
    IconData icon,
    String hint, {
    bool isPassword = false,
    required TextEditingController controller,
  }) {
    return Container(
      alignment: Alignment.center,
      height: size.height / 12,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: const Color(0xFF8B0000),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(icon, color: Colors.white70),
            SizedBox(width: 16),
            Expanded(
              child: TextField(
                controller: controller,
                obscureText: isPassword ? _isObscure : false,
                cursorColor: Colors.white70,
                keyboardType:
                    isPassword
                        ? TextInputType.visiblePassword
                        : TextInputType.emailAddress,
                style: GoogleFonts.inter(
                  fontSize: 14.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: GoogleFonts.inter(
                    fontSize: 14.0,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                  ),
                  border: InputBorder.none,
                  suffixIcon:
                      isPassword
                          ? IconButton(
                            icon: Icon(
                              _isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.white70,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                          )
                          : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget signInButton(Size size) {
    return InkWell(
      onTap: () {
        loginApi(emailController.text, passController.text, context);
      },
      child: Container(
        alignment: Alignment.center,
        height: size.height / 13,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: const Color(0xFFFFA500),
        ),
        child: Text(
          'Sign in',
          style: GoogleFonts.inter(
            fontSize: 16.0,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget buildFooter(Size size) {
    return Align(
      alignment: Alignment.center,
      child: Text.rich(
        TextSpan(
          style: GoogleFonts.nunito(fontSize: 16.0, color: Colors.white),
          children: [
            TextSpan(
              text: 'Don’t have an account? ',
              style: GoogleFonts.nunito(fontWeight: FontWeight.w600),
            ),
            TextSpan(
              recognizer:
                  TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupPage()),
                      );
                    },
              text: 'Sign up',
              style: GoogleFonts.nunito(
                color: const Color(0xFFFFD700),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
