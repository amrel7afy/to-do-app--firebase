import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_cis_to_do_app/modules/home_screenn.dart';
import 'package:new_cis_to_do_app/modules/login_screen.dart';
import 'package:new_cis_to_do_app/shared/cubit/app_cubit/app_cubit.dart';
import 'package:new_cis_to_do_app/shared/cubit/app_cubit/bloc_observer.dart';
import 'package:new_cis_to_do_app/shared/network/local/cache_helper.dart';

import 'constants.dart';
import 'modules/sign_up_screen.dart';


void main()async{
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
BlocOverrides.runZoned(() {
  runApp(MyApp(

  //  startWidget: widget,
  ));
}, blocObserver: SimpleBlocObserver());

/*
await CacheHelper.init();
 late Widget widget;
uId=CacheHelper.getData(key: 'uId')??'';


if(!uId.isEmpty){
  widget=HomeScreen();
}else{
  widget=LoginScreen();
}


 */
}
class MyApp extends StatelessWidget {
//  late final Widget startWidget;
// MyApp({required this.startWidget});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>AppCubit()..getUserData(),
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: primaryColor,
                checkboxTheme: CheckboxThemeData(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                    ))
        ),
        home:  LoginScreen(),
      ),
    );
  }
}
