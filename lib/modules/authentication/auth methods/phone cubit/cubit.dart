// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mega_chat/modules/authentication/auth%20methods/phone%20cubit/phone_states.dart';

class PhoneAuthCubit extends Cubit<PhoneStates> {
  PhoneAuthCubit() : super(SignInInitialState());

  static PhoneAuthCubit get(context) => BlocProvider.of(context);

  late PhoneNumber number =
      PhoneNumber(phoneNumber: '+201201742990', dialCode: '+20', isoCode: 'EG');
  String verificationCode = '';
  String? verificationIdResent ;

  void onInputChanged(PhoneNumber newNumber) {
    number = newNumber;
    print('number ${number}');
    // emit(NumberChangedState());
  }

  void setVerificationCode(String newCode) {
    verificationCode = newCode;
    emit(CodeChangedState());
  }

  void sendVerificationId(String vId) {
    verificationIdResent = vId;
    emit(VerificationIdChangedState());
  }
}
