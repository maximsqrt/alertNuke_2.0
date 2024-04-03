
import 'package:alertnukeapp_ver2/src/Services/firebaseuserdata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationSignupService {
  String? password;
  String? email;
  String? repeatPassword;
  String? username;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _instance = FirebaseFirestore.instance;

  Future<bool> signUp() async {
    try {
      // if (authenticationService.email != repeatedEmail) {
      //   throw Exception('Email is already used');
      // }
      if (password == null || email == null) {
        throw Exception('Email or password is missing');
      }
      if (password != repeatPassword) {
        throw Exception('Passwords do not match');
      }

      // Create user with email and password
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      if (userCredential.user != null) {
        await _instance.collection("users").doc(userCredential.user!.uid).set({
          "email": email,
          "username": username,
        });
        FirebaseUserData.email = email!;
        FirebaseUserData.username = username!;
        return true;
      }
      return false; //If Signup = Success
    } catch (e) {
      print('Error SignIn: U Suck!$e');
    }

    return false;
  }
}

// In the catch block of a try-catch statement in Dart,
//  e represents the exception object that was thrown
//  when an error occurred within the try block.
//  When an exception is thrown, Dart creates an
//  instance of the Exception class (or a subclass of Exception)
//  containing information about the error.
