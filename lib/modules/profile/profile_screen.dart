import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mega_chat/models/user%20model/user_model.dart';
import 'package:mega_chat/modules/authentication/login/login_screen.dart';
import 'package:mega_chat/shared/components/components.dart';

import '../authentication/auth methods/auth cubit/cubit.dart';
import '../authentication/auth methods/auth cubit/states.dart';
import '../../shared/components/constants.dart';
import '../../shared/styles/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    makeStatusBarTransparent();
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var user = AuthCubit.get(context);
        return Scaffold(
          body:
              // state == GetUserLoading
              //     ? const Center(child: CircularProgressIndicator())
              //     :
              Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: SizedBox(
              width: double.infinity,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Container(
                      //   padding: const EdgeInsets.only(left: 20.0),
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(20),
                      //     color: Colors.amber.withOpacity(0.6),
                      //   ),
                      //   child: Row(
                      //     children: [
                      //       const Icon(Icons.info_outline),
                      //       const SizedBox(width: 5),
                      //       Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: const [
                      //           Text('Please Verify your mail'),
                      //           Text(
                      //             ' cubit.userModel!.email',
                      //             style: TextStyle(
                      //                 color: Colors.grey, fontSize: 12),
                      //           ),
                      //         ],
                      //       ),
                      //       const Spacer(),
                      //       defultTextButton(
                      //           onPressed: () {
                      //             FirebaseAuth.instance.currentUser!
                      //                 .sendEmailVerification()
                      //                 .then((value) {
                      //               showToast(
                      //                   'verified mail sent Successfully',
                      //                   ToastState.success);
                      //             });
                      //           },
                      //           lable: 'send'),
                      //     ],
                      //   ),
                      // )
                      CircleAvatar(
                        radius: 62,
                        backgroundColor: defaultColor,
                        child: CircleAvatar(
                          backgroundImage: Image.network(
                            user.userModel.imgUrl!,
                            fit: BoxFit.cover,
                          ).image,
                          radius: 60,
                          backgroundColor: defaultColor,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        user.userModel.name!,
                        style: const TextStyle(
                            fontSize: 30,
                            fontFamily: 'JosefinSlab',
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(user.userModel.email),
                      const SizedBox(height: 20),
                      defultButton(
                        onPressed: () {
                          if (user.userModel.loginMethod ==
                              LoginMethod.facebook) {
                            user.signOutWithFacebook().then((value) {
                              navigateAndRemoveTo(context, const LoginScreen());
                            }).catchError((onError) {});
                          } else if (user.userModel.loginMethod ==
                              LoginMethod.google) {
                            user.signOutWithGmail().then((value) {
                              navigateAndRemoveTo(context, const LoginScreen());
                            }).catchError((onError) {});
                          }
                        },
                        lable: 'logout',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
