import 'package:flutter/material.dart';
import 'package:new_cis_to_do_app/models/task_model.dart';
import 'package:new_cis_to_do_app/shared/cubit/app_cubit/app_cubit.dart';

import 'constants.dart';
import 'modules/done_tasks_screen.dart';

class DefaultTextField extends StatelessWidget {
  final String hint;
  final String? Function(String? val)? validate;
  final TextEditingController textEditingController;
  GestureTapCallback? onTap;
  Icon? prefixIcon;

  DefaultTextField(
      {required this.hint,
      this.onTap,
      this.prefixIcon,
      required this.validate,
      required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      margin: const EdgeInsets.fromLTRB(0, 10, 20, 20),
      padding: EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
          border: Border.all(color: textColor, width: 2),
          borderRadius: BorderRadius.circular(20)),
      child: Center(
        child: TextFormField(
          validator: validate,
          onTap: () {
            onTap!();
          },
          controller: textEditingController,
          cursorColor: secondaryColor,
          cursorHeight: 24,
          decoration: InputDecoration(
              prefixIcon: prefixIcon,
              prefixIconColor: textColor,
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none),
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
      onPressed: () {
        onPressed();
      },
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
            color: pinkColor.withOpacity(0.8),
            shadows: [BoxShadow(color: pinkColor, blurRadius: 2)]),
      ),
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

class NewTaskItem extends StatefulWidget {
  late TaskModel taskModel;
  late final DismissDirectionCallback onDismissed;
  late final int index;

  // late final Function onChanged;
  // late final bool tapped;
  NewTaskItem(
      {required this.taskModel, required this.onDismissed, required this.index
      //required this.onChanged,required this.tapped
      });

  // هنا عشان نباصي داتا ل stateful widget
  @override
  State<NewTaskItem> createState() => _NewTaskItemState(
      taskModel: taskModel, onDismissed: onDismissed, index: index
      // onChanged: onChanged,tapped:tapped
      );
}
class _NewTaskItemState extends State<NewTaskItem> {
  late TaskModel taskModel;
  late final DismissDirectionCallback onDismissed;
  // محتاج ال index عشان احول ال status بتاعت ال item اللي موجود في ليستة التاسكات
  // كنا بنختبر ان الزرار شغال وممكن نشيلها
  late final int index;

  // late final Function onChanged;
  // late final bool tapped;

  _NewTaskItemState(
      {required this.taskModel, required this.onDismissed, required this.index
      // required this.onChanged,required this.tapped
      });

  bool tapped = false;

  onChanged(on) {
    setState(() {
      tapped = on!;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      // وانت شغال مع dismissible
      // ابقي استدعي onDismissed برا عشان لو هتمسح العنصر يمسحها كمان من ال
      //widget tree
      key: ObjectKey(AppCubit.get(context).tasksIds[index]),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        padding: EdgeInsets.only(left: 10),
        height: 60,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: secondaryColor, borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            Transform.scale(
              scale: 1.5,
              child: Checkbox(
                value: tapped,
                onChanged: (on) {
                  onChanged(on);
                  AppCubit.get(context).tasks[index].status = tapped;
                  AppCubit.get(context).updateTaskStatus(index: index, status: on!);
                  print('Task $index Status: ' + AppCubit.get(context).tasks[index].status.toString());
                  AppCubit.get(context).tasks.removeAt(index);
                },
                side: BorderSide(
                  color: pinkColor,
                  width: 1.5,
                ),
                activeColor: pinkColor,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: Text(
              taskModel.text,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            )),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                taskModel.time,
                style: TextStyle(color: textColor),
              ),
            )
          ],
        ),
      ),
      onDismissed: (direction) {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text('delete ${taskModel.text} task')));
        onDismissed(direction);
      },
    );
  }
}

/*
class DoneTaskItem extends InheritedWidget{
  DoneTaskItem({required super.child});



}

 */
class DoneTaskItem extends StatefulWidget {
  late TaskModel taskModel;
  late final DismissDirectionCallback onDismissed;


  // late final Function onChanged;
  // late final bool tapped;
  DoneTaskItem(
      {required this.taskModel, required this.onDismissed,
        //required this.onChanged,required this.tapped
      });

  // هنا عشان نباصي داتا ل stateful widget
  @override
  State<DoneTaskItem> createState() => _DoneTaskItemState(
      taskModel: taskModel, onDismissed: onDismissed,
    // onChanged: onChanged,tapped:tapped
  );
}
class _DoneTaskItemState extends State<DoneTaskItem> {
  late TaskModel taskModel;
  late final DismissDirectionCallback onDismissed;
  // محتاج ال index عشان احول ال status بتاعت ال item اللي موجود في ليستة التاسكات
  // كنا بنختبر ان الزرار شغال وممكن نشيلها


  // late final Function onChanged;
  // late final bool tapped;

  _DoneTaskItemState(
      {required this.taskModel, required this.onDismissed,
        // required this.onChanged,required this.tapped
      });

  bool tapped = false;

  onChanged(on) {
    setState(() {
      tapped = on!;
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
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        padding: EdgeInsets.only(left: 10),
        height: 60,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: secondaryColor, borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: Text(
                  taskModel.text,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                )),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                taskModel.time,
                style: TextStyle(color: textColor),
              ),
            )
          ],
        ),
      ),
      onDismissed: (direction) {
        onDismissed(direction);
      },
    );
  }
}



Widget drawer(BuildContext context) {
  return Drawer(
    child: ListView(
      children: [
        SizedBox(
          height: 210.0,
          child: DrawerHeader(
              child: Column(
            children: [
              CircleAvatar(
                radius: 45,
                backgroundImage: NetworkImage(
                    'https://th.bing.com/th/id/OIP.j4uqoQqHX14hsF1y5Xs4BQHaLG?pid=ImgDet&rs=1'),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Arush Singh',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(fontSize: 19, color: Colors.white),
              ),
              SizedBox(
                height: 3,
              ),
            ],
          )),
        ),
        ListTile(
          title: Text(
            'Done Tasks',
            style: Theme.of(context)
                .textTheme
                .bodyText2
                ?.copyWith(color: Colors.white),
          ),
          leading: Icon(
            Icons.done,
            color: textColor,
          ),
          onTap: (){
            navigateTo(context, DoneTasksScreen());
          },
        )
      ],
    ),
  );
}
