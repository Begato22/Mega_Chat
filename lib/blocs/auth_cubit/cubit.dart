// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mega_chat/blocs/auth_cubit/states.dart';
import 'package:mega_chat/shared/components/components.dart';
import 'package:mega_chat/shared/networks/local/cach_helper.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../models/user model/user_model.dart';
import '../../shared/components/constants.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialState());

  static AuthCubit get(context) => BlocProvider.of(context);

  bool securassword = true;
  IconData visibleIcon = Icons.visibility;
  void changeVisability() {
    if (securassword) {
      visibleIcon = Icons.visibility_off;
      securassword = !securassword;
    } else {
      visibleIcon = Icons.visibility;
      securassword = !securassword;
    }
    emit(SignInChangeVisabilityState());
  }

  late UserModel userModel;

  void createFakeUser() {
    userModel = UserModel('uId', 'name', 'email', 'imgUrl', 'cover', 'phone');
  }

  Future<void> createUser({
    required String name,
    required String email,
    required String uid,
    String? cover,
    String? imageUrl,
    String? phone,
  }) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'name': name,
      'email': email,
      'uid': uid,
      'cover': cover ??
          'https://timelinecovers.pro/facebook-cover/download/oh-wow-sarcastic-facebook-cover.jpg',
      'imageUrl': imageUrl ??
          'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=740&t=st=1664890049~exp=1664890649~hmac=d0051e6c4e9f238987ba4326c6e13483b0126edd42b2df72dc6279219fbf8794',
      'phone': phone ?? '01 **** ** ***',
    }).then(
      (value) {
        emit(CreateUserSuccessState());
      },
    ).catchError(
      (onError) {
        print(onError.toString());
        emit(CreateUserErrorState(onError.toString()));
      },
    );
  }

  void getUser(String id, LoginMethod loginMethod) {
    FirebaseFirestore.instance.collection('users').doc(id).get().then(
      (value) {
        emit(GetUserLoadingState());
        userModel = UserModel.fromJson(value.data());
        userModel.loginMethod = loginMethod;
        CashHelper.setData(key: 'id', value: value['uid']);
        CashHelper.setData(key: 'loginMethod', value: '$loginMethod');
        uId = value['uid'];
        print('before emit');
        emit(GetUserSuccessState());
      },
    ).catchError((onError) {
      emit(GetUserErrorState());
    });
  }

  // **************************** phone verification ****************************
  PhoneNumber number = PhoneNumber(dialCode: '+20', isoCode: 'EG');
  String verificationCode = '';
  String? verificationIdResent;

  void setVerificationCode(String newCode) {
    verificationCode = newCode;
    emit(CodeChangedState());
  }

  void onInputChanged(PhoneNumber newNumber) {
    number = newNumber;
    print('number $number');
    // emit(NumberChangedState());
  }

  void sendVerificationId(String vId) {
    verificationIdResent = vId;
    emit(VerificationIdChangedState());
  }

  Future<void> signInWithPhoneNumber(String verificationId) async {
    emit(SignInLodingState());
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: verificationCode,
    );
    FirebaseAuth.instance.signInWithCredential(credential).then(
      (value) async {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(value.user!.uid)
            .set({
          'name': 'MegaChat Usre',
          'email': 'demo.email@mega.com',
          'uid': value.user!.uid,
          'cover':
              'https://timelinecovers.pro/facebook-cover/download/oh-wow-sarcastic-facebook-cover.jpg',
          'imageUrl':
              'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=740&t=st=1664890049~exp=1664890649~hmac=d0051e6c4e9f238987ba4326c6e13483b0126edd42b2df72dc6279219fbf8794',
          'phone': number.phoneNumber ?? '01 **** ** ***',
        }).then(
          (value) {
            emit(CreateUserSuccessState());
          },
        ).catchError(
          (onError) {
            print(onError.toString());
            emit(CreateUserErrorState(onError.toString()));
          },
        );
        getUser(value.user!.uid, LoginMethod.phoneNumber);
        if (FirebaseAuth.instance.currentUser != null) {
          emit(SignInSuccessState());
          verificationCode = '';
        }
      },
    ).catchError(
      (err) {
        print(err.toString());
        emit(SignInErrorState(err.toString()));
      },
    );
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(SignInLodingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      getUser(value.user!.uid, LoginMethod.normal);
      emit(SignInSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(SignInErrorState(onError.toString()));
    });
  }

  Future<void> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    emit(SignUpLodingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then(
      (value) {
        createUser(
            name: name, email: email, uid: value.user!.uid, phone: phone);
        emit(SignUpSuccessState());
      },
    ).catchError(
      (onError) {
        emit(SignUpErrorState(onError.toString()));
      },
    );
  }

  final facebookAuthInstance = FacebookAuth.instance;
  final googleSignIn = GoogleSignIn();

  void signInWithSocialMediaAccount(LoginMethod loginMethod) async {
    emit(SignInLodingState());
    if (loginMethod == LoginMethod.facebook) {
      await facebookAuthInstance.login();
      facebookAuthInstance.getUserData().then((value) async {
        getUser(value['id'], loginMethod);
        // emit(SignInSuccessState());
      }).catchError((onError) {
        emit(SignInErrorState(onError.toString()));
      });
    } else if (loginMethod == LoginMethod.google) {
      await googleSignIn.signIn().then(
        (value) async {
          getUser(value!.id, loginMethod);
          print("object");
          // emit(SignInSuccessState());
        },
      ).catchError(
        (onError) {
          emit(SignInErrorState(onError.toString()));
        },
      );
    }
  }

  void signUpWithSocialMediaAccount(LoginMethod loginMethod) async {
    emit(SignUpLodingState());
    if (loginMethod == LoginMethod.facebook) {
      facebookAuthInstance.login().then((value) {
        facebookAuthInstance.getUserData().then((value) async {
          await createUser(
            name: value['name'],
            email: value['email'],
            uid: value['id'],
            imageUrl: value['picture']['data']['url'],
          );
          emit(SignUpSuccessState());
        }).catchError((onError) {
          emit(SignUpErrorState(onError.toString()));
        });
      });
    } else if (loginMethod == LoginMethod.google) {
      googleSignIn.signIn().then(
        (value) async {
          await createUser(
            name: value!.displayName!,
            email: value.email,
            uid: value.id,
            imageUrl: value.photoUrl,
          );
          emit(SignUpSuccessState());
        },
      ).catchError(
        (onError) {
          emit(SignUpErrorState(onError.toString()));
        },
      );
    }
  }

  void signOut(LoginMethod loginMethod) {
    emit(SignOutLodingState());
    if (loginMethod == LoginMethod.normal) {
      FirebaseAuth.instance.signOut().then(
        (value) {
          emit(SignOutSuccessState());
        },
      ).catchError(
        (onError) {
          emit(SignOutErrorState(onError.toString()));
        },
      );
    } else if (loginMethod == LoginMethod.facebook) {
      facebookAuthInstance.logOut().then(
        (value) {
          emit(SignOutSuccessState());
        },
      ).catchError(
        (onError) {
          emit(SignOutErrorState(onError.toString()));
        },
      );
    } else if (loginMethod == LoginMethod.google) {
      googleSignIn.signOut().then(
        (value) {
          emit(SignOutSuccessState());
        },
      ).catchError(
        (onError) {
          emit(SignOutErrorState(onError.toString()));
        },
      );
    }
  }

  XFile? pickedImage;
  File? profileImage;
  File? coverImage;
  var imagePicker = ImagePicker();
  bool isUpdate = false;

  Future<void> pickProfileImage() async {
    pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      profileImage = File(pickedImage!.path);
      emit(ProfilePicPickedSuccessState());
    }
  }

  Future<void> pickCoverImage() async {
    pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      coverImage = File(pickedImage!.path);
      emit(CoverPicPickedSuccessState());
    }
  }

  String profileUrlImage = '';

  Future<void> uploadProfileImage() async {
    try {
      var value = await firebase_storage.FirebaseStorage.instance
          .ref()
          .child('user/${Uri.file(pickedImage!.path).pathSegments.last}')
          .putFile(profileImage!);
      print('state ${value}');
      try {
        var imageUrl = await value.ref.getDownloadURL();
        print(imageUrl);
        profileUrlImage = imageUrl;
        emit(ProfileUploadSuccessState());
      } catch (e) {
        emit(ProfileUploadErrorState());
      }
    } catch (e) {
      emit(ProfileUploadErrorState());
    }
  }

  String coverUrlImage = '';

  Future<void> uploadCoverImage() async {
    try {
      var value = await firebase_storage.FirebaseStorage.instance
          .ref()
          .child('covers/${Uri.file(pickedImage!.path).pathSegments.last}')
          .putFile(coverImage!);

      var imageUrl = await value.ref.getDownloadURL();
      print(imageUrl);
      coverUrlImage = imageUrl;
      emit(CoverUploadSuccessState());
    } catch (e) {
      emit(CoverUploadErrorState());
    }
  }

  Future<void> updateUserData(String name, String phone) async {
    isUpdate = true;
    emit(UploadLoadingState());
    if (profileImage != null) {
      await uploadProfileImage();
      userModel.imgUrl = profileUrlImage;
    }
    if (coverImage != null) {
      await uploadCoverImage();
      userModel.cover = coverUrlImage;
    }

    UserModel updatedData = UserModel(
      userModel.uId,
      name,
      userModel.email,
      profileUrlImage.isEmpty ? userModel.imgUrl : profileUrlImage,
      coverUrlImage.isEmpty ? userModel.cover : coverUrlImage,
      phone,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .update(updatedData.toMap())
        .then((value) {
      getUser(userModel.uId, userModel.loginMethod);
      showToast('Your Data was Updated', ToastState.success);
      isUpdate = false;
      emit(UploadSuccessState());
    }).catchError((onError) {
      showToast('Error', ToastState.error);
      isUpdate = false;
      emit(UploadErrorState());
    });
  }
}
