import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts/Stared%20news.dart';
import 'package:posts/cubit/States.dart';
import 'package:posts/cubit/cubit.dart';

class Register extends StatelessWidget {
  Register({Key? key}) : super(key: key);
  final formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit,AppStates>(builder: (context, state) {
      AppCubit cubit = AppCubit.get(context);
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Text(
                    "Register",
                    style:
                    TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if(value==null||value.isEmpty){
                        return "email is require";
                      }

                    },
                    keyboardType: TextInputType.emailAddress,
                    controller: cubit.email,
                    decoration: InputDecoration(
                        hintText: "E-mail",
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12))),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    validator: (value) {
                      if(value==null||value.isEmpty){
                        return "password is require";
                      }
                      if(value.length<8)
                      {
                        return "password is weak";
                      }
                    },
                    obscureText: cubit.showpassword ? true : false,
                    controller: cubit.password,
                    decoration: InputDecoration(

                        hintText: "Password",
                        prefixIcon: IconButton(
                            onPressed: () {
                              if (cubit.showpassword == true) {
                                cubit.showPassword(false);
                              } else {
                                cubit.showPassword(true);
                              }
                            },
                            icon: Icon(Icons.remove_red_eye_sharp)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12))),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    validator: (value) {
                      if(value==null||value.isEmpty){
                        return "phone number is required";
                      }
                      if(value.length<12)
                      {
                        return "invalid phone number";
                      }
                    },
                    keyboardType: TextInputType.phone,
                    controller: cubit.mobile,
                    decoration: InputDecoration(
                        hintText: "Phone number",
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12))),
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(Colors.teal)),
                      onPressed: () {

                        if(formKey.currentState!.validate()) {
                          cubit.insertIntoDatabaseProfile(cubit.email.text,
                              cubit.password.text, cubit.mobile.text);
                          Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (context) => MainPage()));
                        }
                        cubit.getProfileFromDatabaase();
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ))
                ],
              ),
            ),
          ),
        ),
      );
    },

);
  }
}
