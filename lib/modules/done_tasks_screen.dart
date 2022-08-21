import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_cis_to_do_app/modules/home_screenn.dart';
import 'package:new_cis_to_do_app/reusable_components.dart';
import 'package:new_cis_to_do_app/shared/cubit/app_cubit/app_cubit.dart';

import '../models/task_model.dart';
import '../shared/cubit/app_cubit/app_states.dart';

class DoneTasksScreen extends StatelessWidget {
  const DoneTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>AppCubit()..getTasks(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          AppCubit cubit=BlocProvider.of(context);
          return Scaffold(
            body:ConditionalBuilder(
              fallback: (context)=>Center(child: CircularProgressIndicator(color: Colors.white,),),
              condition: state is !GetTasksLoadingState,
              builder:(context)=> ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                itemBuilder: (context,index){
                  TaskModel taskModel=cubit.tasks[index];
                  if(cubit.tasks.length==0){
                    return Expanded(child: Center(child:Text('No Tasks To Do'
                      ,style: Theme.of(context).textTheme.headline5?.
                      copyWith(color: Colors.white,fontWeight: FontWeight.w600)),));
                  }
                 else if(cubit.tasks[index].status==true){return DoneTaskItem(taskModel: taskModel, onDismissed: (on){});}
                 else{return Container();}
                },
                itemCount:cubit.tasks.length ,
              ),
            ),

            appBar: AppBar(
              title: Text('Done Tasks'),
              leading:IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: (){
                navigateAndFinish(context, HomeScreen());
              },),
            ),

          );
        },
      ),


    );
  }
}
