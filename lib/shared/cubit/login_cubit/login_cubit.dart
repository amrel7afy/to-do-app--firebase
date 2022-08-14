import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_cis_to_do_app/models/userModel.dart';
import 'login_states.dart';
class LoginCubit extends Cubit<LoginStates>{
  LoginCubit():super(RegisterInitialState());

   static LoginCubit get(context)=>BlocProvider.of(context);

    late UserModel userModel;

void signUp(
  {required String email,
    required String password,
    required String userName
  }
    ){
  emit(RegisterLoadingState());
FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value) {
createUser(uId: value.user!.uid, userName: userName, email: value.user!.email!);
}).catchError((error){
  print(error.toString()+'register error');
  emit(RegisterErrorState(error.toString()));
});
}

void createUser(
  {required String uId,
    required String userName,
    required String email
  }
    ){
  UserModel userModel =UserModel(userName: userName,
  profileImage: 'https://th.bing.com/th/id/R.7dcc14c3ff43de42016e74eb85329474?rik=7Q5PUKfFvL5Giw&pid=ImgRaw&r=0',
    uId: uId,
    email:email ,);
  FirebaseFirestore.instance.collection('users').doc(uId).set(userModel.toMap())
      .then((value) {
        emit(CreateSuccessState());
  })
      .catchError((error){
        print(error.toString());
        emit(CreateErrorState(error.toString()));
  });

}
void login({
  required String email,
  required String password
}){
  emit(LoginLoadingState());
  FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password)
      .then((value) {emit(LoginSuccessState(value.user!.uid));})
      .catchError((error){
        print(error.toString());
        emit(LoginErrorState(error.toString()));
  });
}
}