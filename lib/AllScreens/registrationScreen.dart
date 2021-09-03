import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:window1/AllScreens/loginScreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:window1/AllScreens/mainscreen.dart';
import 'package:window1/main.dart';

class RegistrationScreen extends StatelessWidget {
  static const String idScreen ="registration";
  TextEditingController nameTextEditingController=TextEditingController();
  TextEditingController emailTextEditingController=TextEditingController();
  TextEditingController phoneTextEditingController=TextEditingController();
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
                SizedBox(height: 50.0),
                Image(
                  image: AssetImage("images/istockphoto-479993160-612x612.jpg"),
                  width: 300.0,
                  height: 300.0,
                  alignment: Alignment.center,

                ),
                SizedBox(height: 1.0,),
                Text(
                  "Register as feeder",
                  style: TextStyle(fontSize: 24.0),
                  textAlign: TextAlign.center,
                ),
                Padding(padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      SizedBox(height: 1.0,),
                      TextField(
                          controller: nameTextEditingController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: "Name",
                            labelStyle: TextStyle(
                              fontSize: 14.0,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 10.0,
                            ),
                          ),
                          style: TextStyle(fontSize: 14.0
                          )
                      ),
                      SizedBox(height: 1.0,),
                      TextField(
                          controller: emailTextEditingController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "Email",
                            labelStyle: TextStyle(
                              fontSize: 14.0,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 10.0,
                            ),
                          ),
                          style: TextStyle(fontSize: 14.0
                          )
                      ),
                      SizedBox(height: 1.0,),
                      TextField(
                          controller: passwordTextEditingController,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            labelText: "Password",
                            labelStyle: TextStyle(
                              fontSize: 14.0,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 10.0,
                            ),
                          ),
                          style: TextStyle(fontSize: 14.0
                          )
                      ),
                      SizedBox(height: 1.0,),
                      TextField(
                          controller: phoneTextEditingController,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            labelText: "PhoneNumber",
                            labelStyle: TextStyle(
                              fontSize: 14.0,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 10.0,
                            ),
                          ),
                          style: TextStyle(fontSize: 14.0
                          )
                      ),
                      SizedBox(height: 10.0,),
                      RaisedButton(
                        color: Colors.amber,
                        textColor: Colors.black26,
                        child: Container(
                          height: 50.0,
                          child: Center(
                            child: Text(
                              "Register!",
                              style: TextStyle(fontSize: 18.0),

                            ),
                          ),
                        ),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(24.0),
                        ),
                        onPressed: () {
                          print(nameTextEditingController.text);
                          print(emailTextEditingController.text);
                          print(phoneTextEditingController.text);
                          if(nameTextEditingController.text.length < 4){
                            displayToastMessage("name too small must be greater than 4 characters",context);

                          }
                          else if(!emailTextEditingController.text.contains("@"))
                            {
                              displayToastMessage("email wrong! please check again!", context);
                            }
                          else if(phoneTextEditingController.text.isEmpty)
                          {
                            displayToastMessage("Phone number is wrong! please check again!", context);
                          }
                            else{
                            registerNewUser(context);
                          }
                        },
                      ),
                    ],
                  ),
                ),
                // ignore: deprecated_member_use
                FlatButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, LoginScreen.idScreen, (route) => false);
                  },
                  child: Text("Already have a account ? Click here!",

                  ),
                ),

              ],
            ),
          ),
        )
    );
  }
  final FirebaseAuth _firebaseAuth=FirebaseAuth.instance;

  void registerNewUser(BuildContext context)async
  {
    final firebaseUser  =
        (await _firebaseAuth
          .createUserWithEmailAndPassword
          (email: emailTextEditingController.text,
            password:passwordTextEditingController.text).catchError((errMsg){
      displayToastMessage("Error:"+errMsg.toString(),context);
    })).user;


    if(firebaseUser!=null)
      {
        Map userDataMap= {
          "name":nameTextEditingController.text.trim(),
          "email":emailTextEditingController.text.trim(),

        "phone":phoneTextEditingController.text.trim(),
        };
        usersRef.child(firebaseUser.uid).set(userDataMap);
        displayToastMessage("Successfully registered!", context);
        Navigator.pushNamedAndRemoveUntil(context,mainscreen.idScreen, (route) => false);
      }
  else{
      displayToastMessage("new user has not been created!", context);
     }

  }

  }

 // ignore: non_constant_identifier_names
 displayToastMessage(String Message,BuildContext context)
{Fluttertoast.showToast(msg:Message);}

