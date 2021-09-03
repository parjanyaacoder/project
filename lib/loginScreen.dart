import 'package:flutter/material.dart';
import 'package:window1/HomeScreen.dart';

import 'AllScreens/Config.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  String user ="";
  void payloadCallback(context,payload)
  {
    if(payload==null ||(payload is String && payload.length == 0))
      payload = "Login Failed";
    setState(() {
      user = payload;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body:
        Center(
          child: SingleChildScrollView(
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
                  SizedBox(height: 10.0,),
                  Text(
                    "Login as Seeker",
                    style:TextStyle(fontSize: 24.0),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10.0,),
                   ElevatedButton(onPressed: () async {
                    await sawo.signIn(context: context, identifierType: 'phone_number_sms',callback: payloadCallback);
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>homeScreen()));
                     }, child: Text('Login using Phone')),
                      ],
                    ),
                 ),
              ),
        ),
    );
  }
}
