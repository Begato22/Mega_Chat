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

class CreateUserLodingState extends AuthStates {}

class CreateUserSuccessState extends AuthStates {}

class CreateUserErrorState extends AuthStates {
  final String error;

  CreateUserErrorState(this.error);
}

class GetUserLoadingState extends AuthStates {}

class GetUserSuccessState extends AuthStates {}

class GetUserErrorState extends AuthStates {}

class SignInChangeVisabilityState extends AuthStates {}
