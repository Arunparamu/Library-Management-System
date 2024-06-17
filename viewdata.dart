import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
class Deez extends StatelessWidget {
  const Deez({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Display"),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
        toolbarHeight: 100,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('books').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final List<DocumentSnapshot> documents = snapshot.data!.docs;
            return ListView(
              children: documents.map((doc) {
                final data = doc.data() as Map<String, dynamic>;
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookDetailsScreen(bookId: doc.id, bookDetails: data),
                      ),
                    );
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(data['name']),
                      subtitle: Text('Tap for details'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              _showUpdateDialog(context, doc.id, 'name', data['name']);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _deleteDocument(doc.id);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          } else {
            return Center(child: Text('No data found'));
          }
        },
      ),
    );
  }
}

class BookDetailsScreen extends StatelessWidget {
  final String bookId;
  final Map<String, dynamic> bookDetails;

  const BookDetailsScreen({Key? key, required this.bookId, required this.bookDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(bookDetails['name']),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
        toolbarHeight: 100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow(context, 'Name', bookDetails['name']),
            Divider(height: 2,),
            _buildDetailRow(context, 'Author', bookDetails['author']),
            Divider(height: 2,),
            _buildDetailRow(context, 'ISBN', bookDetails['ISBN']),
            Divider(height: 2,),
            _buildDetailRow(context, 'Publisher', bookDetails['publisher']),
            Divider(height: 2,),
            _buildDetailRow(context, 'Language', bookDetails['language']),
            Divider(height: 2,),
            _buildDetailRow(context, 'Quantity', bookDetails['quantity']),
            Divider(height: 2,),
            _buildDetailRow(context, 'Category', bookDetails['category']),
            Divider(height: 2,),
            _buildDetailRow(context, 'Edition', bookDetails['edition']),
            Divider(height: 2,),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(value),
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              _showUpdateDialog(context, bookId, label.toLowerCase(), value);
            },
          ),
        ],
      ),
    );
  }
}

void _showUpdateDialog(BuildContext context, String docId, String field, String currentValue) {
  var _controller = TextEditingController(text: currentValue);
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Update $field'),
        content: TextField(
          controller: _controller,
          decoration: InputDecoration(labelText: 'New $field'),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Update'),
            onPressed: () {
              _updateDocument(docId, field, _controller.text);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
void _updateDocument(String docId, String field, String newValue) {
  FirebaseFirestore.instance.collection('books').doc(docId).update({field: newValue}).then((_) {
    print('Updated successfully!');
  }).catchError((error) {
    print('Failed to update: $error');
  });
}

void _deleteDocument(String docId) {
  FirebaseFirestore.instance.collection('books').doc(docId).delete().then((_) {
    print('Deleted successfully!');
  }).catchError((error) {
    print('Failed to delete: $error');
  });
}