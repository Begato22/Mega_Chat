import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import '../../../shared/styles/colors.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
              children: const [
                Text(
                  'Verification Code',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                SizedBox(height: 15),
                Text(
                  'We text you a code please enter it below',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          OtpTextField(
            autoFocus: true,
            numberOfFields: 5,
            borderColor: defaultColor,
            //set to true to show as box or false to show as dash
            showFieldAsBox: true,
            //runs when a code is typed in
            onCodeChanged: (String code) {
              //handle validation or checks here
            },
            //runs when every textfield is filled
            onSubmit: (String verificationCode) {
              //to auto close keyboard.
              FocusScope.of(context);
              // showDialog(
              //   context: context,
              //   builder: (context) {
              //     return AlertDialog(
              //       title: Text("Verification Code"),
              //       content: Text('Code entered is $verificationCode'),
              //     );
              //   },
              // );
            }, // end onSubmit
          ),
        ],
      ),
    );
  }
}
