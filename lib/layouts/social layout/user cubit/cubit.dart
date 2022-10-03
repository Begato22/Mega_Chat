// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mega_chat/layouts/social%20layout/user%20cubit/states.dart';

import '../../../models/user model/user_model.dart';

class UserCubit extends Cubit<UserStates> {
  // final FacebookAuthCubit facebookAuthCubit;
  // late StreamSubscription facebookAuthBlocSubscription;

  UserModel? userModel;

  UserCubit() : super(UserInisialStates());

  // {
  //   facebookAuthBlocSubscription = facebookAuthCubit.stream.listen((state) {
  //     print('aaaaaaaaaaaa ${state.toString()}');
  //     if (state is FBSignInSuccessState) {
  //       userModel = state.userModel;
  //     }
  //   });
  // }

  static UserCubit get(context) => BlocProvider.of(context);

  void getUser() {
    // emit(GetUserLoading());
    // FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
    //   userModel = UserModel.fromJson(value.data());
    //   print("userModel userModel");
    //   emit(GetUserSuccess());
    // }).catchError((onError) {
    //   emit(GetUserError());
    //   print(onError.toString());
    // });
  }
}
