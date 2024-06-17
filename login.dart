import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dashboard.dart'; // Ensure this import is correct
import 'main.dart'; // Ensure this import is correct
import 'register.dart'; // Ensure this import is correct
import 'home.dart'; // Ensure this import is correct
import 'studentview.dart'; // Ensure this import is correct

class dem14 extends StatefulWidget {
  const dem14({super.key});

  @override
  State<dem14> createState() => _dem14State();
}

class _dem14State extends State<dem14> {
  final eemailcontroller = TextEditingController();
  final ppasswordcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login page"),
        backgroundColor: Colors.greenAccent,
        toolbarHeight: 100,
        titleSpacing: 20,
        actions: [
          IconButton(onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => dem16()),
            );
          }, icon: Icon(Icons.login))
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
                      if (value == null || value.isEmpty || value.length <= 10) {
                        return "Email is empty";
                      }
                      return null;
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
                      if (value == null || value.isEmpty || value.length <= 2) {
                        return "Password is empty";
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
                            MaterialPageRoute(builder: (context) => dem15()),
                          );
                        },
                        child: Text("Register"),
                      ),
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
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => dem19(),
          ),
        );
      } on FirebaseAuthException catch (e) {
        String errorMessage;
        if (e.code == 'user-not-found') {
          errorMessage = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Wrong password provided for that user.';
        } else {
          errorMessage = 'An unknown error occurred.${e.message}';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    }
  }
}
