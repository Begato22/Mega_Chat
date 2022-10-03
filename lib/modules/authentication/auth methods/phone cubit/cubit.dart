// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mega_chat/modules/authentication/auth%20methods/phone%20cubit/phone_states.dart';

class PhoneAuthCubit extends Cubit<PhoneStates> {
  PhoneAuthCubit() : super(SignInInitialState());

  static PhoneAuthCubit get(context) => BlocProvider.of(context);

  PhoneNumber number = PhoneNumber(isoCode: 'EG');

  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber newNumber =
        await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'US');

    number = newNumber;
  }

  void onInputChanged(PhoneNumber number) {
    print(number.phoneNumber);
  }
}
