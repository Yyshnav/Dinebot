import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dinebot/api/loginApi.dart'; // for lid
import 'package:dinebot/api/registerApi.dart'; // for baseurl

class ComplaintScreen extends StatefulWidget {
  final String dishId; // Dish ID passed while navigating
  final String restid;

  ComplaintScreen({Key? key,required this.dishId, required this.restid}) : super(key: key);

  @override
  _ComplaintScreenState createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  TextEditingController complaintController = TextEditingController();
  List<dynamic> previousComplaints = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchComplaints();
  }

  Future<void> fetchComplaints() async {
    try {
      final response = await Dio().get(
        '$baseurl/sendcomplaint',data: {"lid": lid,},
       
      );
print(response);
      if (response.statusCode == 200 ) {
        setState(() {
          previousComplaints = response.data['complaints'];
          isLoading = false;
        });
      } else {
        setState(() {
          previousComplaints = [];
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching complaints: $e");
      setState(() {
        previousComplaints = [];
        isLoading = false;
      });
    }
  }

  Future<void> submitComplaint() async {
    if (complaintController.text.isNotEmpty) {
      try {
        final response = await Dio().post(
          '$baseurl/sendcomplaint',
          data: {
            'lid': lid,
            'orderid': widget.dishId,
            'complaint': complaintController.text,
            "rid":widget.restid,
          },
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Complaint submitted successfully!")),
          );
          complaintController.clear();
          fetchComplaints(); // Refresh list
        } else {
          throw Exception("Failed to submit complaint");
        }
      } catch (e) {
        print("Error submitting complaint: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Submission failed. Try again.")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter a complaint")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 135, 3, 3),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Submit Complaint",
          style: GoogleFonts.pacifico(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
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
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              onPressed: submitComplaint,
              child: Text(
                "Submit",
                style: GoogleFonts.inter(color: Colors.white),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              "Previous Complaints",
              style: GoogleFonts.inter(fontSize: 18, color: Colors.white),
            ),
            const SizedBox(height: 10),
            isLoading
                ? const CircularProgressIndicator()
                : previousComplaints.isEmpty
                    ? Text("No previous complaints", style: TextStyle(color: Colors.white70))
                    : Expanded(
                        child: ListView.builder(
                          itemCount: previousComplaints.length,
                          itemBuilder: (context, index) {
                            final item = previousComplaints[index];
                            return Card(
                              color: Colors.white10,
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              child: ListTile(
                                title: Text(
                                  item['complaint'] ?? 'No details',
                                  style: GoogleFonts.inter(color: Colors.white),
                                ),
                                subtitle: Column(mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['reply'] ?? 'yet to reply',
                                      style: TextStyle(color: Colors.white70),
                                    ),
                                    Text(
                                      item['date'] ?? '',
                                      style: TextStyle(color: Colors.white70),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
