import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SoftDeletedProductsScreen extends StatelessWidget {
  final softDeletedStream = FirebaseFirestore.instance
      .collection('products') // Use 'products' collection
      .where('softDelete', isEqualTo: true)
      .snapshots();

  Future<void> _restoreData(String id) async {
    await FirebaseFirestore.instance.collection('products').doc(id).update({
      'softDelete': false,
    });
  }

  Future<void> _hardDeleteData(String id) async {
    await FirebaseFirestore.instance.collection('products').doc(id).delete();
  }

  void _showDeleteConfirmationDialog(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Permanently'),
          content: Text('Are you sure you want to permanently delete this product?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _hardDeleteData(id); // Proceed with deletion
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Deleted Products',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: StreamBuilder(
        stream: softDeletedStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
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
                        _restoreData(doc.id);
                      },
                      icon: Icon(Icons.restore, color: Colors.green),
                    ),
                    IconButton(
                      onPressed: () {
                        _showDeleteConfirmationDialog(context, doc.id);
                      },
                      icon: Icon(Icons.delete, color: Colors.red),
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
}
