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
                var userCredential = await signInWithGoogle();
                addUserToDatabase(userCredential);
              },
            ),
            SizedBox(
              height: 5.0,
            ),
            SignInButton(
              buttonType: ButtonType.github,
              buttonSize: ButtonSize.medium,
              onPressed: () async {
                var userCredential = await signInWithGitHub(context);
                addUserToDatabase(userCredential);
              },
            ),
          ],
        ),
      ),
    );
  }
}

// GoogleProvider(
//   clientId: '660748519011-1v2plsvbsnkb8a9ulds6a15polrm5fsl.apps.googleusercontent.com',
// ),
// GithubProvider(
//   clientId: 'Ov23liHMgBSSJ5Hhr3G2',
//   clientSecret: '24e44f2ab43571863259877f1004fa29eb43c676',
//   callbackUrl: 'https://my-cool-project-45922.firebaseapp.com/__/auth/handler',
// ),
