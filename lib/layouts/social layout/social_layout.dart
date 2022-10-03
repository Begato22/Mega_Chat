import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mega_chat/layouts/social%20layout/social%20cubit/cubit.dart';
import 'package:mega_chat/layouts/social%20layout/social%20cubit/states.dart';

import '../../modules/authentication/auth methods/auth cubit/cubit.dart';
import '../../modules/authentication/auth methods/auth cubit/states.dart';
import '../../modules/authentication/auth methods/facebook cubit/cubit.dart';
import '../../shared/components/constants.dart';
import '../../shared/styles/colors.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    makeStatusBarTransparent();
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        // cubit.getUser();
        return Scaffold(
          appBar: AppBar(
            actions: [
              BlocConsumer<AuthCubit, AuthStates>(
                listener: (BuildContext context, state) {},
                builder: (BuildContext context, state) {
                  print('from screen ');

                  return Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: Image.network(
                            AuthCubit.get(context).userModel.imgUrl!,
                          ).image,
                        )
                      ],
                    ),
                  );
                },
              )
            ],
          ),
          body:
              // state == GetUserLoading
              //     ? const Center(child: CircularProgressIndicator())
              //     :
              Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
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
                    // backgroundImage: Image.network(
                    //   googleSignInAccount.photoUrl!,
                    //   fit: BoxFit.cover,
                    // ).image,
                    radius: 60,
                    backgroundColor: defultColor,
                  ),
                  SizedBox(height: 20),
                  // Text(googleSignInAccount.displayName!),
                  // Text(googleSignInAccount.email),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
