import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_cis_to_do_app/constants.dart';
import 'package:new_cis_to_do_app/reusable_components.dart';
import 'package:new_cis_to_do_app/shared/cubit/app_cubit/app_cubit.dart';
import 'package:new_cis_to_do_app/shared/cubit/app_cubit/app_states.dart';

import 'new_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>AppCubit()..getUserData()..getTasks(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context, state) {
          bool tap=true;
          AppCubit cubit=BlocProvider.of(context);
          return Scaffold(
            body: ConditionalBuilder(
              condition:!cubit.loading,
              fallback: (context)=>Center(child: CircularProgressIndicator(color: Colors.white,)),
              builder:(context){
                return Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('What\'s up, ${cubit.userModel.userName}!',style:Theme.of(context).textTheme.headline4?.copyWith(color: Colors.white,fontWeight: FontWeight.bold),),
                    Row(
                      children: [
                        Padding(padding: EdgeInsets.symmetric(vertical: 10),child: Text(
                          'Your TASKS',style: TextStyle(color: textColor,fontWeight: FontWeight.w600,fontSize: 12),
                        ),),
                      ],
                    ),

                    if(cubit.tasks.length!=0)
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (context,index){
                            if(cubit.tasks.length!=0&&cubit.tasks[index].status==false)
                              return NewTaskItem(
                                index:index,
                                taskModel: cubit.tasks[index],
                                onDismissed: (direction){
                                  setState(() {
                                    cubit.tasks.removeAt(index);
                                    cubit.deleteTask(index: index);
                                    print('delete object number: '+index.toString());
                                  });
                                },
                                //  onChanged: (on){
                                //    setState(() {
                                //      tap=on!;
                                // //     cubit.tasks[index].status=on;
                                //    });
                                //  },
                                //  tapped: tap,
                              );
                            return Container();
                          },
                          itemCount: cubit.tasks.length,
                        ),),
                    if(cubit.tasks.length==0)
                      Expanded(child: Center(child:Text('No Tasks To Do'
                          ,style: Theme.of(context).textTheme.headline5?.
                          copyWith(color: Colors.white,fontWeight: FontWeight.w600)),)),
                  ],
                ),
              );} ,
            ),
            appBar: AppBar(
              backgroundColor: primaryColor,
              elevation: 0.0,
              actions: [
                IconButton(onPressed: (){}, icon: Icon(Icons.search,color:textColor,size: 30,)),
                IconButton(onPressed: (){}, icon: Icon(Icons.notifications_none,color:textColor,size: 30,)),
                SizedBox(width: 10,)
              ],
            ),
            floatingActionButton: SizedBox(
              height: 65,
              width: 65,
              child: FloatingActionButton(
                elevation: 0.0,
                backgroundColor: pinkColor,
                onPressed: () {navigateTo(context, NewTaskScreen()); },
                child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: pinkColor.withOpacity(0.8),
                          spreadRadius: 7,
                          blurRadius: 20,
                          offset: Offset(3, 5),
                        ),
                      ],
                    ),
                    child: Icon(Icons.add,size: 30,)),
              ),
            ),
            drawer: drawer(context,),
          );
        },
      ),
    );
  }
}
