import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:users/global/global.dart';
import 'package:users/screens/main_page.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameTextEditingController = TextEditingController();
  final emailTextEditingController = TextEditingController();
  final phoneTextEditingController = TextEditingController();
  final addressTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  final confirmTextEditingController = TextEditingController();

  bool _passwordVisible = false;

  final _formKey = GlobalKey<FormState>();

  void _submit() async{

     if( _formKey.currentState!.validate()) {
       await firebaseAuth.createUserWithEmailAndPassword(
           email: emailTextEditingController.text.trim(),
           password: passwordTextEditingController.text.trim()

       ).then((auth) async {
         currentUser = auth.user;

         if (currentUser != null) {
           Map userMap = {
             "id": currentUser!.uid,
             "name": nameTextEditingController.text.trim(),
             "email": emailTextEditingController.text.trim(),
             "phone": phoneTextEditingController.text.trim(),
             "address": addressTextEditingController.text.trim(),


           };

           DatabaseReference userRef =
           FirebaseDatabase.instance.ref().child("users");
           userRef.child(currentUser!.uid).set(userMap);

           await Fluttertoast.showToast(msg: "Successfully Registered");

           Navigator.push(
               context, MaterialPageRoute(builder: (t) => MainScreen()));
         }
       }).catchError((errorMessage) {
         Fluttertoast.showToast(msg: "Error Occurred: \n $errorMessage");
       });
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
                  "Register Here",
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

                          inputFormatters:[

                            LengthLimitingTextInputFormatter(56),

                          ],
                          
                          decoration: InputDecoration(

                              hintText: "Name",

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



                ),

                       prefixIcon: Icon(Icons.person, color: darkTheme ? Colors.amber.shade400: Colors.grey,)     


                          ),


                          autovalidateMode: AutovalidateMode.onUserInteraction,

                           validator : (text){


                            if(text == null || text.isEmpty) {

                              return "Name cannot be empty";

                            }

                           if(text.length < 2) {

                             return "please enter a valid name ";
                           }
                            if(text.length > 49) {

                              return "Name cannot be more than 49 ";
                            }

                           },

          
                        onChanged: (text) => setState(() {

                        nameTextEditingController.text = text;


                        }




                        ),

                        ),
                        
                        
                        SizedBox(height: 20,),

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



                      IntlPhoneField(

                        showCountryFlag: false,
                        dropdownIcon:Icon(Icons.arrow_drop_down,
                        color:darkTheme ? Colors.amber.shade400: Colors.grey,



                      ),

                        decoration: InputDecoration(

                            hintText: "Phone",

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



                            ),



                        ),


                        initialCountryCode: "CM",

                        onChanged: (text) => setState(() {

                          phoneTextEditingController.text = text.completeNumber;


                        }

                      ),




),


                        SizedBox(height: 20,),

                        TextFormField(



                          decoration: InputDecoration(

                              hintText: "Address",

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



                              ),

                              prefixIcon: Icon(Icons.person, color: darkTheme ? Colors.amber.shade400: Colors.grey,)


                          ),


                          autovalidateMode: AutovalidateMode.onUserInteraction,

                          validator : (text){


                            if(text == null || text.isEmpty) {

                              return "Address cannot be empty";

                            }

                            if(text.length < 2) {

                              return "please enter a valid address ";
                            }
                            if(text.length > 49) {

                              return "adress cannot be more than 49 ";
                            }

                          },


                          onChanged: (text) => setState(() {

                            addressTextEditingController.text = text;


                          }




                          ),

                        ),





                        SizedBox(height: 20,),






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

                        TextFormField(

                          obscureText: !_passwordVisible,
                          decoration:
                          InputDecoration(
                            
                            
                             hintText: "Confirm Password",

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

                              return "please enter a confirm passwordd ";
                            }
                            if(text.length > 49) {

                              return "password cannot be more than 49 ";
                            }

                          },


                          onChanged: (text) => setState(() {

                            confirmTextEditingController.text = text;


                          }




                          ),



                        ),
                        SizedBox(height: 20),
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
                          Text("Register", style:
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

                              "Have an account",
                              style:TextStyle(
                                color: Colors.grey,
                                fontSize: 15,

                              ),

                            ),

                            SizedBox(width: 5,),

                            GestureDetector(

                              onTap: () {},

                              child: Text(
                                "Sign In",
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
