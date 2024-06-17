import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'addbook.dart';
import 'viewdata.dart';
import 'dashboard.dart';
import 'register.dart';
import 'login.dart';
import 'home.dart';
import 'studentview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyAAWED48RsE4ORj9Rwmsy6qL2P-Dd7Apzo",
        authDomain: "libra-d28da.firebaseapp.com",
        projectId: "libra-d28da",
        storageBucket: "libra-d28da.appspot.com",
        messagingSenderId: "466650745180",
        appId: "1:466650745180:web:7dbe7af2121ef1f9f51999",
        measurementId: "G-FQJGMBVG4K"
    ),
  );
  runApp(MaterialApp(home: dem16(),debugShowCheckedModeBanner: false,));
}
