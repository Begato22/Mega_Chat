import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mega_chat/modules/authentication/auth%20methods/phone%20cubit/cubit.dart';
import 'package:mega_chat/modules/authentication/auth%20methods/phone%20cubit/phone_states.dart';

import '../../../shared/components/components.dart';

import 'otp_screen.dart';

class PhoneScreen extends StatelessWidget {
  PhoneScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PhoneAuthCubit>(
      create: (context) => PhoneAuthCubit(),
      child: BlocConsumer<PhoneAuthCubit, PhoneStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = PhoneAuthCubit.get(context);
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Enter your phone number to verify your account',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 50),
                    InternationalPhoneNumberInput(
                      onInputChanged: (PhoneNumber number) =>
                          cubit.onInputChanged(number),
                      onInputValidated: (bool value) {},
                      selectorConfig: const SelectorConfig(
                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                      ),
                      ignoreBlank: false,
                      autoValidateMode: AutovalidateMode.disabled,
                      selectorTextStyle: const TextStyle(color: Colors.black),
                      initialValue: PhoneNumber(phoneNumber: '01000000000'),
                      textFieldController: phoneController,
                      formatInput: false,
                      keyboardType: const TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                      inputBorder: const OutlineInputBorder(),
                      maxLength: 10,
                    ),
                    const SizedBox(height: 15),
                    defultButton(
                        onPressed: () {
                          navigateAndRemoveTo(context, const OtpScreen());
                        },
                        lable: 'Validate')
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
