// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mega_chat/models/user%20model/user_model.dart';
import 'package:mega_chat/modules/authentication/auth%20methods/auth%20cubit/cubit.dart';
import 'package:mega_chat/modules/authentication/auth%20methods/auth%20cubit/states.dart';
import 'package:mega_chat/modules/authentication/login/login_screen.dart';
import 'package:mega_chat/modules/authentication/register/register_screen.dart';
import 'package:mega_chat/shared/components/components.dart';
import 'package:mega_chat/shared/components/constants.dart';
import 'package:mega_chat/shared/networks/local/cach_helper.dart';
import 'package:mega_chat/shared/styles/colors.dart';
import 'package:progress_indicators/progress_indicators.dart';

import '../../layouts/social layout/social_layout.dart';

class LoaderScreen extends StatelessWidget {
  const LoaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is SignInSuccessState) {
          navigateAndRemoveTo(context, const SocialLayout());
        }
        if (state is CreateUserSuccessState) {
          navigateAndRemoveTo(context, const LoginScreen());
          showToast('Sign Up Successfully', ToastState.success);
        }
        if (state is SignUpErrorState) {
          navigateAndRemoveTo(context, const RegisterScreen());
          showToast(state.error, ToastState.error);
        }
        if (state is SignInErrorState) {
          navigateAndRemoveTo(context, const LoginScreen());
          showToast('You must sign up first', ToastState.error);
        }
        if (state is GetUserSuccessState) {
          navigateAndRemoveTo(context, const SocialLayout());
        }
        if (state is GetUserErrorState) {
          navigateAndRemoveTo(context, const LoginScreen());
          showToast('You must sign up first', ToastState.error);
        }
      },
      builder: (context, state) {
        var loginMethod = CashHelper.getData(key: 'loginMethod');
        var cubit = AuthCubit.get(context);
        print(
            '@@ this login method in cash helper provided  before checking : ${CashHelper.getData(key: 'loginMethod')}');
        print(
            '@@ this uId in cash helper provided  before checking : ${CashHelper.getData(key: 'id')}');
        if (loginMethod != null && uId != null) {
          print('loginMthod is not null.');
          if (loginMethod == 'LoginMethod.facebook') {
            print('@@ we will get data from facebook login');
            cubit.getUser(uId, LoginMethod.facebook);
          } else if ('LoginMethod.google' == loginMethod) {
            cubit.getUser(uId, LoginMethod.google);
            print(
                '@@ we will get data from google login ${cubit.userModel.loginMethod}');
          } else if ('LoginMethod.normal' == loginMethod) {
            cubit.getUser(uId, LoginMethod.normal);
            print(
                '@@ we will get data from google login ${cubit.userModel.loginMethod}');
          }
        }
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo.png',
                height: 200,
                width: 200,
              ),
              JumpingDotsProgressIndicator(
                color: defaultColor,
                fontSize: 40.0,
              ),
            ],
          ),
        );
      },
    );
  }
}
