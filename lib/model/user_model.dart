
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class UserModel{
  String? id;
  String? name;
  String? phone;
  String? address;
  String? email;


     UserModel({

     this.id,
     this.name,
     this.email,
     this.phone,
     this.address,

});

     UserModel.fromSnapshop(DataSnapshot snap){

       id = snap.key;
       name = (snap.value as dynamic)["name"];
       email = (snap.value as dynamic)["email"];
       phone = (snap.value as dynamic)["phone"];
       address = (snap.value as dynamic)["address"];


     }


}