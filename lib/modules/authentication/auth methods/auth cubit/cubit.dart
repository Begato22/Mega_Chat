// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mega_chat/modules/authentication/auth%20methods/auth%20cubit/states.dart';

import '../../../../models/user model/user_model.dart';
import '../../../../shared/components/constants.dart';

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

  Future<void> createUser({
    required String name,
    required String email,
    required String uid,
    String? cover,
    String? imageUrl,
    String? phone,
  }) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'name': name,
      'email': email,
      'uid': uid,
      'cover': cover ??
          'https://timelinecovers.pro/facebook-cover/download/oh-wow-sarcastic-facebook-cover.jpg',
      'imageUrl': imageUrl ??
          'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=740&t=st=1664890049~exp=1664890649~hmac=d0051e6c4e9f238987ba4326c6e13483b0126edd42b2df72dc6279219fbf8794',
      'phone': phone ?? '01 **** ** ***',
    }).then(
      (value) {
        emit(CreateUserSuccessState());
      },
    ).catchError(
      (onError) {
        emit(CreateUserErrorState(onError.toString()));
      },
    );
  }

  Future<void> getUserFromFireStore(value) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(value.user!.uid)
        .get()
        .then(
      (value) {
        userModel = UserModel.fromJson(value.data());
      },
    );
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(SignInLodingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      print(value.user!.email);
      uId = value.user!.uid;
      FirebaseFirestore.instance
          .collection('users')
          .doc(value.user!.uid)
          .get()
          .then(
        (value) {
          userModel = UserModel.fromJson(value.data());
          userModel.loginMethod = LoginMethod.normal;
          print("done");
          emit(SignInSuccessState());
        },
      ).catchError((onError) {
        print(onError.toString());
      });
    }).catchError((onError) {
      print(onError.toString());
      emit(SignInErrorState(onError.toString()));
    });
  }

  Future<void> signOutWithEmailAndPassword() async {
    emit(SignOutLodingState());
    FirebaseAuth.instance.signOut().then(
      (value) {
        emit(SignOutSuccessState());
      },
    ).catchError(
      (onError) {
        emit(SignOutErrorState(onError.toString()));
      },
    );
  }

  Future<void> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    emit(SignUpLodingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then(
      (value) {
        createUser(
            name: name, email: email, uid: value.user!.uid, phone: phone);
        FirebaseFirestore.instance
            .collection('users')
            .doc(value.user!.uid)
            .get()
            .then(
          (value) {
            userModel = UserModel.fromJson(value.data());
            userModel.loginMethod = LoginMethod.normal;
          },
        );
        emit(SignUpSuccessState());
      },
    ).catchError(
      (onError) {
        emit(SignUpErrorState(onError.toString()));
      },
    );
  }

  final facebookAuthInstance = FacebookAuth.instance;
  Future<void> signInWithFacebook(context) async {
    emit(SignInLodingState());

    facebookAuthInstance.getUserData().then((value) async {
      await facebookAuthInstance.login();
      FirebaseFirestore.instance
          .collection('users')
          .doc(value['id'])
          .get()
          .then(
        (value) {
          userModel = UserModel.fromJson(value.data());
          // emit(GetUserSuccessState());
          emit(SignInSuccessState());
        },
      ).catchError((onError) {
        emit(SignInErrorState(onError.toString()));
      });
    });
  }

  Future<void> signOutWithFacebook() async {
    emit(SignOutLodingState());
    facebookAuthInstance.logOut().then(
      (value) {
        emit(SignOutSuccessState());
      },
    ).catchError(
      (onError) {
        emit(SignOutErrorState(onError.toString()));
      },
    );
  }

  Future<void> signUpWithFacebook() async {
    emit(SignUpLodingState());
    facebookAuthInstance.getUserData().then((value) async {
      await createUser(
        name: value['name'],
        email: value['email'],
        uid: value['id'],
        imageUrl: value['picture']['data']['url'],
      );
      emit(SignUpSuccessState());
    }).catchError((onError) {
      emit(SignUpErrorState(onError.toString()));
    });
  }

  var googleSignIn = GoogleSignIn();
  Future<void> signInWithGmail(context) async {
    emit(SignInLodingState());
    await googleSignIn.signIn().then(
      (value) async {
        FirebaseFirestore.instance
            .collection('users')
            .doc(value!.id)
            .get()
            .then(
          (value) {
            userModel = UserModel.fromJson(value.data());
            userModel.loginMethod = LoginMethod.google;
            emit(SignInSuccessState());
          },
        ).catchError((onError) {
          emit(SignInErrorState(onError.toString()));
        });
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

  Future<void> signUpWithGmail() async {
    emit(SignUpLodingState());
    googleSignIn.signIn().then(
      (value) async {
        await createUser(
          name: value!.displayName!,
          email: value.email,
          uid: value.id,
          imageUrl: value.photoUrl,
        );
        // await FirebaseFirestore.instance
        //     .collection('users')
        //     .doc(value.id)
        //     .get()
        //     .then(
        //   (value) {
        //     userModel = UserModel.fromJson(value.data());
        //     userModel.loginMethod = LoginMethod.google;
        //     emit(GetUserSuccessState());
        //   },
        // ).catchError((onError) {
        //   emit(GetUserErrorState());
        // });
        emit(SignUpSuccessState());
      },
    ).catchError(
      (onError) {
        print("errrrrr ${onError.toString()}");
        emit(SignUpErrorState(onError.toString()));
      },
    );
  }

  Future pickImage() async {
    await ImagePicker().pickImage(source: ImageSource.gallery);
  }
}
