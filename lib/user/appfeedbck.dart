import 'package:dinebot/api/loginApi.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dio/dio.dart';
import 'package:dinebot/api/registerApi.dart'; // make sure this has your baseurl

class ApplicationFeedbackScreen extends StatefulWidget {
  final String restid;
  

  ApplicationFeedbackScreen({required this.restid,});

  @override
  _ApplicationFeedbackScreenState createState() =>
      _ApplicationFeedbackScreenState();
}

class _ApplicationFeedbackScreenState extends State<ApplicationFeedbackScreen> {
  double rating = 3;
  TextEditingController feedbackController = TextEditingController();
  final Dio _dio = Dio();

  void submitFeedback() async {
    final String complaintApiUrl = '$baseurl/postfeedback';

    if (feedbackController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please write your feedback before submitting.")),
      );
      return;
    }

    try {
      final response = await _dio.post(complaintApiUrl, data: {
        "rid": widget.restid,
        "lid": lid,
        "feedback": feedbackController.text,
        "rating": rating.toInt(), // optional, based on your backend
      });

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Feedback/complaint submitted successfully!")),
        );
        feedbackController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Something went wrong. Try again.")),
        );
      }
    } catch (e) {
      print("Error submitting feedback: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Network error. Please try again.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 135, 3, 3),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 135, 3, 3),
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
            Text(
              "Rate the Experience",
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
              controller: feedbackController,
              maxLines: 3,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Write your complaint here...",
                hintStyle: TextStyle(color: Colors.white70),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              onPressed: submitFeedback,
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
