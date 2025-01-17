import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditProductsScreen extends StatefulWidget {
  const EditProductsScreen({super.key});

  @override
  State<EditProductsScreen> createState() => _EditProductsScreenState();
}

class _EditProductsScreenState extends State<EditProductsScreen> {
  final stremContent = FirebaseFirestore.instance
      .collection('products') // Update to 'products' collection
      .where('softDelete', isEqualTo: false)
      .snapshots();

  // Update product data
  Future<void> _updateProductData(id, name, description, price) async {
    await FirebaseFirestore.instance.collection('products').doc(id).update({
      "name": name,
      "description": description,
      "price": price,
      'softDelete': false,
    });
  }

  // Prevent Duplicate Product Name
  Future<bool> _isDuplicateProductName(String name) async {
    final query = await FirebaseFirestore.instance.collection('products').get();

    for (var doc in query.docs) {
      final data = doc.data() as Map;
      if (data['name'] == name) {
        return true; // Duplicate product name found
      }
    }
    return false; // No duplicate found
  }

  // Soft Delete Product with Snackbar and Undo
  Future<void> _softDeleteProduct(String id, String name) async {
    await FirebaseFirestore.instance.collection('products').doc(id).update({
      'softDelete': true,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$name deleted'),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () async {
            await FirebaseFirestore.instance.collection('products').doc(id).update({
              'softDelete': false,
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Products',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: StreamBuilder(
        stream: stremContent,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final docs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final doc = docs[index];
              final content = doc.data() as Map;
              return ListTile(
                title: Text(content['name']),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        _showDialog(context, index, content['name'], content['description'], content['price'], doc.id);
                      },
                      icon: Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        _softDeleteProduct(doc.id, content['name']);
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  // Show Dialog Box for editing product data
  void _showDialog(context, index, contentName, contentDescription, contentPrice, id) {
    TextEditingController nameController = TextEditingController(text: contentName);
    TextEditingController descriptionController = TextEditingController(text: contentDescription);
    TextEditingController priceController = TextEditingController(text: contentPrice.toString());
    final _formKey = GlobalKey<FormState>();

    showDialog(
      context: (context),
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Product'),
          content: Form(
            key: _formKey,
            child: Container(
              width: double.minPositive,
              height: 250,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the product name';
                      } else if (value.length < 3) {
                        return 'Name must be at least 3 characters long';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the product description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    controller: priceController,
                    decoration: InputDecoration(
                      labelText: 'Price',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the product price';
                      } else if (double.tryParse(value) == null) {
                        return 'Please enter a valid price';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  // Check for duplicate product name before updating
                  bool isDuplicate = await _isDuplicateProductName(nameController.text);
                  if (isDuplicate) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('This product name is already in use!'),
                      ),
                    );
                  } else {
                    // If no duplicates, update the product data
                    _updateProductData(id, nameController.text, descriptionController.text, double.parse(priceController.text));
                    Navigator.pop(context);
                  }
                }
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }
}
