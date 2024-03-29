import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mega_chat/blocs/auth_cubit/cubit.dart';
import 'package:mega_chat/blocs/auth_cubit/states.dart';
import 'package:mega_chat/modules/edit%20profile/edit_profile_screen.dart';
import 'package:mega_chat/modules/login/login_screen.dart';
import 'package:mega_chat/shared/components/components.dart';
import 'package:mega_chat/shared/components/extensions.dart';
import 'package:mega_chat/shared/networks/local/cach_helper.dart';
import 'package:mega_chat/shared/styles/icons_broken.dart';

import '../../shared/components/constants.dart';
import '../../shared/styles/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    makeStatusBarTransparent();
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is SignOutSuccessState) {
          CashHelper.removeData(key: 'uId');
          CashHelper.removeData(key: 'loginMethod');
          uId = '';
          navigateAndRemoveTo(context, const LoginScreen());
        }
      },
      builder: (context, state) {
        var user = AuthCubit.get(context);
        var size = MediaQuery.of(context).size;
        return Scaffold(
          body:
              // state == GetUserLoading
              //     ? const Center(child: CircularProgressIndicator())
              //     :
              SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.37,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: double.infinity,
                          height: 200,
                          decoration: const BoxDecoration(
                            color: defaultColor,
                          ),
                          child: Image.network(
                            user.userModel.cover!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 83,
                        backgroundColor: defaultColor,
                        child: CircleAvatar(
                          backgroundImage: Image.network(
                            user.userModel.imgUrl!,
                            fit: BoxFit.cover,
                          ).image,
                          radius: 80,
                          backgroundColor: defaultColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  user.userModel.name!.capitalizeFirstOfEach,
                  style: const TextStyle(
                      fontSize: 30,
                      fontFamily: 'JosefinSlab',
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      buildUserRecordItem('Posts', '100'),
                      const Spacer(),
                      buildUserRecordItem('Photos', '266'),
                      const Spacer(),
                      buildUserRecordItem('Followers', '10k'),
                      const Spacer(),
                      buildUserRecordItem('Following', '4'),
                    ],
                  ),
                ),
                // const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: const ButtonStyle(),
                          onPressed: () {},
                          child: const Text('add photo'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      OutlinedButton(
                        onPressed: () {
                          navigateTo(context, EditProfileScreen());
                        },
                        child: const Icon(IconBroken.Edit),
                      )
                    ],
                  ),
                ),
                //ggggggg
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      buildUserDetailsItem(
                        IconBroken.Message,
                        user.userModel.email,
                      ),
                      const SizedBox(height: 10),
                      buildUserDetailsItem(
                        IconBroken.Call,
                        user.userModel.phone!,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: defultButton(
                    onPressed: () {
                      user.signOut(user.userModel.loginMethod);
                    },
                    lable: 'logout',
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        );
      },
    );
  }

  //I LOVE YOU
  Column buildUserRecordItem(String recordName, String recordValue) {
    return Column(
      children: [
        Text(
          recordValue,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          recordName,
          style: const TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Row buildUserDetailsItem(IconData iconData, String data) {
    return Row(
      children: [
        Icon(
          iconData,
          color: Colors.black38,
        ),
        const SizedBox(width: 5),
        Text(data)
      ],
    );
  }
}
