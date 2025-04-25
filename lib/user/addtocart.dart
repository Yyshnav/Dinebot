import 'package:dinebot/api/registerApi.dart'; // Ensure this contains baseurl
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddToCartScreen extends StatelessWidget {
  final Map<String, dynamic> dish;

  const AddToCartScreen({Key? key, required this.dish}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 135, 3, 3),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 135, 3, 3),
        title: Text(
          "Dish Details",
          style: GoogleFonts.pacifico(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 100),
              // Dish Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  '$baseurl/static/${dish["image"]!}',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),

              // Dish Name
              Text(
                dish["name"]!,
                style: GoogleFonts.inter(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),

              // Dish Price
              Text(
                "₹${dish["price"]!.replaceAll('\$', '')}",
                style: GoogleFonts.inter(
                  fontSize: 20,
                  color: Colors.greenAccent,
                ),
              ),
              const SizedBox(height: 12),

              // Dish Description
              Text(
                'Description: ${dish["description"]!}',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(fontSize: 16, color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
