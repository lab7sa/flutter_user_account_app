import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'UserData.dart';

class HttpHandler{
  
  var _CREATE_ACCOUNT = Uri.https('www.givethumb.com', '/flutter_projects/CreateAccount.php');
  var _LOGIN = Uri.https('www.givethumb.com', '/flutter_projects/Login.php');
  var _GET_USER_INFO = Uri.https('www.givethumb.com', '/flutter_projects/GetUserInfo.php');

  Future<String> createAccount(String email, String password, String username, String bio) async{
    var map = Map<String, dynamic>();
    map['email'] = email;
    map['password'] = password;
    map['username'] = username;
    map['bio'] = bio;

    try{
      final Response response = await post(_CREATE_ACCOUNT, body: map);
      print('account info: ${response.body}');

      if(response.statusCode == 200){
        //check message
        if(response.body.contains('successfully')){
          print('User account has been created successfully: ${response.body}');

          return 'account created';
        }else{
          return 'email is used';
        }
      }else{
        return 'error posting data';
      }

    }catch(e){
      return e;
    }
  }



  Future loginUser(String email, String password) async{
    var map = Map<String, dynamic>();
    map['email'] = email;
    map['password'] = password;


    try{
      final Response response = await post(_LOGIN, body: map);
      print('account info: ${response.body}');

      if(response.statusCode == 200){
        //check message
        if(response.body.contains('successfully')){

          return UserData.fromJSON(json.decode(response.body));
        }else if(response.body.contains('Email or password is incorrect')){
          return 'incorrect email or password';
        }
      }else if(response.body.contains('This email or password was not posted')){
        return 'error posting data';
      }

    }catch(e){
      return e;
    }
  }




}