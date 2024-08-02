import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthServices extends ChangeNotifier {
  String? errorMassage;
  Future<String?> signIn({required String email,required String password})async{
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    return null;
    } on FirebaseAuthException catch (e) {
      errorMassage = e.message!;
      return e.message!;
    }
  }

  Future<String?> signUp({required String email,required String password})async{
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    return null;
    } on FirebaseAuthException catch (e) {
      errorMassage = e.message!;
      return e.message!;
    }
  }
}