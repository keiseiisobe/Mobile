import 'package:flutter/material.dart';
import 'package:sign_button/sign_button.dart';
import '../view_model/login_viewmodel.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            SignInButton(
              buttonType: ButtonType.google,
              buttonSize: ButtonSize.medium,
              onPressed: () async {
                try {
                  var userCredential = await signInWithGoogle();
                  addUserToDatabase(userCredential);
                } catch (e) {
                  print('Error signing in with Google: $e');  
                }
              },
            ),
            SizedBox(
              height: 5.0,
            ),
            SignInButton(
              buttonType: ButtonType.github,
              buttonSize: ButtonSize.medium,
              onPressed: () async {
                try {
                  var userCredential = await signInWithGitHub(context);
                  addUserToDatabase(userCredential);
                } catch (e) {
                  print('Error signing in with GitHub: $e');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
