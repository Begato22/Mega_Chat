import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mega_chat/blocs/auth_cubit/cubit.dart';
import 'package:mega_chat/blocs/auth_cubit/states.dart';

import '../../shared/components/components.dart';

import 'otp_screen.dart';

class PhoneScreen extends StatelessWidget {
  PhoneScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Form(
            key: formKey,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Phone Number',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Enter your phone number to verify your account',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 50),
                  InternationalPhoneNumberInput(
                    validator: (number) {
                      String pattern = r'^(?:[+0][1-9])?[0-9]{10,12}$';
                      RegExp regExp = RegExp(pattern);
                      regExp.hasMatch(number.toString());
                      return null;
                    },
                    onInputChanged: (PhoneNumber number) {
                      cubit.onInputChanged(number);
                    },
                    onInputValidated: (bool value) {},
                    selectorConfig: const SelectorConfig(
                      selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                    ),
                    ignoreBlank: false,
                    autoValidateMode: AutovalidateMode.disabled,
                    selectorTextStyle: const TextStyle(color: Colors.black),
                    initialValue: PhoneNumber(
                      phoneNumber: '01201742990',
                      dialCode: '+20',
                      isoCode: 'EG',
                    ),
                    textFieldController: phoneController,
                    formatInput: false,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputBorder: const OutlineInputBorder(),
                    maxLength: 11,
                  ),
                  const SizedBox(height: 15),
                  defultButton(
                    onPressed: () {
                      try {
                        FocusScope.of(context).unfocus();
                        FirebaseAuth.instance.verifyPhoneNumber(
                          phoneNumber: cubit.number.phoneNumber,
                          timeout: const Duration(seconds: 20),
                          verificationCompleted: (phoneAuthCredential) {
                            print('@@ verificationCompleted');
                          },
                          verificationFailed: (error) {
                            showToast(error.toString(), ToastState.error);
                          },
                          codeSent: (verificationId, forceResendingToken) {
                            navigateTo(context,
                                OtpScreen(verificationId: verificationId));
                          },
                          codeAutoRetrievalTimeout: (verificationId) {
                            print('timeout');
                            print(verificationId);
                            cubit.sendVerificationId(verificationId);
                          },
                        );
                      } catch (e) {
                        print('@@ ${e.toString()}');
                      }
                    },
                    lable: 'Validate',
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
