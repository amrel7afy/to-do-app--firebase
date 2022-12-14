abstract class AppStates{}

class InitialState extends AppStates{}

//get user date
class GetUserDataLoadingState extends AppStates{}
class GetUserDataSuccessState extends AppStates{}
class GetUserDataErrorState extends AppStates{
  final String error;
  GetUserDataErrorState(this.error);
}

//add new task-------------------------------------
class AddNewTaskLoadingState extends AppStates{}
class AddNewTaskSuccessState extends AppStates{}
class AddNewTaskErrorState extends AppStates{
  final String error;
  AddNewTaskErrorState(this.error);
}


//get tasks-------------------------------------
class GetTasksSuccessState extends AppStates{}
class GetTasksLoadingState extends AppStates{}
class GetTasksErrorState extends AppStates{
  final String error;
  GetTasksErrorState(this.error);
}

//delete task-----------------------
class DeleteTaskSuccessState extends AppStates{}
class DeleteTaskErrorState extends AppStates{
  final String error;
  DeleteTaskErrorState(this.error);
}
//>>>>>>>>>>>>>>>update task status<<<<<<<<<<<<<<<<<<<

class UpdateTaskStatusSuccessState extends AppStates{}
class UpdateTaskStatusErrorState extends AppStates{
  final String error;
  UpdateTaskStatusErrorState(this.error);
}