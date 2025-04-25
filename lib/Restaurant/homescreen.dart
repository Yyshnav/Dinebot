import 'package:dinebot/Restaurant/complaints.dart';
import 'package:dinebot/Restaurant/feedback.dart';
import 'package:dinebot/Restaurant/managedishes.dart';
import 'package:dinebot/Restaurant/trolley.dart';
import 'package:dinebot/Restaurant/viewusers.dart';
import 'package:dinebot/user/togleloginui.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RestaurantHomeScreen extends StatefulWidget {
  @override
  _RestaurantHomeScreenState createState() => _RestaurantHomeScreenState();
}

class _RestaurantHomeScreenState extends State<RestaurantHomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    ManageDishesScreen(),
    ViewAllOrdersScreen(),
    ViewAllUsersScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(actions: [PopupMenuButton(itemBuilder: (context) => 
      [
        PopupMenuItem(
          value: 'View Complaints',
          child: Text('Complaints'),
        ),
         PopupMenuItem(
          value: 'View Feedback',
          child: Text('Feedback'),
        ),
         PopupMenuItem(
          value: 'logout',
          child: Text('Logout'),
        ),
      ],
      onSelected: (value) {
        if (value == 'View Complaints') {
          // Handle logout logic here
          Navigator.push(context, MaterialPageRoute(builder: (context) => ViewComplaintsScreen()));
        }
         if (value == 'View Feedback') {
          // Handle logout logic here
          Navigator.push(context, MaterialPageRoute(builder: (context) => FeedbackViewScreen()));
        }
         if (value == 'logout') {
          // Handle logout logic here
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ToggleLoginPage(),), (Route)=>false);
        }
      },
      icon: Icon(Icons.more_vert_outlined,color: Colors.white,),
      )],
        title: Text(
          'Restaurant Dashboard',
          style: GoogleFonts.pacifico(color: Colors.amber, fontSize: 22),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white60,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Dishes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: 'Users',
          ),
        ],
      ),
    );
  }
}
