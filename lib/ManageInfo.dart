import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'login.dart';

class SecondScreenPage extends StatefulWidget{

  const SecondScreenPage(
    {
     Key key,
     this.user
    }
    )
    : super(key: key);

  final FirebaseUser user;

  @override
  SecondScreen createState() => new SecondScreen();
}

class SecondScreen extends State<SecondScreenPage> {
  
  
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      fontFamily: "Calibre-Semibold"
    ),
    home: new Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.pink[200], Colors.cyan[100]]
                  )
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 12.0, right: 12.0, top: 30.0, bottom: 8.0
                      ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.menu,
                            color: Colors.white,
                            size: 30.0,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.settings,
                            color: Colors.white,
                            size: 30.0,
                          ),
                          onPressed: () {}, 
                        )
                      ],
                    ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Create your account",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            letterSpacing: 1.0,
                            )
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal:130, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[                        
                          Container(
                            width: 100 ,
                            height: 100,
                            decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage("assets/user.png")
                              ),
                            ),
                          ),
                          
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 0),
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("You have to choose your profile pictures",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            letterSpacing: 1.0
                            ), 
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:EdgeInsets.symmetric(horizontal: 50),
                      child: Column(
                        children: <Widget>[
                          IconButton(
                          icon: Icon(
                            Icons.add_a_photo,
                            color: Colors.white,
                            size: 30.0,
                          ),
                          onPressed: () {                            
                          },
                         ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
  }
}