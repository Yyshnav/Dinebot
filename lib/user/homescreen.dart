import 'package:dinebot/user/appfeedbck.dart';
import 'package:dinebot/user/complaintscreen.dart';
import 'package:dinebot/user/history.dart';
import 'package:dinebot/user/qrscanner.dart';

import 'package:dinebot/user/review.dart';
import 'package:dinebot/user/togleloginui.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
final  List<Widget> _screens = [
      seconfScreen(),
          HistoryScreen(),
  ];  

  void _scanQRCode() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QRScannerScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(
        255,
        135,
        3,
        3,
      ), // Same red background
      appBar: AppBar(
        actions: [PopupMenuButton(itemBuilder: (context) => 
      [
        PopupMenuItem(
          value: 'logout',
          child: Text('Logout'),
        ),
      ],
      onSelected: (value) {
        if (value == 'logout') {
          // Handle logout logic here
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ToggleLoginPage(),), (Route)=>false);
        }
      },
      icon: Icon(Icons.more_vert_outlined,color: Colors.white,),
      )],
        automaticallyImplyLeading: false,
        title: Text(
          'DineBot',
          style: GoogleFonts.pacifico(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 135, 3, 3),
        centerTitle: true,
      ),
      // body: IndexedStack(
      //   index: _selectedIndex,
      //   children: [
      //     _buildDishesScreen(),
      //     HistoryScreen(),
         
      //   ],
      // ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: 'Dishes',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Order History'),
                 ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        backgroundColor: Color.fromARGB(255, 135, 3, 3),
        onTap: _onItemTapped,
      ),
      floatingActionButton:
          _selectedIndex == 0
              ? FloatingActionButton(
                onPressed: _scanQRCode,tooltip: "Scan QR Code",
                backgroundColor: Colors.orange,
                child: const Icon(Icons.qr_code_scanner, color: Colors.white),
              )
              : null,
    );
  }
}
class seconfScreen extends StatelessWidget {
  const seconfScreen({super.key});

  @override
  

  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Scan to View Dishes ',
        style: GoogleFonts.inter(fontSize: 20, color: Colors.white),
      ),
    );
  }}

  //   Widget _buildCartScreen() {
  //     return Center(
  //       child: ElevatedButton(
  //         onPressed: () {
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => ApplicationFeedbackScreen(),
  //             ),
  //           );
  //         },
  //         style: ElevatedButton.styleFrom(
  //           backgroundColor: Colors.orange,
  //           padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(10),
  //           ),
  //         ),
  //         child: Text(
  //           'Send feedback',
  //           style: GoogleFonts.inter(fontSize: 16, color: Colors.white),
  //         ),
  //       ),
  //     );
  //   }

  //   Widget _buildReviewsScreen() {
  //     return Center(
  //       child: ElevatedButton(
  //         onPressed: () {
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(builder: (context) => ReviewScreen()),
  //           );
  //         },
  //         style: ElevatedButton.styleFrom(
  //           backgroundColor: Colors.orange,
  //           padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(10),
  //           ),
  //         ),
  //         child: Text(
  //           'Send Review',
  //           style: GoogleFonts.inter(fontSize: 16, color: Colors.white),
  //         ),
  //       ),
  //     );
  //   }

  //   Widget _buildComplaintsScreen() {
  //     return Center(
  //       child: ElevatedButton(
  //         onPressed: () {
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(builder: (context) => ComplaintScreen()),
  //           );
  //         },
  //         style: ElevatedButton.styleFrom(
  //           backgroundColor: Colors.orange,
  //           padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(10),
  //           ),
  //         ),
  //         child: Text(
  //           'Send Complaint',
  //           style: GoogleFonts.inter(fontSize: 16, color: Colors.white),
  //         ),
  //       ),
  //     );
  //   }
// }
