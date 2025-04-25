import 'package:dinebot/user/addtocart.dart';
import 'package:dinebot/user/cartscreen.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:dio/dio.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:developer' as developer;
import 'dart:convert'; // Added for JSON parsing
import 'package:dinebot/api/registerApi.dart'; // Ensure baseurl is defined here

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  MobileScannerController controller = MobileScannerController(
    formats: [BarcodeFormat.qrCode], // Restrict to QR codes
  );
  bool hasScanned = false;
  // final String baseurl = 'your_base_url_here'; // Replace with actual base URL from registerApi.dart

  void _onDetect(BarcodeCapture capture) async {
    final List<Barcode> barcodes = capture.barcodes;
    if (!hasScanned && barcodes.isNotEmpty && barcodes.first.rawValue != null) {
      final String code = barcodes.first.rawValue!;
      developer.log("Scanned QR Code: $code");

      try {
        // Parse QR code JSON
        final Map<String, dynamic> qrData = jsonDecode(code);
        final int restaurantId = qrData['restaurant_id'];
        final int tableId = qrData['table_id'];
        developer.log("Parsed: restaurant_id=$restaurantId, table_id=$tableId");

        setState(() {
          hasScanned = true;
        });

        // Make API call with restaurant_id and table_id
        final dio = Dio();
        final response = await dio.get(
          '$baseurl/viewdishesbyrest?rest_id=$restaurantId&table_id=$tableId',
        );
        final List<dynamic> dishesData = response.data['dishes'];

        print('=================>>>>>${response.data}');
        developer.log("Dishes Data: $dishesData");
        if (mounted) {
          controller.stop();
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => DishListScreen(
                    dishes: dishesData,
                    restaurantId: restaurantId,
                    tableId: tableId,
                  ),
            ),
          );
          setState(() {
            hasScanned = false; // Reset after navigation
          });
        }
      } catch (e) {
        developer.log("Error: $e");
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Failed to load dishes: $e')));
        }
        setState(() {
          hasScanned = false;
        });
      }
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 135, 3, 3),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 135, 3, 3),
        title: Text(
          "Scan QR Code",
          style: GoogleFonts.pacifico(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Stack(
              children: [
                MobileScanner(controller: controller, onDetect: _onDetect),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.orange, width: 10),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Expanded(
            child: Center(
              child: Text(
                'Point camera at QR code',
                style: TextStyle(color: Colors.white, fontFamily: 'Inter'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DishListScreen extends StatefulWidget {
  final List<dynamic> dishes;
  final int restaurantId;
  final int tableId;

  const DishListScreen({
    Key? key,
    required this.dishes,
    required this.restaurantId,
    required this.tableId,
  }) : super(key: key);

  @override
  State<DishListScreen> createState() => _DishListScreenState();
}

class _DishListScreenState extends State<DishListScreen> {
  late List<int> quantities;
  List<Map<String, dynamic>> cartItems = [];

  @override
  void initState() {
    super.initState();
    quantities = List<int>.filled(widget.dishes.length, 1); // default qty = 1
  }

  void increment(int index) {
    setState(() {
      quantities[index]++;
    });
  }

  void decrement(int index) {
    if (quantities[index] > 1) {
      setState(() {
        quantities[index]--;
      });
    }
  }

  void addToCart(int index) {
    final dish = widget.dishes[index];

    final cartItem = {
      'id': dish['id'],
      'name': dish['name'],
      'price': dish['price'],
      'quantity': quantities[index],
      'image': dish['image'],
    };

    // Check if already in cart
    final existingIndex = cartItems.indexWhere(
      (item) => item['id'] == dish['id'],
    );

    setState(() {
      if (existingIndex != -1) {
        cartItems[existingIndex]['quantity'] += quantities[index];
      } else {
        cartItems.add(cartItem);
      }
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Added to cart')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 135, 3, 3),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 135, 3, 3),
        title: Text("Dishes", style: GoogleFonts.pacifico(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: widget.dishes.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            final dish = widget.dishes[index];

            return GestureDetector(onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddToCartScreen(dish: dish),
      ),
    );
  },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(10),
                        ),
                        child: Image.network(
                          dish['image'] != null
                              ? '$baseurl/static/${dish['image']}'
                              : '',
                          fit: BoxFit.cover,
                          errorBuilder:
                              (context, error, stackTrace) => const Center(
                                child: Icon(Icons.image_not_supported),
                              ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dish['name'] ?? 'Unnamed',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            dish['price'] != null
                                ? "₹${dish['price'].toString().replaceFirst('\$', '')}"
                                : '₹N/A',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () => decrement(index),
                                icon: const Icon(Icons.remove_circle_outline),
                              ),
                              Text(
                                '${quantities[index]}',
                                style: GoogleFonts.inter(fontSize: 16),
                              ),
                              IconButton(
                                onPressed: () => increment(index),
                                icon: const Icon(Icons.add_circle_outline),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () => addToCart(index),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                            ),
                            child: Text(
                              "Add to Cart",
                              style: GoogleFonts.inter(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar:
          cartItems.isNotEmpty
              ? Container(
                padding: const EdgeInsets.all(10),
                color: Colors.white,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => ViewCartScreen(
                              cartItems: cartItems,
                              tableid: widget.tableId.toString(),
                              restid: widget.restaurantId.toString(),
                            ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Go to Cart (${cartItems.length})",
                    style: GoogleFonts.inter(fontSize: 18, color: Colors.white),
                  ),
                ),
              )
              : null,
    );
  }
}
