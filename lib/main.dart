import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mega_chat/layouts/social%20layout/social%20cubit/cubit.dart';
import 'package:mega_chat/layouts/social%20layout/user%20cubit/cubit.dart';
import 'package:mega_chat/modules/authentication/auth%20methods/auth%20cubit/cubit.dart';
import 'package:mega_chat/shared/my_bloc_observer.dart';
import 'package:mega_chat/shared/networks/local/cach_helper.dart';
import 'package:mega_chat/shared/styles/colors.dart';

import 'modules/authentication/login/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await CashHelper.initi();

  // uId = CashHelper.getData(key: 'uId');
  // Widget widget;
  // if (uId != null) {
  //   // widget = const SocialLayout();
  // } else {
  //   widget = const LoginScreen();
  // }
  runApp(const MyApp(startWidget: LoginScreen()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.startWidget}) : super(key: key);
  final Widget startWidget;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(),
        ),
        BlocProvider<UserCubit>(
          create: (context) => UserCubit(),
        ),
        BlocProvider<SocialCubit>(
          create: (context) => SocialCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: defultColor,
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
