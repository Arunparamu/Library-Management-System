import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'addbook.dart';
import 'login.dart';
import 'home.dart';

class dem15 extends StatefulWidget {
  const dem15({super.key});

  @override
  State<dem15> createState() => _dem15State();
}

class _dem15State extends State<dem15> {
  final auth = FirebaseAuth.instance;
  CollectionReference ref = FirebaseFirestore.instance.collection('books');

  final TextEditingController ppasswordController = TextEditingController();
  final TextEditingController cconfirmpassController = TextEditingController();
  final TextEditingController eemailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register page"),
        backgroundColor: Colors.greenAccent,
        toolbarHeight: 100,
        titleSpacing: 20,
        actions: [
          IconButton(onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => dem14()),
            );
          }, icon: Icon(Icons.login))
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 70,),
              Container(
                child: Icon(Icons.account_circle, size: 100,),
              ),
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.all(50),
                child: TextFormField(
                  controller: eemailController,
                  decoration: InputDecoration(
                    labelText: "Enter the email",
                    hintText: "XXX@gmail.com",
                    border: OutlineInputBorder(),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty || !value.contains('@') || !value.contains('.')) {
                      return "Enter a valid email";
                    }
                    return null;
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(50),
                child: TextFormField(
                  obscureText: true,
                  controller: ppasswordController,
                  decoration: InputDecoration(
                    labelText: "Enter the password",
                    border: OutlineInputBorder(),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Password is empty";
                    } else if (value.length < 6) {
                      return "Password should be at least 6 characters";
                    }
                    return null;
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 100, top: 50),
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => dem14()),
                        );
                      },
                      child: Text("Back"),
                    ),
                    SizedBox(width: 100,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.green),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          register(eemailController.text, ppasswordController.text);
                        }
                      },
                      child: Text("Register"),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50,),
            ],
          ),
        ),
      ),
    );
  }

  void register(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => dem14()));
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'email-already-in-use') {
        errorMessage = 'The email address is already in use by another account.';
      } else if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else {
        errorMessage = 'An unknown error occurred.${e.message}';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }
}
