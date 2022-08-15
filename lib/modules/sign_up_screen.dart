
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants.dart';
import '../reusable_components.dart';
import '../shared/cubit/login_cubit/login_cubit.dart';
import '../shared/cubit/login_cubit/login_states.dart';
import 'home_screenn.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController userNameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context,state){
          if(state is CreateSuccessState){
            navigateAndFinish(context, LoginScreen());
          }
        },
        builder: (context,state){
          LoginCubit cubit=BlocProvider.of(context);
          return Scaffold(
            body:  Form(
              key: formKey,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Align(alignment: AlignmentDirectional.centerStart,child: Text('Register',style: Theme.of(context).textTheme.headline3?.copyWith(color: Colors.white),)),
                        DefaultTextField( onTap: (){},hint: 'User Name',textEditingController: userNameController, validate: ( value) {
                          if (value ==null||value.isEmpty) {
                            return 'enter User Name';
                          }
                        },),
                        DefaultTextField( onTap: (){},hint: 'Email',textEditingController: emailController, validate: ( value) {
                          if (value ==null||value.isEmpty) {
                            return 'enter Email';
                          }
                        },),
                        DefaultTextField( onTap: (){},hint: 'Password',  validate: ( value) {
                          if (value ==null||value.isEmpty) {
                            return 'enter password';
                          }
                        }, textEditingController: passwordController),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                cubit.signUp(email: emailController.text.trim() , password: passwordController.text.trim(), userName: userNameController.text.trim());
                              }
                            },
                            child: Container(
                              height: 60,
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
                                  condition: state is !RegisterLoadingState,
                                  fallback: (context)=>Center(child: CircularProgressIndicator(color: Colors.white,),),
                                  builder: (context)=>Text(
                                    'REGISTER',
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
                              'have an account?',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            DefaultTextButton(
                                text: 'login',
                                onPressed: () {
                                  navigateAndFinish(context, LoginScreen());
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
  }
}
