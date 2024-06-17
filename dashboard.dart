import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'addbook.dart';
import 'viewdata.dart';
import 'main.dart';
class dem1 extends StatefulWidget {
  const dem1({super.key});

  @override
  State<dem1> createState() => _dem1State();
}

class _dem1State extends State<dem1> {
  bool _addbook =false;
  bool _viewbook =false;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Library management system"),
        toolbarHeight: 100,
        backgroundColor: Colors.greenAccent,
      ),
      body: SingleChildScrollView(
        child:Center(
          child: Column(
            children: [
              SizedBox(height: 50),
              Container(
                width: screenWidth*0.4,
                height: screenHeight*0.4,
                color: Colors.blueAccent,
                child: MouseRegion(
                  onEnter: (_) => setState(() =>_addbook=true),
                  onExit: (_) => setState(() =>_addbook=false),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _addbook ? Colors.black87 : Colors.transparent,
                        width: 3.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 100,),
                        Container(
                          child: TextButton(
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => dem2()),
                              );
                            },
                            child: const Text("Add Books",style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.w700),),
                          ),
                        ),
                        SizedBox(height: 10,),

                      ],
                    ),
                  ),

                ),
              ),
              SizedBox(height: 50),
              Container(
                width: screenWidth*0.4,
                height: screenHeight*0.4,
                color: Colors.green,
                child: MouseRegion(
                  onEnter: (_) => setState(() =>_viewbook=true),
                  onExit: (_) => setState(() =>_viewbook=false),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _viewbook ? Colors.green : Colors.transparent,
                        width: 3.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 100,),
                        Container(
                          child: TextButton(
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Deez()),
                              );
                            },
                            child: const Text("View Books",style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.w700),),
                          ),
                        ),
                        SizedBox(height: 10,),

                      ],
                    ),
                  ),

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
