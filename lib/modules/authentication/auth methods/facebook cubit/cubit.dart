// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '../../../../models/user model/user_model.dart';
import '../auth_interface.dart';
import 'facebook_states.dart';

class FacebookAuthCubit extends Cubit<FacebookStates>
    implements Authentication {
  FacebookAuthCubit() : super(FBSignInInitialState());

  late UserModel userModel;

  static FacebookAuthCubit get(context) => BlocProvider.of(context);
  final facebookloginInstance = FacebookAuth.instance;
  @override
  Future<void> signIn(context) async {
    emit(FBSignInLodingState());
    final facebookloginResult = await facebookloginInstance.login();
    final userData = await facebookloginInstance.getUserData();
    print(userData.toString());
    userModel = UserModel.fromFacebookJson(userData);
    // context.read().bloc<UserCubit>().userModel = userModel;
    print('from model ${userModel.imgUrl}');
    emit(FBSignInSuccessState(userModel));
    final facebookAuthCredential =
        FacebookAuthProvider.credential(facebookloginResult.accessToken!.token);
    await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    await FirebaseFirestore.instance.collection('users').add(
      {
        'email': userData['email'],
        'imageUrl': userData['picture']['data']['url'],
        'name': userData['name'],
      },
    );
    // ********* hint check uId of facebook user *********
  }

  @override
  Future<void> signOut() async {
    emit(FBSignOutLodingState());
    facebookloginInstance.logOut().then(
      (value) {
        emit(FBSignOutSuccessState());
      },
    ).catchError(
      (onError) {
        emit(FBSignOutErrorState(onError.toString()));
      },
    );
  }

  @override
  Future<void> signUp() {
    throw UnimplementedError();
  }

  // void listen({required Function method}){
  //   method(SignInSuccessState);
  // }
}
