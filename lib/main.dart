import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mega_chat/layouts/social%20layout/social%20cubit/cubit.dart';
import 'package:mega_chat/layouts/social%20layout/social_layout.dart';
import 'package:mega_chat/layouts/social%20layout/user%20cubit/cubit.dart';
import 'package:mega_chat/models/user%20model/user_model.dart';
import 'package:mega_chat/modules/authentication/auth%20methods/auth%20cubit/cubit.dart';
import 'package:mega_chat/modules/authentication/auth%20methods/auth%20cubit/states.dart';
import 'package:mega_chat/modules/loader/loader_screen.dart';
import 'package:mega_chat/shared/components/constants.dart';
import 'package:mega_chat/shared/my_bloc_observer.dart';
import 'package:mega_chat/shared/networks/local/cach_helper.dart';
import 'package:mega_chat/shared/styles/themes.dart';

import 'modules/authentication/login/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await CashHelper.initi();
  print('kkkkk ${LoginMethod.google}');
  uId = CashHelper.getData(key: 'id');
  Widget widget;
  if (uId != null) {
    print("before loading");
    widget = const LoaderScreen();
  } else {
    widget = const LoginScreen();
  }
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
          create: (context) => AuthCubit(),
        ),
        BlocProvider<UserCubit>(
          create: (context) => UserCubit(),
        ),
        BlocProvider<SocialCubit>(
          create: (context) => SocialCubit(),
        ),
      ],
      child: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var loginMethod = CashHelper.getData(key: 'loginMethod');
          var cubit = AuthCubit.get(context);
          print(
              '@@ this login method in cash helper provided  before checking : ${CashHelper.getData(key: 'loginMethod')}');
          print(
              '@@ this uId in cash helper provided  before checking : ${CashHelper.getData(key: 'id')}');
          if (loginMethod != null) {
            print('loginMthod is not null.');
            if (loginMethod == LoginMethod.facebook) {
              print('@@ we will get data from facebook login');
              cubit.signInWithFacebook(context);
            } else if (loginMethod == '$loginMethod') {
              cubit.getUser(uId, LoginMethod.google);
              print(
                  '@@ we will get data from google login ${cubit.userModel.loginMethod}');
            }
          }
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
