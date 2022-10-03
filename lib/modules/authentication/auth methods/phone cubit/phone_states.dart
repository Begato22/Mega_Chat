abstract class PhoneStates {}

class SignInInitialState extends PhoneStates {}

class SignInLodingState extends PhoneStates {}

class SignInSuccessState extends PhoneStates {
  SignInSuccessState(this.uId);
  String uId;
}

class SignInErrorState extends PhoneStates {
  final String error;

  SignInErrorState(this.error);
}

class SignOutLodingState extends PhoneStates {}

class SignOutSuccessState extends PhoneStates {}

class SignOutErrorState extends PhoneStates {
  final String error;

  SignOutErrorState(this.error);
}

class SignInChangeVisabilityState extends PhoneStates {}
