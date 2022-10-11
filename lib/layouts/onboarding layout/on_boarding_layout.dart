import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intro_screen_onboarding_flutter/intro_app.dart';
import 'package:mega_chat/layouts/onboarding%20layout/cubit/cubit.dart';
import 'package:mega_chat/layouts/onboarding%20layout/cubit/states.dart';
import 'package:mega_chat/modules/authentication/login/login_screen.dart';
import 'package:mega_chat/shared/components/components.dart';

class OnBoardingLayout extends StatelessWidget {
  const OnBoardingLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnBoardingCubit, OnBoardingStates>(
      listener: ((context, state) {}),
      builder: (context, state) {
        return Scaffold(
          body: Container(
            child: IntroScreenOnboarding(
              backgroudColor: Colors.white,
              introductionList: OnBoardingCubit.get(context).list,
              onTapSkipButton: () {
                navigateAndRemoveTo(context, const LoginScreen());
              },
            ),
          ),
        );
      },
    );
  }
}
