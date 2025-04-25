// import 'package:dinebot/api/registerApi.dart';
// import 'package:dinebot/user/bill.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class ViewCartScreen extends StatefulWidget {
//   final List<Map<String, dynamic>> cartItems;

//   const ViewCartScreen({Key? key, required this.cartItems}) : super(key: key);

//   @override
//   _ViewCartScreenState createState() => _ViewCartScreenState();
// }

// class _ViewCartScreenState extends State<ViewCartScreen> {
//   String selectedTable = "Table 1";
//   final List<String> tables = ["Table 1", "Table 2", "Table 3", "Table 4"];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 135, 3, 3),
//       appBar: AppBar(
//         title: Text(
//           "Your Cart",
//           style: GoogleFonts.pacifico(color: Colors.white),
//         ),
//         backgroundColor: const Color.fromARGB(255, 135, 3, 3),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // Table Selection Grid
//             Text(
//               "Select Your Table",
//               style: GoogleFonts.inter(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//             const SizedBox(height: 10),
//             Wrap(
//               spacing: 10,
//               children:
//                   tables.map((table) {
//                     return GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           selectedTable = table;
//                         });
//                       },
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 20,
//                           vertical: 12,
//                         ),
//                         decoration: BoxDecoration(
//                           color:
//                               selectedTable == table
//                                   ? Colors.orange
//                                   : Colors.white,
//                           borderRadius: BorderRadius.circular(10),
//                           border: Border.all(color: Colors.orange, width: 2),
//                         ),
//                         child: Text(
//                           table,
//                           style: GoogleFonts.inter(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color:
//                                 selectedTable == table
//                                     ? Colors.white
//                                     : Colors.black,
//                           ),
//                         ),
//                       ),
//                     );
//                   }).toList(),
//             ),
//             const SizedBox(height: 20),

//             // Cart Items List
//             Expanded(
//               child:
//                   widget.cartItems.isEmpty
//                       ? Center(
//                         child: Text(
//                           "Your cart is empty!",
//                           style: GoogleFonts.inter(
//                             fontSize: 18,
//                             color: Colors.white70,
//                           ),
//                         ),
//                       )
//                       : ListView.builder(
//                         itemCount: widget.cartItems.length,
//                         itemBuilder: (context, index) {
//                           var item = widget.cartItems[index];
//                           return Card(
//                             color: Colors.white,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             margin: const EdgeInsets.symmetric(vertical: 8),
//                             child: ListTile(
//                               leading: Image.network(
//                                 '$baseurl/static/${item["image"]}',
//                                 width: 80,
//                                 height: 80,
//                                 fit: BoxFit.cover,
//                               ),
//                               title: Text(
//                                 item["name"],
//                                 style: GoogleFonts.inter(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               subtitle: Text(
//                                 "₹${item["price"]} x ${item["quantity"]}",
//                                 style: GoogleFonts.inter(fontSize: 16),
//                               ),
//                               trailing: IconButton(
//                                 icon: const Icon(
//                                   Icons.delete,
//                                   color: Colors.red,
//                                 ),
//                                 onPressed: () {
//                                   setState(() {
//                                     widget.cartItems.removeAt(index);
//                                   });
//                                 },
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//             ),
//             const SizedBox(height: 10),

//             // Place Order Button
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.orange,
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 50,
//                   vertical: 15,
//                 ),
//               ),
//               onPressed:
//                   widget.cartItems.isEmpty
//                       ? null
//                       : () {  Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => TotalBillScreen(cartItems: widget.cartItems,),
//                   ),
//                 );
//                         // ScaffoldMessenger.of(context).showSnackBar(
//                         //   SnackBar(
//                         //     content: Text(
//                         //       "Order placed successfully for $selectedTable!",
//                         //     ),
//                         //     backgroundColor: Colors.green,
//                         //   ),
//                         // );
//                       },
//               child: Text(
//                 "Place Order",
//                 style: GoogleFonts.inter(fontSize: 18, color: Colors.white),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:dinebot/api/loginApi.dart';
import 'package:dinebot/api/registerApi.dart';
import 'package:dinebot/user/homescreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewCartScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final String tableid;
  final String restid;

  const ViewCartScreen({Key? key, required this.cartItems, required this.tableid, required this.restid}) : super(key: key);

  @override
  _ViewCartScreenState createState() => _ViewCartScreenState();
}

class _ViewCartScreenState extends State<ViewCartScreen> {
  String selectedTable = "Table 1";
  final List<String> tables = ["Table 1", "Table 2", "Table 3", "Table 4"];

  double getTotalBill() {
    double total = 0.0;
    for (var item in widget.cartItems) {
      String priceString = item["price"].toString().replaceAll("\$", '');
      double price = double.tryParse(priceString.toString()) ?? 0.0;
      int quantity = item["quantity"] ?? 1;
      total += price * quantity;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 135, 3, 3),
      appBar: AppBar(
        title: Text(
          "Your Cart",
          style: GoogleFonts.pacifico(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 135, 3, 3),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Table Selection Grid
            Text(
              "Select Your Table",
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children:
                  tables.map((table) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTable = table;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color:
                              selectedTable == table
                                  ? Colors.orange
                                  : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.orange, width: 2),
                        ),
                        child: Text(
                          table,
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color:
                                selectedTable == table
                                    ? Colors.white
                                    : Colors.black,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
            ),
            const SizedBox(height: 20),

            // Cart Items List
            Expanded(
              child:
                  widget.cartItems.isEmpty
                      ? Center(
                        child: Text(
                          "Your cart is empty!",
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            color: Colors.white70,
                          ),
                        ),
                      )
                      : ListView.builder(
                        itemCount: widget.cartItems.length,
                        itemBuilder: (context, index) {
                          var item = widget.cartItems[index];
                          // Inside ListView.builder
                          return Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  // Image
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      '$baseurl/static/${item["image"]}',
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 12),

                                  // Item Info
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item["name"],
                                          style: GoogleFonts.inter(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          "${item["price"].replaceAll('\$', '₹')} x ${item["quantity"]}",
                                          style: GoogleFonts.inter(
                                            fontSize: 16,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Delete Icon
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        widget.cartItems.removeAt(index);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
            ),
            const Divider(thickness: 2, color: Colors.white),
            const SizedBox(height: 10),

            // Total Bill
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Bill:",
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "₹${getTotalBill().toStringAsFixed(2)}",
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Place Order Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 15,
                ),
              ),
              onPressed:
                  widget.cartItems.isEmpty
                      ? null
                      : () async {
                        await placeOrderApi(
                          items: widget.cartItems,
                          context: context, tableid: widget.tableid, restid: widget.restid,
                          
                        );

                        // You can show a SnackBar or navigate to another page
                      },

              child: Text(
                "Place Order",
                style: GoogleFonts.inter(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final Dio dio = Dio();

Future<void> placeOrderApi({
  required List<Map<String, dynamic>> items,
  required BuildContext context,
required  tableid,required restid
}) async {
  String url = '$baseurl/requests'; // Replace with your actual endpoint
  print(items);
  try {
    final response = await dio.post(
      url,
      data: {
        "user_id": lid,
         "table_id":tableid ,
          "restaurant_id": restid,
      "items":
            items.map((item) {
              return {
                "dish_id": item["id"],
               
               
              };
            }).toList(),
      },
    );

    if (response.statusCode == 200) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
      print("Order placed successfully: ${response.data}");
    } else {
      print("Failed to place order: ${response.statusCode}");
    }
  } catch (e) {
    print("Error placing order: $e");
  }
}
