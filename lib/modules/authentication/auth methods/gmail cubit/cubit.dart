import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../shared/components/constants.dart';
import '../../auth_interface.dart';
import 'gmail_states.dart';

class GmailAuthCubit extends Cubit<GmailStates> implements Authentication {
  GmailAuthCubit() : super(SignInInitialState());

  static GmailAuthCubit get(context) => BlocProvider.of(context);

  var googleSignIn = GoogleSignIn();
  @override
  Future<void> signIn(context) async {
    emit(SignInLodingState());
    googleSignIn.signIn().then(
      (value) {
        print("all user data ${value.toString()}");
        // ********* hint check uId of facebook user *********
        emit(SignInSuccessState(uId));
      },
    ).catchError(
      (onError) {
        emit(SignInErrorState(onError.toString()));
      },
    );
  }

  @override
  Future<void> signOut() async {
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

  @override
  Future<void> signUp() {
    // TODO: implement signUp
    throw UnimplementedError();
  }
}
