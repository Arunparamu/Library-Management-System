import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'home.dart';
class dem19 extends StatelessWidget {
  const dem19({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Books"),
        backgroundColor: Colors.greenAccent,
        toolbarHeight: 100,
        titleSpacing: 20,
        actions: [
          IconButton(onPressed: ()
          {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => dem16()),
            );
          },
              icon: Icon(Icons.login))
        ],
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
                      trailing: Icon(Icons.near_me)

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
      padding: EdgeInsets.all(20),
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
          
        ],
      ),
    );
  }
}


