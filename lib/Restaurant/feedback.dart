import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:dinebot/api/loginApi.dart'; // contains `lid`
import 'package:dinebot/api/registerApi.dart'; // contains `baseurl`

class FeedbackViewScreen extends StatefulWidget {
  @override
  _FeedbackViewScreenState createState() => _FeedbackViewScreenState();
}

class _FeedbackViewScreenState extends State<FeedbackViewScreen> {
  List<dynamic> feedbacks = [];
  bool isLoading = true;

  final Dio _dio = Dio();
  final String apiUrl = '$baseurl/getfeedback';

  @override
  void initState() {
    super.initState();
    fetchFeedbacks();
  }

  Future<void> fetchFeedbacks() async {
    try {
      final response = await _dio.get(apiUrl, data: {"lid": lid});
      print(response.data);
      if (response.statusCode == 200) {
        setState(() {
          feedbacks = response.data["feedbacks"];
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching feedbacks: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsIconTheme: IconThemeData(color: Colors.white),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Feedbacks', style: GoogleFonts.poppins(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.grey[900],
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: Colors.amber))
          : feedbacks.isEmpty
              ? Center(
                  child: Text(
                    'No feedbacks found',
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: feedbacks.length,
                  itemBuilder: (context, index) {
                    final feedback = feedbacks[index];
                    final feedbackText = feedback['feedback'];
                    final date = feedback['date'];
                    final int rating = int.tryParse(feedback['rating'].toString()) ?? 0;

                    return Card(
                      color: Colors.grey[850],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ExpansionTile(iconColor: Colors.white,collapsedIconColor: Colors.white,
                        title: Row(
                          children: [
                            Text(
                              "Rating: ",
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                color: Colors.amber,
                              ),
                            ),
                            ...List.generate(5, (index) {
                              return Icon(
                                index < rating ? Icons.star : Icons.star_border,
                                color: Colors.amber,
                              );
                            }),
                          ],
                        ),
                        subtitle: Text(
                          'Date: $date',
                          style: GoogleFonts.poppins(color: Colors.white70),
                        ),
                        children: [
                          ListTile(
                            title: Text(
                              'Feedback:',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                color: Colors.amber,
                              ),
                            ),
                            subtitle: Text(
                              feedbackText ?? 'No feedback provided',
                              style: GoogleFonts.poppins(color: Colors.white70),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
