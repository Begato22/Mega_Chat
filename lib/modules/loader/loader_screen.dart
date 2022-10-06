import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mega_chat/modules/authentication/auth%20methods/auth%20cubit/cubit.dart';
import 'package:mega_chat/modules/authentication/auth%20methods/auth%20cubit/states.dart';
import 'package:mega_chat/modules/authentication/login/login_screen.dart';
import 'package:mega_chat/shared/components/components.dart';
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
        if (state is SignInErrorState) {
          navigateAndRemoveTo(context, const LoginScreen());
          showToast('You must sign up first', ToastState.error);
        }
        if (state is SignUpErrorState) {
          navigateAndRemoveTo(context, const LoginScreen());
          showToast(state.error, ToastState.error);
        }
      },
      builder: (context, state) {
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
