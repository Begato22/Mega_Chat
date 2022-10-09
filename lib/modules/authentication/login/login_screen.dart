// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mega_chat/modules/authentication/auth%20methods/auth%20cubit/cubit.dart';
import 'package:mega_chat/modules/loader/loader_screen.dart';

import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../auth methods/auth cubit/states.dart';
import '../register/register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is SignInErrorState) {
          showToast(state.error, ToastState.error);
        }

        if (state is SignInLodingState) {
          navigateAndRemoveTo(context, const LoaderScreen());
        }
        // if (state is SignInSuccessState) {
        //   print('any thing');
        //   CashHelper.setData(key: 'uId', value: state.uId).then(
        //     (value) {
        //       print(value);
        //       if (value) {
        //         print(value);
        //         uId = state.uId;
        //         // navigateAndRemoveTo(context, const SocialLayout());
        //       }
        //     },
        //   ).catchError(
        //     (onError) {
        //       print(onError.toString());
        //     },
        //   );
        // }
        // if (state is LoginSuccessState) {
        // if (LoginCubite.get(context).loginModel!.status) {
        //   CashHelper.setData(
        //           key: 'token',
        //           value: LoginCubite.get(context)
        //               .loginModel!
        //               .userDate!
        //               .token)
        //       .then(
        //     (value) {
        //       print(
        //           "This Image Profile URL: ${LoginCubite.get(context).loginModel!.userDate!.image}");
        //       if (value) {
        //         token = LoginCubite.get(context)
        //             .loginModel!
        //             .userDate!
        //             .token;
        //         navigateAndRemoveTo(context, const Layout());
        //       }
        //       showToast(
        //         LoginCubite.get(context).loginModel!.message,
        //         ToastState.success,
        //       );
        //       // emailController.text = passwordController.text = "";
        //     },
        //   );
        // } else {
        //   showToast(
        //     LoginCubite.get(context).loginModel!.message,
        //     ToastState.error,
        //   );
        // }
        // }
      },
      builder: (context, state) {
        makeStatusBarTransparent();
        var cubit = AuthCubit.get(context);
        return Scaffold(
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
                        "LOGIN",
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
                      const SizedBox(height: 20),
                      state is! SignInLodingState
                          ? defultButton(
                              onPressed: () {
                                print("object");
                                if (formKey.currentState!.validate()) {
                                  cubit.signInWithEmailAndPassword(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              lable: "login",
                            )
                          : const Center(
                              child: Text("Wait ..."),
                              // child: CircularProgressIndicator(),
                            ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Dont't have an account? "),
                          const SizedBox(width: 3),
                          defultTextButton(
                            onPressed: () {
                              navigateTo(context, const RegisterScreen());
                            },
                            lable: "register",
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      buildMediaSigninAcc(context),
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
