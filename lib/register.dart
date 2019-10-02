import 'package:flutter/material.dart';
import 'ManageInfo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget{
  @override
  _RegisterPageState createState() => new _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

String _email, _password;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Form(
        key:  _formkey,
        child: Stack(
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
            padding: EdgeInsets.symmetric(horizontal:25, vertical: 40),
            child: TextFormField(
              validator: (input){
                if(input.isEmpty){
                  return 'Did you forget something here ? ';
                }
              },
              onSaved: (input) => _email = input,
              decoration: new InputDecoration(
                labelText: 'Email',
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderRadius: 
                  new BorderRadius.circular(25.0),
                  borderSide: 
                  new BorderSide(color: Colors.cyan[200])
                )
              ),
            ),
            ),
            Padding(
            padding: EdgeInsets.symmetric(horizontal:25, vertical: 0),
            child: TextFormField(
              validator: (input){
                if(input.length < 6){
                  return 'Password required';
                }
              },
              onSaved: (input) => _password = input,
              decoration: InputDecoration(
                labelText: 'Password',
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderRadius: 
                  new BorderRadius.circular(25.0),
                  borderSide: 
                  new BorderSide(color: Colors.cyan[200])
                )
              ),
              obscureText: true,
             ),
            ),
             RaisedButton(
               shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
               color: Colors.cyan[200],
               textColor: Colors.white,
               onPressed: (){
                 signin();
               },
               child: Text('Register'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signin() async {
    final formState = _formkey.currentState;
    if (formState.validate()){
      formState.save();
      try{
        FirebaseUser user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
        Navigator.push(context, MaterialPageRoute(builder: (context) => SecondScreenPage(user: user)));
      }catch(e){
        print(e.message);
      }
      
    }
  }

}