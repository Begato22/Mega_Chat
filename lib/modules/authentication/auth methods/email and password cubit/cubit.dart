// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/components/constants.dart';
import 'email_password_states.dart';

class EmailPasswordAuthCubit extends Cubit<EmailPasswordStates> {
  EmailPasswordAuthCubit() : super(EPSignInInitialState());

  static EmailPasswordAuthCubit get(context) => BlocProvider.of(context);

  bool securePassword = true;
  IconData visibleIcon = Icons.visibility;
  void changeVisability() {
    if (securePassword) {
      visibleIcon = Icons.visibility_off;
      securePassword = !securePassword;
    } else {
      visibleIcon = Icons.visibility;
      securePassword = !securePassword;
    }
    emit(EPSignInChangeVisabilityState());
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    emit(EPSignInLodingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);
      uId = value.user!.uid;
      emit(EPSignInSuccessState(value.user!.uid));
    }).catchError((onError) {
      print(onError.toString());
      emit(EPSignInErrorState(onError.toString()));
    });
  }

  Future<void> signOut() async {}
  Future<void> signUp() async {}
}
