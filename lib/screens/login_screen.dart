import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:users/global/global.dart';
import 'package:users/screens/forgot_password.dart';
import 'package:users/screens/main_page.dart';
import 'package:users/screens/register_screen.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  final emailTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();



  bool _passwordVisible = false;

  final _formKey = GlobalKey<FormState>();


  void _submit() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential auth = await firebaseAuth.signInWithEmailAndPassword(
            email: emailTextEditingController.text.trim(),
            password: passwordTextEditingController.text.trim());
        currentUser = auth.user;
        await Fluttertoast.showToast(msg: "Successfully Registered");
        Navigator.push(context, MaterialPageRoute(builder: (c) => MainScreen()));
      } catch (errorMessage) {
        Fluttertoast.showToast(msg: "Error Occurred: \n $errorMessage");
      }
    } else {
      Fluttertoast.showToast(msg: "Not all fields are required");
    }
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
                  "Login",
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



                        TextFormField(

                          obscureText: !_passwordVisible,
                          decoration:
                          InputDecoration(


                            hintText: "Password",

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

                                )

                            )



                            , suffixIcon:
                          IconButton(icon:
                          Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off),
                            onPressed:
                                () => setState(() => _passwordVisible = !_passwordVisible),
                          ),
                          ),


                          autovalidateMode: AutovalidateMode.onUserInteraction,

                          validator : (text){


                            if(text == null || text.isEmpty) {

                              return "Password cannot be empty";

                            }

                            if(text.length < 2) {

                              return "please enter a valid passwordd ";
                            }
                            if(text.length > 49) {

                              return "password cannot be more than 49 ";
                            }

                          },


                          onChanged: (text) => setState(() {

                            passwordTextEditingController.text = text;


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

                         _submit();

                          },
                          child:
                          Text("Login", style:
                          TextStyle(fontSize:
                          20, fontWeight:
                          FontWeight.bold)),
                        ),


                        SizedBox(height: 20,),

                        GestureDetector(
                          onTap: () {

                            Navigator.push(context, MaterialPageRoute(builder: (c) => ForgotPassword()));


                          },
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

                              "Doesn't have  an account",
                              style:TextStyle(
                                color: Colors.grey,
                                fontSize: 15,

                              ),

                            ),

                            SizedBox(width: 5,),

                            GestureDetector(

                              onTap: () {

                                Navigator.push(context, MaterialPageRoute(builder: (c) => RegisterScreen()));

                              },

                              child: Text(
                                "Register",
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
