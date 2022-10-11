import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intro_screen_onboarding_flutter/intro_app.dart';
import 'package:mega_chat/layouts/onboarding%20layout/cubit/states.dart';

class OnBoardingCubit extends Cubit<OnBoardingStates> {
  OnBoardingCubit() : super(OnBoardingInitiState());

  static OnBoardingCubit get(context) => BlocProvider.of(context);

  var _titleTextStyle = TextStyle(fontSize: 20);

  final List<Introduction> list = [
    Introduction(
      title: 'Buy & Sell',
      subTitle: 'Browse the menu and order directly from the application',
      imageUrl: 'assets/images/onboarding/shop.png',
      titleTextStyle: TextStyle(fontSize: 20),
      subTitleTextStyle: TextStyle(fontSize: 12),
    ),
    Introduction(
      title: 'Delivery',
      subTitle: 'Your order will be immediately collected and',
      imageUrl: 'assets/images/onboarding/delivery.png',
      titleTextStyle: TextStyle(fontSize: 20),
      subTitleTextStyle: TextStyle(fontSize: 12),
    ),
    Introduction(
      title: 'Receive Money',
      subTitle: 'Pick up delivery at your door and enjoy groceries',
      imageUrl: 'assets/images/onboarding/money.png',
      titleTextStyle: TextStyle(fontSize: 20),
      subTitleTextStyle: TextStyle(fontSize: 12),
    ),
    Introduction(
      title: 'Finish',
      subTitle: 'Browse the menu and order directly from the application',
      imageUrl: 'assets/images/onboarding/finish.png',
      titleTextStyle: TextStyle(fontSize: 20),
      subTitleTextStyle: TextStyle(fontSize: 12),
    ),
  ];
}
