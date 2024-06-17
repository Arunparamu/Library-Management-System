import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
class dem2 extends StatefulWidget {
  const dem2({super.key});

  @override
  State<dem2> createState() => _dem2State();
}

class _dem2State extends State<dem2> {
  final _formKey = GlobalKey<FormState>();
  var _namecontroller=new TextEditingController();
  var _isbncontroller=new TextEditingController();
  var _authorcontroller=new TextEditingController();
  var _publishercontroller=new TextEditingController();
  var _languagecontroller=new TextEditingController();
  var _quantitycontroller=new TextEditingController();
  var _categorycontroller=new TextEditingController();
  var _editioncontroller=new TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Books"),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
        toolbarHeight: 100,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 50,),
              Container(
                child: Text("Enter the book name",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
              ),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.all(30),
                child: TextFormField(
                  controller: _namecontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter the book name"
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter name';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 50,),
              Container(
                child: Text("Enter the ISBN/Barcode",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
              ),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.all(30),
                child: TextFormField(
                  controller: _isbncontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Enter the ISBN/Barcode"
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter ISBN';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 50,),
              Container(
                child: Text("Enter the author",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
              ),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.all(30),
                child: TextFormField(
                  controller: _authorcontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Enter the author"
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter author';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 50,),
              Container(
                child: Text("Enter the edition",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
              ),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.all(30),
                child: TextFormField(
                  controller: _editioncontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Enter the edition"
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter edition';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 50,),
              Container(
                child: Text("Enter the category",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
              ),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.all(30),
                child: TextFormField(
                  controller: _categorycontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Enter the category"
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter category';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 50,),
              Container(
                child: Text("Enter the publisher",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
              ),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.all(30),
                child: TextFormField(
                  controller: _publishercontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Enter the publisher"
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter publisher';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 50,),
              Container(
                child: Text("Enter the language",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
              ),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.all(30),
                child: TextFormField(
                  controller: _languagecontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Enter the language"
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter language';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 50,),
              Container(
                child: Text("Enter the quantity",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
              ),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.all(30),
                child: TextFormField(
                  controller: _quantitycontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Enter the quantity"
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter quantity';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                  onPressed: ()
                  async
                  {
                    if(_formKey.currentState?.validate()==true)
                      {
                        await FirebaseFirestore.instance.collection('books').add({
                          'name': _namecontroller.text,
                          'ISBN':_isbncontroller.text,
                          'author':_authorcontroller.text,
                          'edition':_editioncontroller.text,
                          'category':_categorycontroller.text,
                          'language':_languagecontroller.text,
                          'quantity':_quantitycontroller.text,
                          'publisher':_publishercontroller.text,

                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => dem3()),
                        );
                      }
                  },
                  child: Text("submit"),
                ),
              ),
              SizedBox(height: 50,),
            ],
          ),
        ),
      ),
    );
  }
}
class dem3 extends StatefulWidget {
  const dem3({super.key});

  @override
  State<dem3> createState() => _dem3State();
}

class _dem3State extends State<dem3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
           child: Image(image:const AssetImage("assets/image1.png"),)
      ),
    );
  }
}

