import 'package:dinebot/api/registerApi.dart';
import 'package:dinebot/user/appfeedbck.dart';
import 'package:dinebot/user/complaintscreen.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:dinebot/api/loginApi.dart'; // Assumes you have lid and baseurl here

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<dynamic> _historyItems = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    fetchOrderHistory();
  }

  Future<void> fetchOrderHistory() async {
    try {
      final response = await Dio().get(
        '$baseurl/order_history',
        data: {'user_id': lid},
      );

      print("API Response: ${response}");

      if (response.statusCode == 200 && response.data != null) {
        setState(() {
          _historyItems = List.from(response.data);
          _isLoading = false;
        });
      } else {
        setState(() {
          _error = 'No history found';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'API Error: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 135, 3, 3),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Text(
                    _error!,
                    style: const TextStyle(color: Colors.white),
                  ),
                )
              : _historyItems.isEmpty
                  ? const Center(
                      child: Text(
                        'No order history found',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _historyItems.length,
                      itemBuilder: (context, index) {
                        final order = _historyItems[index];
                        final dishes = order['dishes'] as List<dynamic>;
                        final orderDetails = order['orderdetails'];
                        final orderId = orderDetails['request_id'];
                        final restID = orderDetails['rest_id'];

                        return Card(
                          margin: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 12,
                          ),
                          child: ExpansionTile(
                            title: Text("Order ID: $orderId"),
                            subtitle: Text(
                              "Date: ${orderDetails['date']} • Time: ${orderDetails['time']}",
                            ),
                            children: [
                              ...dishes.map((dish) {
                                return ListTile(
                                  leading: Image.network(
                                    '$baseurl/static/${dish['image']}',
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) =>
                                        const Icon(Icons.image),
                                  ),
                                  title: Text(dish['name']),
                                  subtitle: Text(dish['description']),
                                  trailing: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: dish['status'] == 'Accepted'
                                          ? Colors.green
                                          : Colors.orange,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      dish['status'],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                  vertical: 8.0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ApplicationFeedbackScreen(
                                              restid: restID.toString(),
                                            ),
                                          ),
                                        );
                                      },
                                      icon: const Icon(Icons.feedback),
                                      label: const Text("Feedback"),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                      ),
                                    ),
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ComplaintScreen(
                                              dishId: orderId.toString(),
                                              restid: restID,
                                            ),
                                          ),
                                        );
                                      },
                                      icon: const Icon(Icons.report_problem),
                                      label: const Text("Complaint"),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                      ),
                                    ),
                                  ],
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
