import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewCartScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  const ViewCartScreen({Key? key, required this.cartItems}) : super(key: key);

  @override
  _ViewCartScreenState createState() => _ViewCartScreenState();
}

class _ViewCartScreenState extends State<ViewCartScreen> {
  String selectedTable = "Table 1";
  final List<String> tables = ["Table 1", "Table 2", "Table 3", "Table 4"];

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
                          return Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              leading: Image.network(
                                item["image"],
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                              title: Text(
                                item["name"],
                                style: GoogleFonts.inter(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                "₹${item["price"]} x ${item["quantity"]}",
                                style: GoogleFonts.inter(fontSize: 16),
                              ),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  setState(() {
                                    widget.cartItems.removeAt(index);
                                  });
                                },
                              ),
                            ),
                          );
                        },
                      ),
            ),
            const SizedBox(height: 10),

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
                      : () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Order placed successfully for $selectedTable!",
                            ),
                            backgroundColor: Colors.green,
                          ),
                        );
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
