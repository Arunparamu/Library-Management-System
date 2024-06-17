import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dashboard.dart';
import 'main.dart';
import 'register.dart';
import 'home.dart';

class dem18 extends StatefulWidget {
  const dem18({super.key});

  @override
  State<dem18> createState() => _dem18State();
}

class _dem18State extends State<dem18> {
  final eemailcontroller = TextEditingController();
  final ppasswordcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  // Constants for admin credentials
  static const String adminEmail = 'admin@gmail.com';
  static const String adminPassword = 'password';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login page"),
        backgroundColor: Colors.greenAccent,
        toolbarHeight: 100,
        titleSpacing: 20,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => dem16()), // Ensure dem16 is imported correctly
                );
              },
              icon: Icon(Icons.login))
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Center(
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
                    controller: eemailcontroller,
                    decoration: InputDecoration(
                      labelText: "Enter the email",
                      hintText: "XXX@gmail.com",
                      border: OutlineInputBorder(),
                    ),
                    validator: (String? value) {
                      if (value!.isEmpty || value.length <= 10 || value == null) {
                        return "Email is empty";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(50),
                  child: TextFormField(
                    obscureText: true,
                    controller: ppasswordcontroller,
                    decoration: InputDecoration(
                      labelText: "Enter the password",
                      border: OutlineInputBorder(),
                    ),
                    validator: (String? value) {
                      if (value!.isEmpty || value.length <= 2 || value == null) {
                        return "Password is empty";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 90, top: 50),
                  child: Column(
                    children: [
                      SizedBox(width: 100,),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.green),
                        onPressed: () {
                          signIn(eemailcontroller.text, ppasswordcontroller.text);
                        },
                        child: Text("Login"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signIn(String email, String password) async {
    if (_formkey.currentState?.validate() == true) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        User? user = userCredential.user;

        if (user != null) {
          if (email == adminEmail) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => dem1(),
              ),
            );
          }
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        } else {
          print('Error: ${e.message}');
        }
      }
    }
  }
}




