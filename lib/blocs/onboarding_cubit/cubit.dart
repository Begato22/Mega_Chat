import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intro_screen_onboarding_flutter/intro_app.dart';
import 'package:mega_chat/blocs/onboarding_cubit/states.dart';
import 'package:mega_chat/shared/networks/local/cach_helper.dart';

class OnBoardingCubit extends Cubit<OnBoardingStates> {
  OnBoardingCubit() : super(OnBoardingInitiState());

  static OnBoardingCubit get(context) => BlocProvider.of(context);

  final List<Introduction> list = [
    Introduction(
      title: 'Buy & Sell',
      subTitle: 'Browse the menu and order directly from the application',
      imageUrl: 'assets/images/onboarding/shop.png',
      titleTextStyle: const TextStyle(fontSize: 20),
      subTitleTextStyle: const TextStyle(fontSize: 12),
      imageWidth: 350,
      imageHeight: 350,
    ),
    Introduction(
      title: 'Delivery',
      subTitle: 'Your order will be immediately collected and',
      imageUrl: 'assets/images/onboarding/delivery.png',
      titleTextStyle: const TextStyle(fontSize: 20),
      subTitleTextStyle: const TextStyle(fontSize: 12),
      imageWidth: 350,
      imageHeight: 350,
    ),
    Introduction(
      title: 'Receive Money',
      subTitle: 'Pick up delivery at your door and enjoy groceries',
      imageUrl: 'assets/images/onboarding/money.png',
      titleTextStyle: const TextStyle(fontSize: 20),
      subTitleTextStyle: const TextStyle(fontSize: 12),
      imageWidth: 350,
      imageHeight: 350,
    ),
    Introduction(
      title: 'Finish',
      subTitle: 'Browse the menu and order directly from the application',
      imageUrl: 'assets/images/onboarding/finish.png',
      titleTextStyle: const TextStyle(fontSize: 20),
      subTitleTextStyle: const TextStyle(fontSize: 12),
      imageWidth: 350,
      imageHeight: 350,
    ),
  ];

  void skip() {
    CashHelper.setData(key: 'onBoarding', value: true);
    emit(OnBoardingSkipState());
  }
}
