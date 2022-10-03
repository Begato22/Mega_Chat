// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mega_chat/modules/authentication/auth%20methods/auth%20cubit/states.dart';

import '../../../../models/user model/user_model.dart';
import '../../../../shared/components/constants.dart';
import '../facebook cubit/cubit.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(SignInInitialState());

  static AuthCubit get(context) => BlocProvider.of(context);

  bool securassword = true;
  IconData visibleIcon = Icons.visibility;
  void changeVisability() {
    if (securassword) {
      visibleIcon = Icons.visibility_off;
      securassword = !securassword;
    } else {
      visibleIcon = Icons.visibility;
      securassword = !securassword;
    }
    emit(SignInChangeVisabilityState());
  }

  late UserModel userModel;

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(SignInLodingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);
      uId = value.user!.uid;
      emit(SignInSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(SignInErrorState(onError.toString()));
    });
  }

  Future<void> signOutWithEmailAndPassword() async {}
  Future<void> signUpWithEmailAndPassword() async {}

  final facebookloginInstance = FacebookAuth.instance;
  Future<void> signInWithFacebook(context) async {
    emit(SignInLodingState());
    final facebookloginResult = await facebookloginInstance.login();
    final userData = await facebookloginInstance.getUserData();
    print(userData.toString());
    userModel = UserModel.fromFacebookJson(userData);
    userModel.loginMethod = LoginMethod.facebook;
    // context.read().bloc<UserCubit>().userModel = userModel;
    print('from model ${userModel.imgUrl}');
    emit(SignInSuccessState());
    // final facebookAuthCredential =
    //     FacebookAuthProvider.credential(facebookloginResult.accessToken!.token);
    // await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    // await FirebaseFirestore.instance.collection('users').add(
    //   {
    //     'email': userData['email'],
    //     'imageUrl': userData['picture']['data']['url'],
    //     'name': userData['name'],
    //   },
    // );
    // ********* hint check uId of facebook user *********
  }

  Future<void> signOutWithFacebook() async {
    emit(SignOutLodingState());
    facebookloginInstance.logOut().then(
      (value) {
        emit(SignOutSuccessState());
      },
    ).catchError(
      (onError) {
        emit(SignOutErrorState(onError.toString()));
      },
    );
  }

  Future<void> signUpWithFacebook() {
    // TODO: implement signUp
    throw UnimplementedError();
  }

  var googleSignIn = GoogleSignIn();
  Future<void> signInWithGmail(context) async {
    emit(SignInLodingState());
    print('before');
    await googleSignIn.signIn().then(
      (value) {
        print("all user data ${value.toString()}");
        userModel = UserModel.fromGoogleJson(value);
        userModel.loginMethod = LoginMethod.google;
        // ********* hint check uId of facebook user *********
        emit(SignInSuccessState());
      },
    ).catchError(
      (onError) {
        print("errrrrr ${onError.toString()}");
        emit(SignInErrorState(onError.toString()));
      },
    );
  }

  Future<void> signOutWithGmail() async {
    emit(SignOutLodingState());
    googleSignIn.signOut().then(
      (value) {
        emit(SignOutSuccessState());
      },
    ).catchError(
      (onError) {
        emit(SignOutErrorState(onError.toString()));
      },
    );
  }

  Future<void> signUpWithGmail() {
    // TODO: implement signUp
    throw UnimplementedError();
  }
}
