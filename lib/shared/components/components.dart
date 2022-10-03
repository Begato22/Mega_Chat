import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../layouts/social layout/social_layout.dart';
import '../../modules/authentication/auth methods/auth cubit/cubit.dart';
import '../../modules/authentication/auth methods/auth cubit/states.dart';
import '../../modules/authentication/opt/phone_screen.dart';
import '../styles/colors.dart';

Widget defultTextField({
  required TextEditingController controller,
  required TextInputType keyboardType,
  required IconData prefix,
  IconData? suffix,
  Function? suffixFunc,
  required Function validator,
  required String label,
  bool obscureText = false,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        prefixIcon: Icon(prefix),
        suffixIcon: GestureDetector(
          child: Icon(suffix),
          onTap: () => suffixFunc!(),
        ),
        label: Text(label),
        border: const OutlineInputBorder(),
      ),
      obscureText: obscureText,
      validator: (val) => validator(val),
    );

Widget defultButton({
  required Function onPressed,
  required String lable,
  bool isDisabled = false,
  Color color = defultColor,
}) =>
    SizedBox(
      width: double.infinity,
      height: 50.0,
      child: ElevatedButton(
        onPressed: () => isDisabled ? null : onPressed(),
        style: ElevatedButton.styleFrom(
          backgroundColor: isDisabled ? Colors.grey : defultColor,
        ),
        child: Text(
          lable.toUpperCase(),
        ),
      ),
    );

void navigateTo(context, Widget screen) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
void navigateAndRemoveTo(context, Widget screen) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => screen),
      (Route<dynamic> route) => false,
    );

Widget defultTextButton({
  required Function onPressed,
  required String lable,
  Color lableColor = defultColor,
}) =>
    TextButton(
      onPressed: () => onPressed(),
      child: Text(
        lable.toUpperCase(),
        style: TextStyle(
          color: lableColor,
        ),
      ),
    );

enum ToastState { success, error, warning }

Future<bool?> showToast(String message, ToastState state) =>
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 6,
      backgroundColor: changeColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );
Color changeColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.success:
      color = Colors.green;
      break;
    case ToastState.error:
      color = Colors.red;
      break;
    case ToastState.warning:
      color = Colors.amber;
      break;
  }
  return color;
}

Widget customDividorText(String text) {
  return Row(
    children: <Widget>[
      const Expanded(child: Divider(thickness: 2)),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(text.toUpperCase()),
      ),
      const Expanded(child: Divider(thickness: 2)),
    ],
  );
}

Widget buildCircluerIconButton({
  required IconData iconData,
  required Function onPressed,
}) {
  return CircleAvatar(
    radius: 22,
    backgroundColor: Colors.grey[200],
    child: IconButton(
      onPressed: () {
        onPressed();
      },
      icon: Icon(
        iconData,
        color: defultColor,
      ),
    ),
  );
}

Widget buildMediaAcc(BuildContext context) {
  return BlocConsumer<AuthCubit, AuthStates>(
    listener: (context, state) {},
    builder: (context, state) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildCircluerIconButton(
            iconData: Icons.facebook,
            onPressed: () {
              AuthCubit.get(context).signInWithFacebook(context).then(
                (value) {
                  navigateAndRemoveTo(context, const ProfileScreen());
                },
              );
            },
          ),
          const SizedBox(width: 5),
          buildCircluerIconButton(
            iconData: Icons.mail,
            onPressed: () async {
              await AuthCubit.get(context).signInWithGmail(context).then(
                (value) {
                  navigateAndRemoveTo(context, const ProfileScreen());
                },
              );
            },
          ),
          const SizedBox(width: 5),
          BlocConsumer<AuthCubit, AuthStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return buildCircluerIconButton(
                iconData: Icons.phone,
                onPressed: () {
                  navigateTo(context, PhoneScreen());
                },
              );
            },
          ),
        ],
      );
    },
  );
}
