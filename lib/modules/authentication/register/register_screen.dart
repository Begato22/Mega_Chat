import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../auth methods/auth cubit/cubit.dart';
import '../auth methods/auth cubit/states.dart';
import '../auth methods/email and password cubit/email_password_states.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var phoneController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {
          // if (state is AddUserSuccessState) {
          //   // navigateAndRemoveTo(context, const SocialLayout());
          // }
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
                                    // print(
                                    //     "Dear  look here !  ${emailController.text}  and ${passwordController.text}");
                                    // AuthCubit.get(context).signUp(
                                    //     name: nameController.text,
                                    //     email: emailController.text,
                                    //     password: passwordController.text,
                                    //     phone: phoneController.text,
                                    //     );
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
                        buildMediaAcc(context),
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
