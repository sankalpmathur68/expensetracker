import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial()) {
    User? user = FirebaseAuth.instance.currentUser;
    print(user);
    // UserCredential usercredential = FirebaseAuth.instance.currentUser;
    if (user != null) {
      emit(Authenticated(user));
    } else {
      emit(AuthRegister());
    }
  }
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  String email_cubit = '';
  String password_cubit = '';
  String rePassword_cubit = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;

  signInWithEmailAndPassword(String email, String password) async {
    emit(AuthLoading());
    Future.delayed(const Duration(seconds: 2), () async {
      try {
        UserCredential? userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        emit(Authenticated(userCredential.user));
      } catch (e) {
        emit(Autherror(err: "$e"));

        log("Error signing in: $e");
        return null;
      }
    });
  }

  // Register with email and password
  registerWithEmailAndPassword(String email, String password) async {
    emit(AuthLoading());
    Future.delayed(const Duration(seconds: 2), () async {
      try {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        emit(Authenticated(userCredential.user));

        return userCredential;
      } catch (e) {
        emit(Autherror(err: "$e"));

        log("Error registering user: $e");
        return null;
      }
    });
  }

  register() {
    emit(AuthRegister());
  }

  // Sign out
  Future<void> signOut() async {
    emit(AuthLoading());
    await _auth.signOut();

    Future.delayed(const Duration(seconds: 2), () {
      emit(NotAuthenticated('', ''));
    });
  }
}

class AuthInitial extends AuthState {}

class AuthRegister extends AuthState {}

class Authenticated extends AuthState {
  User? user;
  Authenticated(this.user);
}

class AuthLoading extends AuthState {}

class NotAuthenticated extends AuthState {
  String email;
  String password;
  NotAuthenticated(this.email, this.password);
}

class Autherror extends AuthState {
  String err;
  Autherror({required this.err});
}

class AuthState {}
