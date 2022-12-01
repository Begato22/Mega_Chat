abstract class AuthStates {}

class AuthInitialState extends AuthStates {}

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

class CodeChangedState extends AuthStates {}

class VerificationIdChangedState extends AuthStates {}

class NumberChangedState extends AuthStates {}

class ProfilePicPickedSuccessState extends AuthStates {}

class ProfilePicPickedErrorState extends AuthStates {}

class CoverPicPickedSuccessState extends AuthStates {}

class CoverPicPickedErrorState extends AuthStates {}

class ProfileUploadSuccessState extends AuthStates {}

class ProfileUploadErrorState extends AuthStates {}

class CoverUploadSuccessState extends AuthStates {}

class CoverUploadErrorState extends AuthStates {}

class UploadSuccessState extends AuthStates {}

class UploadErrorState extends AuthStates {}

class UploadLoadingState extends AuthStates {}
