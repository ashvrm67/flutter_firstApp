
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp_flutter/homepage.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
//import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';


class OTPScreen extends StatefulWidget {
   //final firebase_instance; //made for finrebase intance on previous page
   final String phone;
 
   const OTPScreen({super.key,  required this.phone});
  @override
  State<OTPScreen> createState() => _OTPScreenState();

}

class _OTPScreenState extends State<OTPScreen> {
  String otp='';
  late String verificationId;

SnackBar snackBar= SnackBar(content:Text("Please Enter Valid OTP"));

@override
  void initState() {
    // TODO: implement initState
  sendOTP(widget.phone);    // implemented intistate to send otp on inititationals
    super.initState();

  }
   // to display message in the bottom
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title:Text("OTP Screen"),
      ),
      body: Column(
         mainAxisAlignment: MainAxisAlignment.center,
          children:[
            //Text("OTP sent to ${widget.phone} "),

            Padding(
              padding: const EdgeInsets.all(20.0),


              child:

              PinCodeTextField(appContext: context, length: 6, onChanged: (value){
                //print("print value");
                setState((){
                  otp=value;

                });

              },
              keyboardType: TextInputType.number,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: Colors.white,
                ),
              ),
            ),


            ElevatedButton(onPressed: () async { print("verify please");
            print(otp);

            if(otp.length!=6)
            {
              print("invalid otp");
              print(otp);
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
            else {
              print("valid OTP");
              // Update the UI - wait for the user to enter the SMS code
             // String smsCode = otp;    //otp sent to mobile
              // Create a PhoneAuthCredential with the code
              try {
                PhoneAuthCredential credential = PhoneAuthProvider.credential(
                    verificationId: verificationId, smsCode: otp);
                // Sign the user in (or link) with the credential
               UserCredential userObj= await FirebaseAuth.instance.signInWithCredential(credential);
                // userObj.credential.token
               if(userObj.user!=null)
                 {
                   print("user found");

                   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage()));


                 }
               else
                 {
                   print("user not found");

                 }


              }
              catch(e)
              {
                print("wrong OTP $e");
              }
             // FirebaseAuth auth = FirebaseAuth.instance;
              //to authenticate sent otp


               }
            }, child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("Verify OTP"),
            ))






      ]),
    );
    throw UnimplementedError();

  }

  void sendOTP(String phoneNumber) async
  {
    await  FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91'+widget.phone,
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) async {
       this.verificationId= verificationId;
       SnackBar snackBar= SnackBar(content:Text("OTP sent"));
       ScaffoldMessenger.of(context).showSnackBar(snackBar);

      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      verificationCompleted: (PhoneAuthCredential credential) {

        print("verification successful");
      },// allows when to resend otp values

    );
  }
}
