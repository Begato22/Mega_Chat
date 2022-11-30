import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:mega_chat/blocs/auth_cubit/cubit.dart';
import 'package:mega_chat/blocs/auth_cubit/states.dart';


import '../../shared/styles/colors.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({Key? key, required this.verificationId}) : super(key: key);
  final String verificationId;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 20;
        var cubit = AuthCubit.get(context);

        return Scaffold(
          appBar: AppBar(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.17),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Verification Code',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'We text you a code please enter it below to ${cubit.number.phoneNumber}',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              OtpTextField(
                autoFocus: true,
                numberOfFields: 6,
                borderColor: defaultColor,
                //set to true to show as box or false to show as dash
                showFieldAsBox: true,
                //runs when a code is typed in
                onCodeChanged: (String code) {
                  cubit.setVerificationCode(cubit.verificationCode + code);
                  debugPrint('@@ ${cubit.verificationCode}');
                },
                //runs when every textfield is filled
                onSubmit: (String verificationCode) async {
                  FocusScope.of(context);
                  debugPrint('@@ ${cubit.verificationCode}');
                  debugPrint('***************** $verificationId');
                  cubit.signInWithPhoneNumber(verificationId);
                }, // end onSubmit
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (cubit.verificationIdResent == null)
                    CountdownTimer(
                      endTime: endTime,
                    ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: cubit.verificationIdResent == null
                        ? null
                        : () {
                            debugPrint('object');
                          },
                    child: Text(
                      'Resend Code',
                      style: TextStyle(
                          color: cubit.verificationIdResent == null
                              ? Colors.grey
                              : Colors.blue),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
