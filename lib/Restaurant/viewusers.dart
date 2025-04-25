import 'package:dinebot/api/registerApi.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewAllUsersScreen extends StatefulWidget {
  @override
  _ViewAllUsersScreenState createState() => _ViewAllUsersScreenState();
}

class _ViewAllUsersScreenState extends State<ViewAllUsersScreen> {
  List<dynamic> users = [];
  bool isLoading = true;

  final Dio _dio = Dio();
  final String apiUrl =
      '$baseurl/viewusers'; // 🔁 Replace with your real endpoint

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      final response = await _dio.get(apiUrl);
      if (response.statusCode == 200) {
        setState(() {
          users = response.data;
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching users: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Users', style: GoogleFonts.poppins()),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.grey[900],
      body:
          isLoading
              ? Center(child: CircularProgressIndicator(color: Colors.amber))
              : users.isEmpty
              ? Center(
                child: Text(
                  'No users found',
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
              )
              : ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return Card(
                    color: Colors.grey[850],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      title: Text(
                        user['name'] ?? 'No Name',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: Colors.amber,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user['email'] ?? '',
                            style: GoogleFonts.poppins(color: Colors.white70),
                          ),
                          Text(
                            user['phone'] ?? '',
                            style: GoogleFonts.poppins(color: Colors.white70),
                          ),
                        ],
                      ),
                      trailing: Icon(Icons.person, color: Colors.white),
                    ),
                  );
                },
              ),
    );
  }
}
