

import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileModel{
  Timestamp ? createdAt;
  String ? userName;
  String ? image;
  String ? password;
  String ? email;
  String ? uId;


  ProfileModel(
      { this.createdAt,
       this.userName,
       this.password,
       this.email,
       this.uId,
        this.image
      });

  factory ProfileModel.jsonDate(date){
    return ProfileModel(
      uId: date['UId'],
      email: date['Email'],
      password: date['Password'],
      userName: date['UserName'],
      image: date['Image'],
      createdAt: date['CreatedAt'],
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'Email':email,
      'UId':uId,
      'Password':password,
      'UserName':userName,
      'Image':image,
      'CreatedAt':createdAt,
    };
  }
}