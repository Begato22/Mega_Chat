import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intro_screen_onboarding_flutter/intro_app.dart';
import 'package:mega_chat/blocs/onboarding_cubit/cubit.dart';
import 'package:mega_chat/blocs/onboarding_cubit/states.dart';
import 'package:mega_chat/modules/login/login_screen.dart';
import 'package:mega_chat/shared/components/components.dart';

class OnBoardingLayout extends StatelessWidget {
  const OnBoardingLayout({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return BlocConsumer<OnBoardingCubit, OnBoardingStates>(
      listener: ((context, state) {}),
      builder: (context, state) {
        var cubit = OnBoardingCubit.get(context);
        var size = MediaQuery.of(context).size;
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: -size.height * 0.01,
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
          ),
          body: IntroScreenOnboarding(
            backgroudColor: Colors.white,
            introductionList: cubit.list,
            onTapSkipButton: () {
              cubit.skip();
              navigateAndRemoveTo(context, const LoginScreen());
            },
          ),
        );
      },
    );
  }
}
