import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  String user_id, username, email, bio;


  UserProfile(this.user_id, this.username, this.email, this.bio);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('User profile'),
        ),

        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text('User ID: $user_id', style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),),

                Text('Username: $username', style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),),

                Text('Email: $email', style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),),

                Text('Bio: $bio', style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
