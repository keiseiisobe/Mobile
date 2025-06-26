import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:github_sign_in/github_sign_in.dart';

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

  // Create a new provider
  final credential = GithubAuthProvider.credential(result.token!);
  return await FirebaseAuth.instance.signInWithCredential(credential);
  // return await FirebaseAuth.instance.signInWithProvider(githubProvider);
}  

