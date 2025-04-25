import 'package:dinebot/api/loginApi.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dinebot/api/registerApi.dart'; // Make sure your baseurl is defined here

class ViewAllOrdersScreen extends StatefulWidget {
  @override
  _ViewAllOrdersScreenState createState() => _ViewAllOrdersScreenState();
}

class _ViewAllOrdersScreenState extends State<ViewAllOrdersScreen> {
  List<dynamic> orders = [];
  bool isLoading = true;

  final Dio _dio = Dio();
  final String apiUrl =
      '$baseurl/orders?rest_id=$lid'; // Replace with your actual endpoint

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    try {
      final response = await _dio.get(apiUrl);
      print(response);
      if (response.statusCode == 200) {
        setState(() {
          orders = response.data;
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching orders: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  // Accept order function
  Future<void> acceptOrder(int requestId) async {
    try {
      final response = await _dio.post(
        '$baseurl/accept_order',
        data: {'request_id': requestId},
      );
      if (response.statusCode == 200) {
        print('Order accepted');
        fetchOrders(); // Re-fetch orders after accepting
      }
    } catch (e) {
      print('Error accepting order: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Orders', style: GoogleFonts.poppins()),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.grey[900],
      body:
          isLoading
              ? Center(child: CircularProgressIndicator(color: Colors.amber))
              : orders.isEmpty
              ? Center(
                child: Text(
                  'No orders found',
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
              )
              : ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];

                  return Card(
                    color: Colors.grey[850],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Table ID: ${order['table_id'] ?? ''}',
                            style: GoogleFonts.poppins(
                              color: Colors.amber,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Date: ${order['date'] ?? ''}',
                            style: GoogleFonts.poppins(color: Colors.white70),
                          ),
                          Text(
                            'Time: ${order['time'] ?? ''}',
                            style: GoogleFonts.poppins(color: Colors.white70),
                          ),
                          Text(
                            'Dish Name: ${order['name'] ?? ''}',
                            style: GoogleFonts.poppins(
                              color: Colors.red,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Description: ${order['description'] ?? ''}',
                            style: GoogleFonts.poppins(color: Colors.white70),
                          ),
                          Text(
                            'Price: ₹${order['price'] ?? ''}',
                            style: GoogleFonts.poppins(color: Colors.white70),
                          ),
                          Text(
                            'Status: ${order['status'] ?? ''}',
                            style: GoogleFonts.poppins(color: Colors.white70),
                          ),

                          // Image Display with Tap for Fullscreen
                          SizedBox(height: 10),
                          order['image'] != null
                              ? GestureDetector(
                                onTap: () {
                                  // Open image in fullscreen
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => FullScreenImageView(
                                            imageUrl:
                                                '$baseurl/static/${order['image']}',
                                          ),
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Image.network(
                                      '$baseurl/static/${order['image']}',
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),SizedBox(width: 10,),
                                    Text(
                                      'Click to view',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              : Container(),

                          // Accept Button only if the status is not "Accepted"
                          SizedBox(height: 10),
                          order['status'] != 'Accepted'
                              ? ElevatedButton(
                                onPressed: () {
                                  acceptOrder(order['request_id']);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.amber,
                                ),
                                child: Text(
                                  'Accept Order',
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                  ),
                                ),
                              )
                              : Container(), // Hide the button if status is "Accepted"
                        ],
                      ),
                    ),
                  );
                },
              ),
    );
  }
}

class FullScreenImageView extends StatelessWidget {
  final String imageUrl;

  FullScreenImageView({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.network(
            imageUrl,
            fit: BoxFit.contain,
            height: double.infinity,
            width: double.infinity,
          ),
        ),
      ),
    );
  }
}
