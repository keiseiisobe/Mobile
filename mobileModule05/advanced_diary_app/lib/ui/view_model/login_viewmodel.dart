import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:github_sign_in/github_sign_in.dart';
import '../../../main.dart';

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

Future<UserCredential> signInWithGitHub(BuildContext context) async {
  final GitHubSignIn gitHubSignIn = GitHubSignIn(
    clientId: 'Ov23liHMgBSSJ5Hhr3G2',
    clientSecret: '79041f5178f00f7385e2f30c1ee841d0ce37af28',
    redirectUrl: 'https://my-cool-project-45922.firebaseapp.com/__/auth/handler',
  );
  var result = await gitHubSignIn.signIn(context);

  final credential = GithubAuthProvider.credential(result.token!);
  return await FirebaseAuth.instance.signInWithCredential(credential);
}  

void addUserToDatabase(UserCredential userCredential) {
  db.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).get().then((doc) {
    if (!doc.exists) {
      db.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).set({
        'name': userCredential.user?.displayName
          ?? 'Anonymous',
        'email': userCredential.user?.email
          ?? userCredential.additionalUserInfo?.profile?['email']
          ?? userCredential.user?.providerData[0].email
          ?? 'No email',
        'photoURL': userCredential.user?.photoURL
          ?? 'https://www.gravatar.com/avatar',
        'createdAt': DateTime.now(),
      });
    }
  }).catchError((error) {
    print("Failed to add user: $error");
  });
}