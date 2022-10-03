abstract class AuthStates {}

class SignInInitialState extends AuthStates {}

class SignInLodingState extends AuthStates {}

class SignInSuccessState extends AuthStates {
  // SignInSuccessState(this.uId);
  // String uId;
}

class SignInErrorState extends AuthStates {
  final String error;

  SignInErrorState(this.error);
}

class SignOutLodingState extends AuthStates {}

class SignOutSuccessState extends AuthStates {}

class SignOutErrorState extends AuthStates {
  final String error;

  SignOutErrorState(this.error);
}

class SignUpLodingState extends AuthStates {}

class SignUpSuccessState extends AuthStates {}

class SignUpErrorState extends AuthStates {
  final String error;

  SignUpErrorState(this.error);
}

class SignInChangeVisabilityState extends AuthStates {}
