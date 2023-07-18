import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:users/global/global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:users/screens/login_screen.dart';

import 'main_page.dart';


class ForgotPassword extends StatefulWidget {

  final _formKey = GlobalKey<FormState>();

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {



  final emailTextEditingController = TextEditingController();




  bool _passwordVisible = false;

  final _formKey = GlobalKey<FormState>();


  void _onSUbmit(){
    firebaseAuth.sendPasswordResetEmail(email: emailTextEditingController.text.trim())
        .then((value) {
      Fluttertoast.showToast(msg: "We have sent you a password resend email ");
    })
        .catchError((error) {

      Fluttertoast.showToast(msg: "Error Message: \n \${error.toString()}");

    });
  }




  @override
  Widget build(BuildContext context) {


    bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return GestureDetector(

      onTap: () {

        FocusScope.of(context).unfocus();


      },


      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.all(8.0),
          children: [
            Column(
              children: [
                Image.asset(darkTheme ? 'images/car_android.dark.jpg' : 'images/car_android.jpg'),
                SizedBox(height: 20),
                Text(
                  "Forgot Password",
                  style: TextStyle(
                    color: darkTheme ? Colors.amber.shade400 : Colors.blue,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(

                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [

                        TextFormField(

                          decoration: InputDecoration(


                            hintText: "Email",

                            hintStyle: TextStyle(

                              color: Colors.grey,

                            ),


                            filled:true,
                            fillColor: darkTheme ? Colors.black45: Colors.grey.shade200,

                            border: OutlineInputBorder(

                              borderRadius:BorderRadius.circular(40),
                              borderSide: BorderSide(

                                width: 0,
                                style: BorderStyle.none,

                              ),

                            ),

                          ),


                          autovalidateMode: AutovalidateMode.onUserInteraction,

                          validator : (text){


                            if(text == null || text.isEmpty) {

                              return "Email cannot be empty";

                            }

                            if(text.length < 2) {

                              return "please enter a valid name ";
                            }


                            if(EmailValidator.validate(text) == true){

                              return null;

                            }

                            if(text.length > 99) {

                              return "Email cannot be more than 99 ";
                            }

                          },


                          onChanged: (text) => setState(() {

                            emailTextEditingController.text = text;


                          }

                          ),
                        ),




                        SizedBox(height: 20,),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(

                            backgroundColor: darkTheme ? Colors.amber: Colors.blue,

                            foregroundColor: darkTheme ? Colors.black: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(

                              borderRadius: BorderRadius.circular(32),
                            ),

                            minimumSize:Size(double.infinity, 50) ,

                          ),
                          onPressed: () {

                              _onSUbmit();

                          },
                          child:
                          Text("Reset Password Link", style:
                          TextStyle(fontSize:
                          20, fontWeight:
                          FontWeight.bold)),
                        ),


                        SizedBox(height: 20,),

                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            "Forgot Password",
                            style:TextStyle(
                              color: darkTheme ? Colors.amber.shade400: Colors.blue,

                            ) ,
                          ),
                        ),

                        SizedBox(height: 20,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center ,

                          children: [
                            Text(

                              "Already have  an account",
                              style:TextStyle(
                                color: Colors.grey,
                                fontSize: 15,

                              ),

                            ),

                            SizedBox(width: 5,),

                            GestureDetector(

                              onTap: () {

                                Navigator.push(context, MaterialPageRoute(builder: (c) => LoginScreen()));
                              },

                              child: Text(
                                "Login",
                                style: TextStyle(
                                    fontSize:15,
                                    color: darkTheme ? Colors.amber.shade400: Colors.blue
                                ),

                              ),

                            )
                          ],
                        )

                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),

    );
  }
}
