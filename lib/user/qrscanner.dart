import 'dart:math';
import 'package:dinebot/user/addtocart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// QR Scanner Screen
class QRScannerScreen extends StatefulWidget {
  @override
  _QRScannerScreenState createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  List<Map<String, String>> dishes = [
    {
      "name": "Margherita Pizza",
      "image":
          "https://tse4.mm.bing.net/th?id=OIP.bpTjPj8xV2o5bYYaSxClsAHaDk&pid=Api&P=0&h=180",
      "price": "\12.99",
    },
    {
      "name": "Cheese Burger",
      "image":
          "https://tse4.mm.bing.net/th?id=OIP.bpTjPj8xV2o5bYYaSxClsAHaDk&pid=Api&P=0&h=180",
      "price": "\8.99",
      "description":
          "Classic Italian pizza with fresh tomatoes, mozzarella, and basil.",
    },
    {
      "name": "Pasta Alfredo",
      "image":
          "https://tse4.mm.bing.net/th?id=OIP.bpTjPj8xV2o5bYYaSxClsAHaDk&pid=Api&P=0&h=180",
      "price": "\10.99",
      "description":
          "Classic Italian pizza with fresh tomatoes, mozzarella, and basil.",
    },
    {
      "name": "Biryani",
      "image":
          "https://tse4.mm.bing.net/th?id=OIP._9tb05XgOcjjfMnXk3Mi_wHaE6&pid=Api&P=0&h=180",
      "price": "\14.99",
      "description":
          "Classic Italian pizza with fresh tomatoes, mozzarella, and basil.",
    },
    {
      "name": "Tandoori Chicken",
      "image":
          "https://tse1.mm.bing.net/th?id=OIP.3eehDwIFNFsHBtBhJADJuwHaE7&pid=Api&P=0&h=180",
      "price": "\15.99",
      "description":
          "Classic Italian pizza with fresh tomatoes, mozzarella, and basil.",
    },
  ];

  void _simulateQRScan() {
    final random = Random();
    final scannedDish = dishes[random.nextInt(dishes.length)];
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DishListScreen(scannedDish: scannedDish),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), _simulateQRScan);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 135, 3, 3),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 135, 3, 3),
        title: Text(
          "Scan QR Code",
          style: GoogleFonts.pacifico(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.qr_code_scanner, size: 100, color: Colors.white),
            SizedBox(height: 20),
            Text(
              "Scanning...",
              style: GoogleFonts.inter(fontSize: 20, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class DishListScreen extends StatelessWidget {
  final Map<String, String> scannedDish;

  const DishListScreen({Key? key, required this.scannedDish}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> allDishes = [
      {
        "name": "Margherita Pizza",
        "image":
            "https://tse3.mm.bing.net/th?id=OIP.gGCX2HgTshac2wA3O7QesAHaE8&pid=Api&P=0&h=180",
        "price": "12.99",
        "description":
            "Classic Italian pizza with fresh tomatoes, mozzarella, and basil.",
      },
      {
        "name": "Cheese Burger",
        "image":
            "https://tse3.mm.bing.net/th?id=OIP.gGCX2HgTshac2wA3O7QesAHaE8&pid=Api&P=0&h=180",
        "price": "\8.99",
        "description":
            "Classic Italian pizza with fresh tomatoes, mozzarella, and basil.",
      },
      {
        "name": "Pasta Alfredo",
        "image":
            "https://tse3.mm.bing.net/th?id=OIP.E1DJzIqHPi-X8rMmKcoGzwHaFj&pid=Api&P=0&h=180",
        "price": "\10.99",
        "description":
            "Classic Italian pizza with fresh tomatoes, mozzarella, and basil.",
      },
      {
        "name": "Tandoori Chicken",
        "image":
            "https://tse4.mm.bing.net/th?id=OIP.6wDj0ZeAkeDeTxLcIdNHxwHaHM&pid=Api&P=0&h=180",
        "price": "\15.99",
        "description":
            "Classic Italian pizza with fresh tomatoes, mozzarella, and basil.",
      },
    ];

    // Ensure only 5 dishes are displayed, including the scanned dish
    List<Map<String, String>> dishes = allDishes;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 135, 3, 3),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 135, 3, 3),
        title: Text("Dishes", style: GoogleFonts.pacifico(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: dishes.length, // Ensure exactly 5 items
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            var dish = dishes[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(10),
                      ),
                      child: Image.network(dish["image"]!, fit: BoxFit.cover),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dish["name"]!,
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 5),
                        Text(
                          "₹${dish["price"]!}",
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(height: 5),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                          ),
                          onPressed:
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => AddToCartScreen(dish: dish),
                                ),
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
            );
          },
        ),
      ),
    );
  }
}
