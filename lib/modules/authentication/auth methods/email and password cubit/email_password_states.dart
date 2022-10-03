abstract class EmailPasswordStates {}

class EPSignInInitialState extends EmailPasswordStates {}

class EPSignInLodingState extends EmailPasswordStates {}

class EPSignInSuccessState extends EmailPasswordStates {
  EPSignInSuccessState(this.uId);
  String uId;
}

class EPSignInErrorState extends EmailPasswordStates {
  final String error;

  EPSignInErrorState(this.error);
}

class EPSignOutLodingState extends EmailPasswordStates {}

class EPSignOutSuccessState extends EmailPasswordStates {}

class EPSignOutErrorState extends EmailPasswordStates {
  final String error;

  EPSignOutErrorState(this.error);
}
class EPSignUpLodingState extends EmailPasswordStates {}

class EPSignUpSuccessState extends EmailPasswordStates {}

class EPSignUpErrorState extends EmailPasswordStates {
  final String error;

  EPSignUpErrorState(this.error);
}

class EPSignInChangeVisabilityState extends EmailPasswordStates {}
