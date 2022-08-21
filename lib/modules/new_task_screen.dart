import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:new_cis_to_do_app/constants.dart';
import 'package:new_cis_to_do_app/modules/home_screenn.dart';
import 'package:new_cis_to_do_app/reusable_components.dart';
import 'package:new_cis_to_do_app/shared/cubit/app_cubit/app_cubit.dart';
import 'package:new_cis_to_do_app/shared/cubit/app_cubit/app_states.dart';

class NewTaskScreen extends StatelessWidget {
  TextEditingController titleController=TextEditingController();
  TextEditingController timeController=TextEditingController();
  TextEditingController dateController=TextEditingController();
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context)=>AppCubit(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){
          if(state is AddNewTaskSuccessState){
             navigateAndFinish(context, HomeScreen());
          }
        },
        builder: (context,state){
          AppCubit cubit =BlocProvider.of(context);
          return  Scaffold(
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  children: [
                    DefaultTextField( onTap: (){},
                        prefixIcon: Icon(Icons.title),
                        hint: 'Task Title', validate: ( value){
                          if(value==null||value.isEmpty){
                            return 'enter title';
                          }
                        }, textEditingController: titleController),
                    DefaultTextField( onTap: (){
                      showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now())
                          .then((value) {
                        timeController.text=value!.format(context).toString();
                        print(value.format(context).toString());
                      });
                    },
                        prefixIcon: Icon(Icons.hourglass_bottom_outlined),
                        hint: 'Pick Time', validate: (val){
                          if(val==null||val.isEmpty){
                            return 'enter time';
                          }
                        }, textEditingController: timeController),
                    DefaultTextField( onTap: (){
                      showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.parse('2050-05-03')
                      ).then((value) {
                        dateController.text=DateFormat.yMMMd().format(value!);
                      }).catchError((onError){});
                    },
                        prefixIcon: Icon(Icons.calendar_today_rounded),
                        hint: 'Pick Date', validate: (val){
                          if(val==null||val.isEmpty){
                            return 'enter date';
                          }
                        }, textEditingController: dateController),
                  ],),
              ),
            ),
            appBar: AppBar(

              elevation: 0.0,
              actions: [
                DefaultTextButton(text: 'Add Task', onPressed: (){
                  if(formKey.currentState!.validate()){
                    formKey.currentState!.save();
                    cubit.addNewTask(text: titleController.text.trim()  , date: dateController.text.trim(), time: timeController.text.trim());
                  }
                })
                ,SizedBox(width: 10,)
              ],
            ),
          );
        },

      ),
    );
  }
}
