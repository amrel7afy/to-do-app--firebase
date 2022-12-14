import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_cis_to_do_app/models/task_model.dart';
import 'package:new_cis_to_do_app/models/userModel.dart';
import 'package:new_cis_to_do_app/shared/cubit/app_cubit/app_states.dart';

import '../../../constants.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  late UserModel userModel;

  getUserData()async {


    emit(GetUserDataLoadingState());

    FirebaseFirestore.instance
        .collection('users')
        //   دلوقتي الuid دا هيبقي null
        /*
     >>>>>>> .doc(userModel.uId)<<<<<<
       طب ليه ؟ عشان لسه معملناش initialize للموديل فالحل
        هسيف الuid وقت منا بعمل لوجين في متغير خارجي وهباصيه هنا
        */
        .doc(uId)
        .get()
        .then((value) {
      userModel = UserModel.formJson(value.data()!);
      emit(GetUserDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetUserDataErrorState(error.toString()));
    });
  }

//----------------------------------------------------------------------------------
  //add new task
  List<TaskModel> tasks = [];
  List<TaskModel> doneTasks = [];
  List<String> tasksIds = [];

  void addNewTask(
      {required String text, required String date, required String time}) {
    emit(AddNewTaskLoadingState());
    TaskModel taskModel = TaskModel(
        text: text, status: false, date: date, time: time, taskId: 'empty');
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('tasks')
        .add(taskModel.toMap())
        .then((value) {
      //tasksIds.add(value.id);
      emit(AddNewTaskSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AddNewTaskErrorState(error.toString()));
    });
  }
  bool loading=false;
  void getTasks() {
    loading=true;
    emit(GetTasksLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('tasks')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        tasks.add(TaskModel.fromJson(element.data()));
        tasksIds.add(element.id);
      });
      print('Tasks IDs length: ' + tasksIds.length.toString());
      loading=false;
      emit(GetTasksSuccessState());
    }).catchError((error) {
      print(error.toString());
      print(tasks.length);
      emit(GetTasksErrorState(error.toString()));
    });
  }

  void getDoneTasks(int index){
    // FirebaseFirestore.instance.collection('users').doc(uId)
    //     .collection('tasks').get().then((value){
    //       if()
    // } ).catchError((error){});
    for(int i=0;i<=tasks.length-1;i++)
    if(tasks[index].status==true){
      doneTasks.add(tasks[index]);
    }
  }

  //>>>>>>>>>>>>>delete task<<<<<<<<<<<<<<<<<<<<<<<<<
  void deleteTask({required int index}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('tasks')
        .doc('${tasksIds[index]}')
        .delete()
        .then((value) {
      emit(DeleteTaskSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(DeleteTaskErrorState(error.toString()));
    });
  }

//>>>>>>>>>>>>>>>update task status<<<<<<<<<<<<<<<<<<<

  void updateTaskStatus({required int index, required bool status}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('tasks')
        .doc(tasksIds[index])
        .update({'status': status}).then((value) {
      emit(UpdateTaskStatusSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(UpdateTaskStatusErrorState(error.toString()));
    });
  }
}
