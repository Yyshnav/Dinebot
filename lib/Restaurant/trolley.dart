import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TrolleyControlScreen extends StatefulWidget {
  @override
  _TrolleyControlScreenState createState() => _TrolleyControlScreenState();
}

class _TrolleyControlScreenState extends State<TrolleyControlScreen> {
  String? selectedTable;
  List<String> tables = ['Table 1', 'Table 2', 'Table 3', 'Table 4'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/oo.jpeg', // Replace with your image
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            'Select Table',
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.amber,
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: DropdownButtonFormField<String>(
              value: selectedTable,
              dropdownColor: Colors.grey[900],
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[800],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(color: Colors.white),
              icon: Icon(Icons.arrow_drop_down, color: Colors.amber),
              items:
                  tables.map((table) {
                    return DropdownMenuItem(
                      value: table,
                      child: Text(
                        table,
                        style: GoogleFonts.inter(color: Colors.white),
                      ),
                    );
                  }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedTable = value;
                });
              },
            ),
          ),
          SizedBox(height: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              minimumSize: Size(200, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              // Add functionality here
            },
            child: Text(
              'Start',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
