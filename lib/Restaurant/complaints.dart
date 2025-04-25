import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:dinebot/api/loginApi.dart'; // contains `lid`
import 'package:dinebot/api/registerApi.dart'; // contains `baseurl`

class ViewComplaintsScreen extends StatefulWidget {
  @override
  _ViewComplaintsScreenState createState() => _ViewComplaintsScreenState();
}

class _ViewComplaintsScreenState extends State<ViewComplaintsScreen> {
  List<dynamic> complaints = [];
  bool isLoading = true;

  final Dio _dio = Dio();
  final String apiUrl = '$baseurl/getcomplaintrest';

  @override
  void initState() {
    super.initState();
    fetchComplaints();
  }

  Future<void> fetchComplaints() async {
    try {
      final response = await _dio.get(apiUrl, data: {"lid": lid});
      print(response.data);
      if (response.statusCode == 200) {
        setState(() {
          complaints = response.data["complaints"];
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching complaints: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> sendReply(String complaintId, String reply) async {
    try {
      final response = await _dio.post(
        '$baseurl/updatereply',
        data: {'id': complaintId, 'reply': reply},
      );
      if (response.statusCode == 200) {
        print('Reply sent successfully!');
        fetchComplaints(); // Refresh
      }
    } catch (e) {
      print('Error sending reply: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complaints', style: GoogleFonts.poppins()),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.grey[900],
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: Colors.amber))
          : complaints.isEmpty
              ? Center(
                  child: Text(
                    'No complaints found',
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: complaints.length,
                  itemBuilder: (context, index) {
                    final complaint = complaints[index];
                    final complaintId = complaint['id'].toString();
                    final complaintText = complaint['complaint'];
                    final replyText = complaint['reply'];
                    final date = complaint['date'];
                    final orderId = complaint['order_id'];

                    final TextEditingController replyController =
                        TextEditingController();

                    return Card(
                      color: Colors.grey[850],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ExpansionTile(
                        title: Text(
                          "Order ID: $orderId",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: Colors.amber,
                          ),
                        ),
                        subtitle: Text(
                          'Date: $date',
                          style: GoogleFonts.poppins(color: Colors.white70),
                        ),
                        children: [
                          ListTile(
                            title: Text(
                              'Complaint:',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                color: Colors.amber,
                              ),
                            ),
                            subtitle: Text(
                              complaintText ?? 'No complaint provided',
                              style: GoogleFonts.poppins(color: Colors.white70),
                            ),
                          ),
                          if (replyText == null || replyText == "null")
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  TextField(
                                    controller: replyController,
                                    decoration: InputDecoration(
                                      hintText: 'Write your reply here...',
                                      filled: true,
                                      fillColor: Colors.white24,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  ElevatedButton(
                                    onPressed: () {
                                      if (replyController.text.isNotEmpty) {
                                        sendReply(
                                            complaintId, replyController.text);
                                      }
                                    },
                                    child: Text(
                                      'Send Reply',
                                      style: GoogleFonts.poppins(),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          else
                            ListTile(
                              title: Text(
                                'Your Reply:',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.greenAccent,
                                ),
                              ),
                              subtitle: Text(
                                replyText,
                                style: GoogleFonts.poppins(color: Colors.white70),
                              ),
                            )
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
