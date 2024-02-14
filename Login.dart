import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts/cubit/States.dart';

import 'Register.dart';
import 'Stared news.dart';
import 'cubit/cubit.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
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
                      "Login",
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "email is require";
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      controller: cubit.emailLogin,
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
                        if (value == null || value.isEmpty) {
                          return "password is require";
                        }
                        if (value.length < 8) {
                          return "password is weak";
                        }
                      },
                      obscureText: cubit.showpassword ? true : false,
                      controller: cubit.passwordLogin,
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
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.teal),
                      ),
                      onPressed: () async {
                        print(cubit.datalogin);
                        if (formKey.currentState!.validate()) {
                          // Fetch the profile data from the database
                          final profileData =
                              await cubit.getProfileFromDatabaase();

                          if (profileData.isNotEmpty) {
                            int index = -1;
                            for (int i = 0; i < profileData.length; i++) {
                              if (profileData[i]['email'] ==
                                      cubit.emailLogin.text &&
                                  profileData[i]['password'] ==
                                      cubit.passwordLogin.text) {
                                index = i;
                                break; // Found a matching user, no need to continue the loop
                              }
                            }

                            if (profileData[index]['email'] ==
                                    cubit.emailLogin.text &&
                                profileData[index]['password'] ==
                                    cubit.passwordLogin.text) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainPage()),
                              );
                            } else {
                              print("User not found");
                            }
                          } else {
                            print("No registered users found");
                          }
                        }
                        cubit.getProfileFromDatabaase();
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text('did not have an account ?'),
                        SizedBox(
                          width: 4,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Register()));
                            },
                            child: Text("Register"))
                      ],
                    )
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
