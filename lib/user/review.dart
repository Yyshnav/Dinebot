import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReviewScreen extends StatefulWidget {
  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  String? selectedDish;
  double rating = 3;
  TextEditingController reviewController = TextEditingController();
  List<String> dishes = [
    "Margherita Pizza",
    "Cheese Burger",
    "Pasta Alfredo",
    "Biryani",
    "Tandoori Chicken",
  ];

  void submitReview() {
    if (selectedDish != null && reviewController.text.isNotEmpty) {
      print(
        "Review for $selectedDish: Rating - $rating, ${reviewController.text}",
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Review submitted successfully!",
            style: GoogleFonts.inter(color: Colors.white),
          ),
        ),
      );
      reviewController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 135, 3, 3),
      appBar: AppBar(
        title: Text(
          "Submit Review",
          style: GoogleFonts.pacifico(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 135, 3, 3),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   "Select Dish",
            //   style: GoogleFonts.inter(fontSize: 18, color: Colors.white),
            // ),
            // DropdownButton<String>(
            //   dropdownColor: Color.fromARGB(255, 50, 3, 3),
            //   value: selectedDish,
            //   isExpanded: true,
            //   hint: Text(
            //     "Choose a dish",
            //     style: GoogleFonts.inter(color: Colors.white),
            //   ),
            //   items:
            //       dishes.map((String dish) {
            //         return DropdownMenuItem<String>(
            //           value: dish,
            //           child: Text(
            //             dish,
            //             style: GoogleFonts.inter(color: Colors.white),
            //           ),
            //         );
            //       }).toList(),
            //   onChanged: (value) {
            //     setState(() {
            //       selectedDish = value;
            //     });
            //   },
            // ),
            SizedBox(height: 20),
            Text(
              "Rating",
              style: GoogleFonts.inter(fontSize: 18, color: Colors.white),
            ),
            Slider(
              value: rating,
              min: 1,
              max: 5,
              divisions: 4,
              label: rating.toString(),
              onChanged: (value) {
                setState(() {
                  rating = value;
                });
              },
            ),
            TextField(
              controller: reviewController,
              maxLines: 3,
              style: GoogleFonts.inter(color: Colors.white),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Write your review",
                hintStyle: GoogleFonts.inter(color: Colors.white70),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              onPressed: submitReview,
              child: Text(
                "Submit",
                style: GoogleFonts.inter(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
