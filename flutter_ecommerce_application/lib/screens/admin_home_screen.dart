import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_application/widgets/custom_drawer.dart';

class AdminHomeScreen extends StatelessWidget {
  // List of product images
  final List<String> productImages = [
    'assets/images/img_image7.png',
    'assets/images/img_image8.png',
    'assets/images/img_rectangle13.png',
    'assets/images/img_rectangle11.png',
    'assets/images/img_rectangle14.png',
    'assets/images/img_rectangle12.png',
  ];

  // List of custom product names
  final List<String> productNames = [
    'Nike Air Max 2021',
    'Nike Air Zoom Pegasus',
    'Nike Free RN 5.0',
    'Nike React Infinity Run',
    'Nike ZoomX Vaporfly NEXT%',
    'Nike Air Force 1 Low',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: CustomDrawer(), // Use the reusable CustomDrawer
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 3 / 4,
          ),
          itemCount: productImages.length, // Number of items (images)
          itemBuilder: (context, index) {
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                      child: Image.asset(
                        productImages[index], // Use asset image
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          productNames[index], // Display product name from the list
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '\$${(index + 1) * 100}', // Example price (adjust as needed)
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
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
