import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_ecommerce_application/screens/login_screen.dart';
import 'package:flutter_ecommerce_application/screens/profile_screen.dart';
import 'package:flutter_ecommerce_application/screens/product_management_screen.dart';
import 'package:flutter_ecommerce_application/screens/admin_home_screen.dart'; // Import AdminHomeScreen

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blueAccent,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/images/profile.jpeg'), // Replace with your profile picture
                ),
                SizedBox(height: 10),
                Text(
                  'Nasrin Ripa',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'ripa@gmail.com',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Admin Home'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AdminHomeScreen()), // Navigate to AdminHomeScreen
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('My Profile'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.inventory),
            title: Text('Product Management'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ProductManagementScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('Order Management'),
            onTap: () {
              // Navigate to Order Management Screen
            },
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('User Management'),
            onTap: () {
              // Navigate to User Management Screen
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
