// ignore_for_file: avoid_print

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mega_chat/blocs/onboarding_cubit/cubit.dart';
import 'package:mega_chat/layouts/onboarding%20layout/on_boarding_layout.dart';
import 'package:mega_chat/blocs/social%20cubit/cubit.dart';
import 'package:mega_chat/blocs/auth_cubit/cubit.dart';
import 'package:mega_chat/blocs/auth_cubit/states.dart';

import 'package:mega_chat/modules/loader/loader_screen.dart';
import 'package:mega_chat/shared/components/components.dart';
import 'package:mega_chat/shared/components/constants.dart';
import 'package:mega_chat/shared/my_bloc_observer.dart';
import 'package:mega_chat/shared/networks/local/cach_helper.dart';
import 'package:mega_chat/shared/styles/themes.dart';

import 'modules/login/login_screen.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  showToast('Welcome from on Background Message', ToastState.success);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await CashHelper.initi();
  uId = CashHelper.getData(key: 'id');
  var onBoarding = CashHelper.getData(key: 'onBoarding');
  Widget widget;
  if (uId != null) {
    widget = const LoaderScreen();
  } else {
    if (onBoarding == null) {
      widget = const OnBoardingLayout();
    } else {
      widget = const LoginScreen();
    }
  }

  var token = await FirebaseMessaging.instance.getToken();
  print(token);
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data);
    showToast('Welcome from onMessage', ToastState.success);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data);
    showToast('Welcome from on Message Opened App', ToastState.success);
  });
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  runApp(MyApp(startWidget: widget));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.startWidget}) : super(key: key);
  final Widget startWidget;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit()..createFakeUser(),
        ),
        BlocProvider<SocialCubit>(
          create: (context) => SocialCubit(),
        ),
        BlocProvider<OnBoardingCubit>(
          create: (context) => OnBoardingCubit(),
        ),
      ],
      child: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: lightTheme,
            home: startWidget,
          );
        },
      ),
    );
  }
}
