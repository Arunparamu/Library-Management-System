import 'package:flutter/material.dart';
import 'login.dart';
import 'adminlogin.dart';
class dem16 extends StatefulWidget {
  const dem16({super.key});

  @override
  State<dem16> createState() => _dem16State();
}

class _dem16State extends State<dem16> {
  bool _student =false;
  bool _admin =false;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Library management system"),
        backgroundColor: Colors.greenAccent,
        toolbarHeight: 100,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 100),
        child: Center(
          child: Row(
            children: [
              SizedBox(width: 50),
              Container(
                width: screenWidth*0.4,
                height: screenHeight*0.4,
                color: Colors.green,
                child: MouseRegion(
                  onEnter: (_) => setState(() =>_student=true),
                  onExit: (_) => setState(() =>_student=false),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _student ? Colors.black87 : Colors.transparent,
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
                                MaterialPageRoute(builder: (context) => dem14()),
                              );
                            },
                            child: const Text("Student Login",style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.w700),),
                          ),
                        ),
                        SizedBox(height: 10,),

                      ],
                    ),
                  ),

                ),
              ),
              SizedBox(width: 50),
              Container(
                width: screenWidth*0.4,
                height: screenHeight*0.4,
                color: Colors.orange,
                child: MouseRegion(
                  onEnter: (_) => setState(() =>_admin=true),
                  onExit: (_) => setState(() =>_admin=false),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _admin ? Colors.black87 : Colors.transparent,
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
                                MaterialPageRoute(builder: (context) => dem18()),
                              );
                            },
                            child: const Text("Admin Login",style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.w700),),
                          ),
                        ),
                        SizedBox(height: 10,),

                      ],
                    ),
                  ),

                ),
              ),
              SizedBox(height: 30,),

            ],
          ),
        ),
      ),
    );
  }
}
