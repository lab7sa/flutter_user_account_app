import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'main.dart';
import 'HttpHandler.dart';
import 'UserProfile.dart';

class UserLogin extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwrodController = TextEditingController();
  HttpHandler _handler = HttpHandler();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Builder(builder: (context){
          return SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(37.0),
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [


                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 30),
                    child: Center(
                      child: Text('Login', style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),),
                    ),
                  ),

                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'email@xxxx.com',
                      labelStyle: styleTextField(),
                    ),
                  ),


                  TextField(
                    obscureText: true,
                    controller: _passwrodController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: styleTextField(),
                    ),
                  ),


                  SizedBox(height: 40,),

                  Container(
                    height: 57,
                    child: TextButton(
                      onPressed: ()async{

                        FocusScopeNode currentFocus = FocusScope.of(context);

                        if(!currentFocus.hasPrimaryFocus){
                          currentFocus.unfocus();
                        }

                        
                        var result = await _handler.loginUser(_emailController.text, _passwrodController.text);

                        print('result: $result');

                        if(result != 'incorrect email or password' && result != 'error posting data'){
                          _showMessages('Logged in successfully');

                          Navigator.push(context,
                          MaterialPageRoute(builder: (context)=> UserProfile(result.id, result.username, result.email, result.bio)),);

                        }else if(result == 'incorrect email or password'){
                          _showMessages('incorrect email or password');

                        }else if(result == 'error posting data'){
                          _showMessages('Please try again');
                        }

                      },
                      child: Text('LOGIN',style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),),

                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(side: BorderSide(
                          color: Colors.black,
                          width: 2,
                          style: BorderStyle.solid,
                        ),borderRadius: BorderRadius.circular(30)),
                      ),
                    ),

                  ),

                  SizedBox(height: 15,),

                  Container(
                    height: 57,
                    child: Material(
                      borderRadius: BorderRadius.circular((27)),
                      color: Colors.green,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => CreateAccount()));
                        },
                        child: Center(
                          child: Text('SIGNUP', style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),),
                        ),


                      ),
                    ),
                  ),



                ],
              ),
            ),
          );
        },
        ),
      ),
    );
  }






  _clearTeatField(){
    _emailController.text = '';
    _passwrodController.text = '';

  }



  TextStyle styleTextField(){
    return TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.grey,
    );
  }

  _showMessages(String message){
    Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
  }


}
