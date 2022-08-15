import 'package:flutter/material.dart';
import 'package:new_cis_to_do_app/models/task_model.dart';
import 'package:new_cis_to_do_app/shared/cubit/app_cubit/app_cubit.dart';

import 'constants.dart';

class DefaultTextField extends StatelessWidget {
   final String hint;
   final String? Function(String? val)? validate;
   final TextEditingController textEditingController;
   GestureTapCallback? onTap;
    Icon?prefixIcon;

  DefaultTextField(
      {required this.hint,
        this.onTap,
        this.prefixIcon,
        required this.validate,
        required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 65,
      margin: const EdgeInsets.fromLTRB(0,10,20,20),
      padding: EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
          border: Border.all(color: textColor,width: 2),
          borderRadius: BorderRadius.circular(20)
      ),
      child: Center(
        child: TextFormField(
          validator: validate,
          onTap: (){
            onTap!();
          },
          controller: textEditingController,
          cursorColor: secondaryColor,
          cursorHeight: 24,
          decoration:  InputDecoration(
            prefixIcon: prefixIcon,
              prefixIconColor: textColor,
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none
          ),
        ),
      ),
    );
  }
}

class DefaultTextButton extends StatelessWidget {
  final Function onPressed;
  final String text;

  DefaultTextButton({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (){
        onPressed();
      },
      child: Text(text.toUpperCase(),style: TextStyle(color: pinkColor.withOpacity(0.8),shadows: [BoxShadow(color: pinkColor,blurRadius:2)]),),
    );
  }
}

void navigateTo(context, widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void navigateAndFinish(context, widget) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
          (Route<dynamic> route) => false);
}

class TaskItem extends StatefulWidget {
  late TaskModel taskModel;
  late final DismissDirectionCallback onDismissed;
  TaskItem({required this.taskModel,required this.onDismissed});
  // هنا عشان نباصي داتا ل stateful widget
  @override
  State<TaskItem> createState() => _TaskItemState(taskModel:taskModel ,onDismissed: onDismissed);
}

class _TaskItemState extends State<TaskItem> {
  late TaskModel taskModel;
  late final DismissDirectionCallback onDismissed;
  _TaskItemState({required this.taskModel,required this.onDismissed});
  bool tapped=false;
  onChanged(on){
    setState(() {
      tapped=on!;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      // وانت شغال مع dismissible
      // ابقي استدعي onDismissed برا عشان لو هتمسح العنصر يمسحها كمان من ال
      //widget tree
      key: ObjectKey(taskModel.text),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
        padding: EdgeInsets.only(left: 10),
        height: 60,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.circular(15)
        ),
        child: Row(
          children: [
            Transform.scale(
              scale: 1.5,
              child: Checkbox(value: tapped, onChanged: (on){
                onChanged(on);
              },
                side: BorderSide(
                  color: pinkColor,
                  width: 1.5,
                ),
                activeColor: pinkColor,
              ),
            ),
            SizedBox(width: 10,),
            Expanded(child: Text(taskModel.text,style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w500),)),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(taskModel.time,style: TextStyle(color: textColor),),
            )
          ],
        ),
      ),
      onDismissed: (direction){
        onDismissed(direction);
      },
    );
  }
}

