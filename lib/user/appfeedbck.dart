import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ApplicationFeedbackScreen extends StatefulWidget {
  @override
  _ApplicationFeedbackScreenState createState() =>
      _ApplicationFeedbackScreenState();
}

class _ApplicationFeedbackScreenState extends State<ApplicationFeedbackScreen> {
  double rating = 3;
  TextEditingController feedbackController = TextEditingController();

  void submitFeedback() {
    if (feedbackController.text.isNotEmpty) {
      print("App Feedback: Rating - $rating, ${feedbackController.text}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Application feedback submitted successfully!")),
      );
      feedbackController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 135, 3, 3),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 135, 3, 3),
        title: Text(
          "Application Feedback",
          style: GoogleFonts.pacifico(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Rate the App",
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
                hintText: "Write your feedback...",
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
