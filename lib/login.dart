import 'package:flutter/material.dart';
import 'ManageInfo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'register.dart';

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

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
             Container(
                    padding: EdgeInsets.only(right: 200, top: 20),
                    child: Text('Login',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    padding: EdgeInsets.only(right:150, ),
                    child: Text('Now',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0, fontWeight: FontWeight.bold)
                    ),
                  ),
                  new Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        new Container(
                          margin: new EdgeInsets.only(left: 85.0 , bottom: 80.0),
                          height: 60.0,
                          width: 60.0,
                          decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.circular(40.0),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Colors.pink[300], Colors.cyan[200]]
                            )
                          ),
                          child: new Icon(Icons.account_circle, color: Colors.cyan[100], size: 50,),
                        ),
                        new Container(
                          margin: new EdgeInsets.only(right: 20.0 , bottom: 80.0),
                          height: 60.0,
                          width: 60.0,
                          decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.circular(40.0),
                            gradient: LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: [Colors.cyan[200], Colors.pink[300]]
                            )
                          ),
                          child: new Icon(Icons.account_circle, color: Colors.pink[100], size: 50,),
                        )
                      ],
                  ),
                  SizedBox(width: 50,),
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
                  return 'Your password need to be more than 6 characters';
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
               child: Text('Login'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.0),
              Padding(
              padding: EdgeInsets.only(top: 320, left: 65),
              child: Row(
              children: <Widget>[
                Text(
                  'New to the app ?',
                  style: TextStyle(fontFamily: 'Montserrat'),
                ),
                SizedBox(width: 15.0),
                InkWell(
                  onTap: () {
                    if(this._password==null){
                    Navigator.of(context).pushNamed('/register');
                    }
                  },
                  child: Text(
                    'Register Now',
                    style: TextStyle(
                        color: Colors.cyan[300],
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                    ),
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
        FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.push(context, MaterialPageRoute(builder: (context) => SecondScreenPage(user: user)));
      }catch(e){
        print(e.message);
      }
      
    }
  }

}