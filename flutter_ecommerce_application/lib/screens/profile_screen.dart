import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_application/widgets/custom_drawer.dart';
import 'package:flutter_ecommerce_application/screens/admin_home_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: const AssetImage('assets/images/profile.jpeg'), // Replace with your profile picture
                backgroundColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 20),
            Divider(
              thickness: 1,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 10),
            const DetailTile(
              icon: Icons.person,
              title: 'Name',
              value: 'Nasrin Ripa',
            ),
            const DetailTile(
              icon: Icons.email,
              title: 'Email',
              value: 'ripa@gmail.com',
            ),
            const DetailTile(
              icon: Icons.phone,
              title: 'Phone',
              value: '+1234567890', // Replace with admin's phone
            ),
            const DetailTile(
              icon: Icons.admin_panel_settings,
              title: 'Role',
              value: 'Administrator',
            ),
            const SizedBox(height: 30),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                 Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AdminHomeScreen()),
                );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Back to Dashboard',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const DetailTile({super.key, 
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            icon,
            size: 30,
            color: Colors.blueAccent,
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
