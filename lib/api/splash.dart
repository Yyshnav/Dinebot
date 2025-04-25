import 'dart:async';

import 'package:dinebot/api/registerApi.dart';
import 'package:dinebot/user/togleloginui.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Ip extends StatefulWidget {
  const Ip({super.key});

  @override
  State<Ip> createState() => _IpState();
}

class _IpState extends State<Ip> {
  final TextEditingController _ipController = TextEditingController();
  bool _isLoading = false;

  Future<void> _saveAndNavigate() async {
    final prefs = await SharedPreferences.getInstance();
    String ip = _ipController.text.trim();

    if (ip.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter IP address")),
      );
      return;
    }

    setState(() => _isLoading = true);

     baseurl = 'http://$ip:5000'; // or use port of your choice
 

    await Future.delayed(const Duration(seconds: 1)); // Optional short delay

        Navigator.push(context, MaterialPageRoute(builder: (context) => ToggleLoginPage(),));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 135, 3, 3), // Deep Red
              Colors.black, // Black
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: _isLoading
              ? const CircularProgressIndicator(color: Colors.amber)
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text(
                      'DineBot',
                      style: GoogleFonts.pacifico(
                       fontSize: 36,
                        fontWeight: FontWeight.bold,
                      color: Colors.white,letterSpacing: 2
                    ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Enter Server IP Address',
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _ipController,
                      keyboardType: TextInputType.url,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white12,
                        hintText: 'e.g., 192.168.1.100',
                        hintStyle: const TextStyle(color: Colors.white54),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _saveAndNavigate,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
