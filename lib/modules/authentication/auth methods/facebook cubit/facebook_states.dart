import '../../../../models/user model/user_model.dart';

abstract class FacebookStates {}

class FBSignInInitialState extends FacebookStates {}

class FBSignInLodingState extends FacebookStates {}

class FBSignInSuccessState extends FacebookStates {
  final UserModel userModel;
  FBSignInSuccessState(this.userModel);
}

class FBSignInErrorState extends FacebookStates {
  final String error;

  FBSignInErrorState(this.error);
}

class FBSignOutLodingState extends FacebookStates {}

class FBSignOutSuccessState extends FacebookStates {}

class FBSignOutErrorState extends FacebookStates {
  final String error;

  FBSignOutErrorState(this.error);
}
