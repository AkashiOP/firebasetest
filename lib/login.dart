import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetest/authentication.dart';
import 'package:firebasetest/signup.dart';
import 'package:firebasetest/user_info_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebasetest/google_sign_in_button.dart';


class LoginV2 extends StatelessWidget {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Login'),),
      ),
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
            ElevatedButton(
              child: Text('Sign In'),
              onPressed: () async {
                try {
                      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: emailController.text,
                        password: passController.text,
                     );
                     User? user = userCredential.user;
                     if (user != null) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => UserInfoScreen(
          user: user,
        ),
      ),
    );
  }
                     
                    } on FirebaseAuthException catch (e) {
                if (e.code == 'user-not-found') {
                  CupertinoAlertDialog(
                    title: Text('Error!'),
                    content: Text('No such user found.Create an account now.'),
                    actions: [
                      CupertinoDialogAction(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                            builder: (context) => SignUp(),
                            ),
                          );
                        },
                         child: Text('Create Account')),                      
                    ],

                  );
                } 
                else if (e.code == 'wrong-password') {
                  CupertinoAlertDialog(
                    title: Text('Error!'),
                    content: Text('E-mail and password are not matching.Please check.'),
                    actions: [
                      CupertinoDialogAction(onPressed: () {}, child: Text('OK')),
                    ],
                  );
                }
              }

              }
            ),
            TextButton(
              onPressed: (){
                //TODO FORGOT PASSWORD SCREEN GOES HERE
              },
              child: Text(
                'Forgot Password',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
            FutureBuilder(
                future: Authentication.initializeFirebase(context: context),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error initializing Firebase');
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return GoogleSignInButton();
                  }
                  return CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.orange,
                    ),
                  );
                },
              ),
            SizedBox(
              height: 130,
            ),

            TextButton(onPressed: () {
              Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => SignUp(),
      ),
    );              
            }, child: Text('New User? Create Account')),
          ],
        ),
      ),
      
    );
  }
}