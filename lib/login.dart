import 'package:flutter/material.dart';
import 'package:firstapp_flutter/otp_screen.dart';
//import 'package:firstapp_flutter/assets/images';
import 'package:firebase_auth/firebase_auth.dart';

class LoginForm extends StatelessWidget {
  //const ({Key? key}) : super(key: key);
  TextEditingController phoneController =
      TextEditingController(); // to read input values
  TextEditingController passwordController =
      TextEditingController(); // to read input values
  String phoneText = '';
//String passwordText='testing password';
  static OutlineInputBorder border_variable = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(width: 2, color: Colors.blue));
  // var firebase_instance=FirebaseAuth.instance;   //made variable for firebase instance to send to next otp screen

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Login Page "),
      ),
      body: SingleChildScrollView(
        //scrollDirection: Axis.horizontal,
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Column(
              // Column is also a layout widget. It takes a list of children and
              // arranges them vertically. By default, it sizes itself to fit its
              // children horizontally, and tries to be as tall as its parent.
              //
              // Invoke "debug painting" (press "p" in the console, choose the
              // "Toggle Debug Paint" action from the Flutter Inspector in Android
              // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
              // to see the wireframe for each widget.
              //
              // Column has various properties to control how it sizes itself and
              // how it positions its children. Here we use mainAxisAlignment to
              // center the children vertically; the main axis here is the vertical
              // axis because Columns are vertical (the cross axis would be
              // horizontal).
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Image.asset("assests/images/otp.png", fit: BoxFit.cover),
                      SizedBox(height: 80),

                      Container(
                        child: TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                          decoration: InputDecoration(
                              //border: border_variable,
                              disabledBorder: border_variable,
                              errorBorder: border_variable.copyWith(
                                  borderSide: BorderSide(color: Colors.red)),
                              focusedBorder: border_variable.copyWith(
                                  borderSide: BorderSide(color: Colors.blue)),
                              enabledBorder: border_variable.copyWith(
                                  borderSide: BorderSide(color: Colors.grey)),
                              labelText: "Mobile No",
                              hintText: "Enter Mobile No",
                              prefixText: '+91'),
                        ),
                      ),

//
// TextField(controller: passwordController,
// obscureText: true,
// decoration: InputDecoration(    //border: border_variable,
// disabledBorder:border_variable,
// errorBorder:border_variable.copyWith(borderSide:BorderSide(color:Colors.red) ),
// focusedBorder:border_variable.copyWith(borderSide:BorderSide(color: Colors.blue)),
// enabledBorder:border_variable.copyWith(borderSide:BorderSide(color: Colors.grey)),
// labelText: "Password",
//   hintText: "Enter Password"
// ),
// ),
                      SizedBox(height: 30),
                      Container(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          // style: TextButton.styleFrom(primary: Colors.blue),

                          onPressed: () async {
                            // print("you pressed button");
                            phoneText = phoneController.text;
                            // print(phoneText);
                            //;
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => OTPScreen(
                                      phone: phoneText,
                                    )));

                            // await firebase_instance.verifyPhoneNumber(
                            //   phoneNumber: '+91 $phoneText',
                            //   verificationCompleted: (PhoneAuthCredential credential) {},
                            //   verificationFailed: (FirebaseAuthException e) {},
                            //   codeSent: (String verificationId, int? resendToken) {
                            //    // print('verification id is $verificationId');
                            //     },
                            //   codeAutoRetrievalTimeout: (String verificationId) {},  // allows when to resend otp values
                            // );

                            //passwordText=passwordController.text;

                            //print('$emailText');

                            // print('$passwordText');
                          },

                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              'Generate OTP',
                            ),
                          ),
                        ),
                      ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
// floatingActionButton: FloatingActionButton(
//   onPressed: (){
//     setState(() {  // WILL CHANGE VALUE AND REBUILD WIDGET
//   emailText=emailController.text;
//   passwordText=passwordController.text;
//
//
//   });},
//   tooltip: 'Increment',
//    backgroundColor:Colors.red,
//    child: const Icon(Icons.add),
// ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
