// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mega_chat/shared/components/components.dart';

import '../../modules/authentication/login/login_screen.dart';
import '../networks/local/cach_helper.dart';

void makeStatusBarTransparent() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
}

void logOut(context) {
  CashHelper.removeData(key: 'uId').then(
    (value) {
      if (value) {
        navigateAndRemoveTo(context, const LoginScreen());
      }
    },
  ).catchError((onError) {
    print(onError.toString());
  });
}

dynamic uId = '';

// LoginMethod loginMethod = LoginMethod.normal;

String googleMapKey = "AIzaSyCvEXcvKlGVB-qv6LsQq6jlmWIhOHv4ZAg";
