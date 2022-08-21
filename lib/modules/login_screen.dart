
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_cis_to_do_app/modules/sign_up_screen.dart';
import 'package:new_cis_to_do_app/shared/cubit/login_cubit/login_cubit.dart';
import 'package:new_cis_to_do_app/shared/network/local/cache_helper.dart';

import '../constants.dart';
import '../reusable_components.dart';
import '../shared/cubit/login_cubit/login_states.dart';
import 'home_screenn.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context,state){
          if(state is LoginSuccessState){
            uId=state.uId;
            print('Set uID to cache'+uId);
            CacheHelper.saveData(key: 'uId', value: uId);
            navigateAndFinish(context, HomeScreen());
          }
        },
        builder: (context,state){
          LoginCubit cubit=BlocProvider.of(context);
          return Scaffold(
            body: Form(
              key: formKey,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              'Login',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3
                                  ?.copyWith(color: Colors.white),
                            )),

                        DefaultTextField(onTap: (){},
                          hint: 'User Name',
                          textEditingController: userNameController,
                          validate: (value) {
                            if (value ==null||value.isEmpty) {
                              return 'enter user name';
                            }return null;
                          },
                        ),
                        DefaultTextField(
                          onTap: (){},
                            hint: 'Password',
                            validate: ( value) {
                              if (value ==null||value.isEmpty) {
                                return 'enter password';
                              }
                            },
                            textEditingController: passwordController),
                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                cubit.login(email: userNameController.text.trim(), password: passwordController.text.trim());
                              }
                            },
                            child: Container(
                              height: 45,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                  color: pinkColor,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 7,
                                      color: pinkColor,
                                    )
                                  ]),
                              child: Center(
                                child: ConditionalBuilder(
                                  condition: state is !LoginLoadingState,
                                  fallback: (context)=>Center(child: CircularProgressIndicator(color: Colors.white,),),
                                  builder:(context)=> Text(
                                    'LOGIN',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5
                                        ?.copyWith(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have account?',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            DefaultTextButton(
                                text: 'register',
                                onPressed: () {
                                  navigateAndFinish(context, SignUpScreen());
                                })
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
    ;
  }
}
