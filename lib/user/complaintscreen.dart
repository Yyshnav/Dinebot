import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ComplaintScreen extends StatefulWidget {
  @override
  _ComplaintScreenState createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  String? selectedDish;
  TextEditingController complaintController = TextEditingController();
  List<String> dishes = [
    "Margherita Pizza",
    "Cheese Burger",
    "Pasta Alfredo",
    "Biryani",
    "Tandoori Chicken",
  ];

  void submitComplaint() {
    if (selectedDish != null && complaintController.text.isNotEmpty) {
      print("Complaint for $selectedDish: ${complaintController.text}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Complaint submitted successfully!")),
      );
      complaintController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 135, 3, 3),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Submit Complaint",
          style: GoogleFonts.pacifico(color: Colors.white),
        ),
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
            //   dropdownColor: Colors.black,
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
            TextField(
              controller: complaintController,
              maxLines: 3,
              style: GoogleFonts.inter(color: Colors.white),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter your complaint",
                hintStyle: GoogleFonts.inter(color: Colors.white70),
                filled: true,
                fillColor: Colors.black38,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              onPressed: submitComplaint,
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
