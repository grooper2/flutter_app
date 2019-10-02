import 'package:dbexamp/register.dart';
import 'package:flutter/material.dart';
import 'package:dbcrypt/dbcrypt.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:email_validator/email_validator.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'login.dart';
// import 'package:multi_image_picker/multi_image_picker.dart';

File image;
List<int> imageBytes = image.readAsBytesSync();

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        initialRoute: '/',
        routes: {
        // When navigating to the "/" route, build the FirstScreen widget.

        // When navigating to the "/second" route, build the SecondScreen widget.
        '/second': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        },  


      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.cyan,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  List<Item> users = List();
  Item item;
  DatabaseReference itemRef;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future getImage() async {
    File picture = await ImagePicker.pickImage(
      source: ImageSource.gallery, maxWidth: 350.0, maxHeight: 500.0);
      setState(() {
        image = picture;
        
      }); 
      
  }

  @override
  void initState() {
    super.initState();
    item = Item("", "", "", "", "");
    final FirebaseDatabase database = FirebaseDatabase.instance; //Rather then just writing FirebaseDatabase(), get the instance.  
    itemRef = database.reference().child('users');
    itemRef.onChildAdded.listen(_onEntryAdded);
    itemRef.onChildChanged.listen(_onEntryChanged);
  }

  _onEntryAdded(Event event) {
    setState(() {
      users.add(Item.fromSnapshot(event.snapshot));
    });
  }

  _onEntryChanged(Event event) {
    var old = users.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    setState(() {
      users[users.indexOf(old)] = Item.fromSnapshot(event.snapshot);
    });
  }

  void handleSubmit() {
    final FormState form = formKey.currentState;

    if (form.validate()) {
      form.save();
      form.reset();
      itemRef.push().set(item.toJson());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
          child:Column(
            children: <Widget>[
          Flexible(
            flex: 1,
            child: Center(
              child: Form(
                key: formKey,
                child: Flex(
                  direction: Axis.vertical,
                  children: <Widget>[
                    ListTile(
                      title: TextFormField(
                        style: TextStyle(
                          
                          letterSpacing: 1.0,
                        ),
                        decoration: new InputDecoration(
                          labelText: "Username",
                          border: new OutlineInputBorder(
                          borderRadius: 
                          new BorderRadius.circular(25.0),
                          borderSide: 
                          new BorderSide(color: Colors.cyan[200])
                          )
                        ),
                        initialValue: "",
                        onSaved: (val) => item.username = val,
                        validator: (val) => val == "" ? val : null,
                      ),
                    ),
                    ListTile(
                      title: TextFormField(
                        style: TextStyle(
                          
                          letterSpacing: 1.0,
                        ),
                        decoration: new InputDecoration(
                          labelText: "Insert your age ?",
                          border: new OutlineInputBorder(
                            borderRadius: 
                            new BorderRadius.circular(25.0),
                            borderSide: 
                            new BorderSide(color: Colors.cyan[200])
                          )
                        ),
                        initialValue: "",
                        onSaved: (val) => item.dob = val,
                        // validator: (val) => val == "18" ? val : null,
                      ),
                    ),
                    ListTile(
                      title: TextFormField(
                        style: TextStyle(
                          
                          letterSpacing: 1.0,
                        ),
                        decoration: new InputDecoration(
                          labelText: "Email",
                          border: new OutlineInputBorder(
                            borderRadius: 
                            new BorderRadius.circular(25.0),
                            borderSide: 
                            new BorderSide(color: Colors.cyan[200])
                          )
                        ),
                        initialValue: "",
                        onSaved: (val) => item.email = val,
                        validator: (val) => !EmailValidator.Validate(val, true)
                        ? 'Not a valid email.'
                        : null,
                      ),
                    ),
                    ListTile(
                      title: TextFormField(
                        style: TextStyle(
                          
                          letterSpacing: 1.0,
                        ),
                        decoration: new InputDecoration(
                        labelText: "Password",
                        border: new OutlineInputBorder(
                          borderRadius: 
                          new BorderRadius.circular(25.0),
                          borderSide: 
                          new BorderSide(color: Colors.cyan[200])
                        )
                      ),
                        initialValue: '',
                        onSaved: (val) => item.password = val,
                        validator: (val) => val.length >= 6
                        ? 'Password must be 6 characters or more'
                        : null,
                        obscureText: true,
                      ),
                    ),
                    ListTile(
                      title: FlatButton.icon(
                        label: Text("Select your profile picture") ,
                        clipBehavior: Clip.antiAlias,
                        icon: Icon(Icons.add_a_photo),
                        color: Colors.white,
                          onPressed: () {
                            getImage();
                          },                          
                        ),
                        
                    ),
                    ListTile(
                      title: OutlineButton (
                        splashColor: Colors.white,
                        onPressed: () {},
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                        highlightElevation: 0,
                        borderSide: BorderSide(color: Colors.grey),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  'Sign in with Google',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    letterSpacing: 1.0
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ) ,
                    ),
                    IconButton(
                      color: Colors.white,
                      splashColor: Colors.white,
                      icon: Icon(Icons.send),
                      onPressed: () {
                        
                        Navigator.pushNamed(context, '/second');
                        handleSubmit();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          ],
          ),
          ),
        ],
      ),
    );
  }
 
}


class Item {
  String key;
  String email;
  String username;
  String password;
  String image64;
  String dob;

  Item(this.username, this.password, this.email, this.image64,this.dob);

  Item.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        username = snapshot.value["Username"],
        email = snapshot.value["Email"],
        password = snapshot.value["Password"],
        image64 = snapshot.value["Image"],
        dob = snapshot.value["DoB"];

  toJson() {
    return {
      "username": username,
      "dob": dob,
      "email":email,
      "password": password = new DBCrypt().hashpw(password, new DBCrypt().gensalt()),
      "image": image64 =  base64Encode(imageBytes),
    };
  }
}