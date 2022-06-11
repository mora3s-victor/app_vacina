import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'user_local.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class UserServices {
  UserLocal? userLocal;

  Future<void> signIn(
    UserLocal userLocal, {
    required Function? onSuccess,
    required Function? onFail,
  }) async {
    try {
      User? user = (await _auth.signInWithEmailAndPassword(
              email: userLocal.email!, password: userLocal.password!))
          .user;
      this.userLocal = userLocal;
      this.userLocal!.id = user!.uid;

      //FUNÇÃO CALLBACK
      onSuccess!();
    } on PlatformException catch (e) {
      onFail!(debugPrint(e.toString()));
    }
  }

  Future<void> signUp(
    UserLocal userLocal, {
    required Function? onSuccess,
    required Function? onFail,
  }) async {
    try {
      User? user = (await _auth.createUserWithEmailAndPassword(
              email: userLocal.email!, password: userLocal.password!))
          .user;
      this.userLocal = userLocal;
      this.userLocal!.id = user!.uid;
      onSuccess!();
    } catch (e) {
      onFail!(e);
    }
  }
}
