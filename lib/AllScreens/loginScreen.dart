import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:window1/AllScreens/mainscreen.dart';
import 'package:window1/AllScreens/registrationScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../main.dart';
class LoginScreen extends StatelessWidget {
  static const String idScreen ="LoginScreen";
  TextEditingController emailTextEditingController=TextEditingController();
  TextEditingController passwordTextEditingController=TextEditingController();


  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body:
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
            children: [
              SizedBox(height:50.0 ),
              Image(
                image: AssetImage("images/istockphoto-479993160-612x612.jpg"),
                width: 300.0,
                height: 300.0,
                alignment: Alignment.center,

              ),
            SizedBox(height: 1.0,),
              Text(
                "Login as Seeker",
                    style:TextStyle(fontSize: 24.0),
                textAlign: TextAlign.center,
              ),
              Padding(padding:EdgeInsets.all(20.0),
              child:Column(
                  children: [
                    SizedBox(height:1.0,),
                    TextField(
                      controller: emailTextEditingController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(
                            fontSize: 14.0,
                          ),
                          hintStyle:TextStyle(
                            color:Colors.grey,
                            fontSize: 10.0,
                          ),
                        ) ,
                        style:TextStyle(            fontSize: 14.0
                        )
                    ),
                    SizedBox(height:1.0,),
                    TextField(
                      controller: passwordTextEditingController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(
                            fontSize: 14.0,
                          ),
                          hintStyle:TextStyle(
                            color:Colors.grey,
                            fontSize: 10.0,
                          ),
                        ) ,
                        style:TextStyle(            fontSize: 14.0
                        )
                    ),
                    SizedBox(height: 10.0,),
                    // ignore: deprecated_member_use
                    RaisedButton(
                      color: Colors.amber,
                      textColor:Colors.black26,
                      child: Container(
                        height:50.0,
                      child:Center(
                        child: Text(
                          "login",
                          style: TextStyle(fontSize:18.0),
                        ),
                      ),
                      ),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(24.0),
                      ),
                      onPressed: () {
                        if(!emailTextEditingController.text.contains("@"))
                        {
                          displayToastMessage("email wrong! please check again!", context);
                        }
                        else if(passwordTextEditingController.text.length < 7 || passwordTextEditingController.text.isEmpty )
                        {
                          displayToastMessage(" password has been entered in a wrong way ! please correct", context);
                        }
                        else {
                          loginAndAutenticateUser(context);
                        }
                      },
                    ),
                ],
              ),
      ),
      ElevatedButton(
            onPressed: (){
            Navigator.pushNamedAndRemoveUntil(context, RegistrationScreen.idScreen, (route) => false);
      },
            child:Text( "Dont have a account ? Click here!",),
      ),
            ],
      ),
          ),
        )
    );
  }
  final FirebaseAuth _firebaseAuth=FirebaseAuth.instance;
  void loginAndAutenticateUser(BuildContext context)async
  {
    final User? firebaseUser  =
        (await _firebaseAuth
            .signInWithEmailAndPassword(
          email: emailTextEditingController.text,
            password:passwordTextEditingController.text).catchError((errMsg){
          displayToastMessage("Error:"+errMsg.toString(),context);
        })).user;
    // ignore: unnecessary_null_comparison
    if(firebaseUser!=null)
    {
      usersRef.child(firebaseUser.uid).once().then( (DataSnapshot snap){
        if(snap.value !=null) {
          Navigator.pushNamedAndRemoveUntil(context, mainscreen.idScreen, (route) => false);
          displayToastMessage("you are logged in", context);
        }
        else {
          _firebaseAuth.signOut();
          displayToastMessage("no record", context);
        }
      });
      }
    else {
      displayToastMessage("error ", context);
    }
    }
  }
