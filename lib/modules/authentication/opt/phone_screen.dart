import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../shared/components/components.dart';
import '../auth methods/phone cubit/cubit.dart';
import '../auth methods/phone cubit/phone_states.dart';
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
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Phone Number',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Enter your phone number to verify your account',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 50),
                    InternationalPhoneNumberInput(
                      onInputChanged: (PhoneNumber number) =>
                          cubit.onInputChanged(number),
                      onInputValidated: (bool value) {
                        print(value);
                      },
                      selectorConfig: SelectorConfig(
                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                      ),
                      ignoreBlank: false,
                      autoValidateMode: AutovalidateMode.disabled,
                      selectorTextStyle: TextStyle(color: Colors.black),
                      initialValue: PhoneNumber(phoneNumber: '01000000000'),
                      textFieldController: phoneController,
                      formatInput: false,
                      keyboardType: TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                      inputBorder: OutlineInputBorder(),
                      maxLength: 10,
                    ),
                    SizedBox(height: 15),
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
