abstract class LoginStates{}
class RegisterInitialState extends LoginStates {}

class RegisterLoadingState extends LoginStates {}

class RegisterSuccessState extends LoginStates {}

class RegisterErrorState extends LoginStates {
  final String error;

  RegisterErrorState(this.error);
}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final String uId;

  LoginSuccessState(this.uId);
}

class LoginErrorState extends LoginStates {
  final String error;

  LoginErrorState(this.error);
}

class CreateSuccessState extends LoginStates {}

class CreateErrorState extends LoginStates {
  final String error;

  CreateErrorState(this.error);
}
