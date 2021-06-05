import 'package:flutter/cupertino.dart';

class UserData{
  final String id;
  final String username;
  final String email;
  final String bio;

  UserData({@required this.id, @required this.username, @required this.email, @required this.bio});

  factory UserData.fromJSON(Map<String, dynamic> json){
    return UserData(
      id: json['result'][0]['id'],
      username: json['result'][0]['username'],
      email: json['result'][0]['email'],
      bio: json['result'][0]['bio'],
    );
  }
}