// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mega_chat/layouts/social%20layout/social%20cubit/states.dart';

import '../../../models/user model/user_model.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInisialStates());
  static SocialCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;
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
