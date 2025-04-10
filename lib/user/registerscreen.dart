import 'package:dinebot/user/loginscreen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 135, 3, 3), // Warm red
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
                  logo(size.height / 5),
                  richText(26),
                  SizedBox(height: 10),
                  Text(
                    'Create an account to get started!',
                    style: GoogleFonts.inter(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: size.height / 18),
                  buildTextField(
                    size,
                    Icons.person,
                    'Enter your name',
                    controller: nameController,
                  ),
                  SizedBox(height: 10),
                  buildTextField(
                    size,
                    Icons.mail_rounded,
                    'Enter your email',
                    controller: emailController,
                  ),
                  SizedBox(height: 10),
                  buildTextField(
                    size,
                    Icons.lock,
                    'Enter your password',
                    controller: passController,
                    isPassword: true,
                  ),
                  SizedBox(height: 26),
                  signUpButton(size),
                  SizedBox(height: 16),
                  buildFooter(size),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget logo(double size) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(shape: BoxShape.circle),
      child: ClipOval(
        child: Image.network(
          'https://tse4.mm.bing.net/th?id=OIP.pkBZyWtynG5b-qRo4zDUVQHaHa&pid=Api&P=0&h=180',
          fit: BoxFit.cover,
        ),
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

  Widget buildTextField(
    Size size,
    IconData icon,
    String hint, {
    bool isPassword = false,
    TextEditingController? controller,
  }) {
    return Container(
      alignment: Alignment.center,
      height: size.height / 12,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: const Color(0xFF8B0000), // Darker red
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

  Widget signUpButton(Size size) {
    return InkWell(
      onTap: () {
        // Navigate to home after signup
      },
      child: Container(
        alignment: Alignment.center,
        height: size.height / 13,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: const Color(0xFFFFA500), // Warm orange button
        ),
        child: Text(
          'Sign Up',
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
              text: 'Already have an account? ',
              style: GoogleFonts.nunito(fontWeight: FontWeight.w600),
            ),
            TextSpan(
              recognizer:
                  TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
              text: 'Sign in',
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
