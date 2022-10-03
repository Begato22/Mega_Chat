abstract class GmailStates {}

class SignInInitialState extends GmailStates {}

class SignInLodingState extends GmailStates {}

class SignInSuccessState extends GmailStates {
  SignInSuccessState(this.uId);
  String uId;
}

class SignInErrorState extends GmailStates {
  final String error;

  SignInErrorState(this.error);
}

class SignOutLodingState extends GmailStates {}

class SignOutSuccessState extends GmailStates {}

class SignOutErrorState extends GmailStates {
  final String error;

  SignOutErrorState(this.error);
}

class SignInChangeVisabilityState extends GmailStates {}
