// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mega_chat/modules/authentication/auth%20methods/auth%20cubit/cubit.dart';
import 'package:mega_chat/modules/authentication/auth%20methods/auth%20cubit/states.dart';
import 'package:mega_chat/modules/loader/loader_screen.dart';

import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';


class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var phoneController = TextEditingController();
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is SignUpLodingState) {
          navigateAndRemoveTo(context, const LoaderScreen());
        }

      },
      builder: (context, state) {
        makeStatusBarTransparent();
        var cubit = AuthCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "REGISTER",
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: Colors.black),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Login now to browse our hot offers.",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.grey),
                      ),
                      const SizedBox(height: 40),
                      defultTextField(
                        controller: nameController,
                        prefix: Icons.person,
                        label: "User Name",
                        keyboardType: TextInputType.emailAddress,
                        validator: (val) {
                          if (val.isEmpty) {
                            return "You should enter valid name";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 15),
                      defultTextField(
                        controller: emailController,
                        prefix: Icons.email_outlined,
                        label: "Email Address",
                        keyboardType: TextInputType.emailAddress,
                        validator: (val) {
                          if (val.isEmpty) {
                            return "You should enter valid email address";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 15),
                      defultTextField(
                        controller: passwordController,
                        prefix: Icons.lock_outline,
                        label: "Password",
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: cubit.securassword,
                        suffix: cubit.visibleIcon,
                        suffixFunc: () => cubit.changeVisability(),
                        validator: (String val) {
                          if (val.isEmpty) {
                            return "You should enter valid password";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 15),
                      defultTextField(
                        controller: phoneController,
                        prefix: Icons.phone,
                        label: "Phone",
                        keyboardType: TextInputType.number,
                        validator: (val) {
                          if (val.isEmpty) {
                            return "You should enter valid phone number";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      state is! SignUpLodingState
                          ? defultButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  print(
                                      "Dear  look here !  ${emailController.text}  and ${passwordController.text}");
                                  AuthCubit.get(context)
                                      .signUpWithEmailAndPassword(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              },
                              lable: "Register",
                            )
                          : const Center(
                              child: Text("Wait ..."),
                              // child: CircularProgressIndicator(),
                            ),
                      const SizedBox(height: 20),
                      customDividorText('Register with'),
                      const SizedBox(height: 20),
                      buildMediaSignUpAcc(context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
