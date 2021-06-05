import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'UserLogin.dart';
import 'HttpHandler.dart';

void main() {
  runApp(CreateAccount());
}

class CreateAccount extends StatelessWidget {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwrodController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _bioController = TextEditingController();
  HttpHandler _handler = HttpHandler();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Builder(builder: (context){
            return Container(
              margin: EdgeInsets.all(37.0),
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [



                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 30),
                    child: Center(
                      child: Text('Create account', style: TextStyle(
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

                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: styleTextField(),
                    ),
                  ),


                  TextField(
                    controller: _bioController,
                    decoration: InputDecoration(
                      labelText: 'Bio',
                      labelStyle: styleTextField(),
                    ),
                  ),


                  SizedBox(height: 40,),

                  Container(
                    height: 57,
                    child: Material(
                      borderRadius: BorderRadius.circular((27)),
                      color: Colors.green,
                      child: GestureDetector(
                        onTap: () async{

                          FocusScopeNode currentFocus = FocusScope.of(context);

                          if(!currentFocus.hasPrimaryFocus){
                            currentFocus.unfocus();
                          }

                          var result = await _handler.createAccount(_emailController.text, _passwrodController.text, _usernameController.text, _bioController.text);

                          print('result: $result' );

                          if(result == 'account created'){
                            _clearTeatField();

                            Navigator.push(context,
                            MaterialPageRoute(builder: (context) => UserLogin()),);

                            _showMessages('your account has been created successfully');

                          }else if(result == 'email is used'){

                            _showMessages('This email is used by someone else');
                          }else if(result == 'error posting data'){
                            _showMessages('Please, try again later...');
                          }



                          //add create account code here
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

                  SizedBox(height: 15,),

                  Container(
                    height: 57,
                    child: TextButton(
                      onPressed: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => UserLogin()));
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



                ],
              ),
            );
          },
          ),
        ),
      ),
    );
  }




  _clearTeatField(){
    _emailController.text = '';
    _passwrodController.text = '';
    _usernameController.text = '';
    _bioController.text = '';
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
