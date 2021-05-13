import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetest/user_info_screen.dart';
import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final uidController = TextEditingController();
  final repassController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'abc@gmail.com'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: passController,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Password'),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
              child: TextField(
                controller: repassController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Confirm Password',
                    hintText: 'Confirm Password'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: uidController,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                    hintText: 'Username'),
              ),
            ),
            ElevatedButton(onPressed: () async {
              FirebaseAuth auth = FirebaseAuth.instance;
                Future<UserCredential> _user = auth.createUserWithEmailAndPassword(
                  email: emailController.text, password: repassController.text
                );
                UserCredential __user = await auth.signInWithEmailAndPassword(email: emailController.text, password: repassController.text);
                User? user = __user.user;

            if (user != null) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => UserInfoScreen(
                  user: user,
                  ),
                ),
              );
            }
            }, child: Text('Sign Up')),
          ],          
        ),
      ),

    );    
  }
}