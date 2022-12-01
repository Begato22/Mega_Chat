import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mega_chat/blocs/auth_cubit/cubit.dart';
import 'package:mega_chat/blocs/auth_cubit/states.dart';
import 'package:mega_chat/shared/components/components.dart';
import 'package:mega_chat/shared/styles/colors.dart';
import 'package:mega_chat/shared/styles/icons_broken.dart';
import 'package:progress_indicators/progress_indicators.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final fisrtNameController = TextEditingController();

  final lastNameController = TextEditingController();

  final phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var user = AuthCubit.get(context);
        var size = MediaQuery.of(context).size;

        var lastName = '';
        var nameAsList = user.userModel.name!.split(" ");
        for (var i = 1; i < nameAsList.length; i++) {
          lastName = '$lastName ${nameAsList[i]}'.trim();
        }

        return Scaffold(
          appBar: defaultAppBar(
            'Edit Profile Screen',
            IconButton(
              onPressed: user.isUpdate
                  ? null
                  : () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.of(context).pop();
                        user.coverImage = null;
                        user.profileImage = null;
                      }
                    },
              icon: Icon(
                IconBroken.Arrow___Left_2,
                color:
                    user.isUpdate ? Colors.grey.withOpacity(0.5) : Colors.white,
              ),
            ),
            !user.isUpdate
                ? defultTextButton(
                    onPressed: () {
                      if (fisrtNameController.text.isEmpty &&
                          lastNameController.text.isEmpty &&
                          phoneController.text.isEmpty &&
                          user.coverImage == null &&
                          user.profileImage == null) {
                        showToast('No Data was updated', ToastState.warning);
                      } else {
                        user.updateUserData(
                          '${fisrtNameController.text.isEmpty ? nameAsList[0] : fisrtNameController.text} ${lastNameController.text.isEmpty ? lastName : lastNameController.text}',
                          '${phoneController.text.isEmpty ? user.userModel.phone : phoneController.text}',
                        );
                      }
                    },
                    lable: 'update',
                    lableColor: Colors.white,
                  )
                : Padding(
                    padding: EdgeInsets.all(22),
                    child: SizedBox(
                      width: 10,
                      height: 10,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    ),
                  ),
          ),
          body:
              // state == GetUserLoading
              //     ? const Center(child: CircularProgressIndicator())
              //     :
              SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.37,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 200,
                                decoration: const BoxDecoration(
                                  color: defaultColor,
                                ),
                                child: user.coverImage == null
                                    ? Image.network(
                                        user.userModel.cover!,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.file(user.coverImage!),
                              ),
                              Positioned(
                                right: size.width * 0.05,
                                top: size.width * 0.05,
                                child: GestureDetector(
                                  onTap: () async {
                                    await user.pickCoverImage();
                                  },
                                  child: const CircleAvatar(
                                    radius: 15,
                                    child: Icon(IconBroken.Camera, size: 18),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 83,
                              backgroundColor: defaultColor,
                              child: CircleAvatar(
                                backgroundImage: user.profileImage == null
                                    ? Image.network(
                                        user.userModel.imgUrl!,
                                        fit: BoxFit.cover,
                                      ).image
                                    : Image.file(user.profileImage!).image,
                                radius: 80,
                                backgroundColor: defaultColor,
                              ),
                            ),
                            Positioned(
                              right: size.width * 0.05,
                              child: GestureDetector(
                                onTap: () async {
                                  await user.pickProfileImage();
                                },
                                child: const CircleAvatar(
                                  radius: 15,
                                  child: Icon(
                                    IconBroken.Camera,
                                    size: 18,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        defaultTextField(
                          controller: fisrtNameController,
                          keyboardType: TextInputType.name,
                          prefix: IconBroken.Profile,
                          validator: (val) {
                            print('You must enter valid value');
                          },
                          label: nameAsList[0],
                        ),
                        const SizedBox(height: 10),
                        defaultTextField(
                          controller: lastNameController,
                          keyboardType: TextInputType.name,
                          prefix: IconBroken.Profile,
                          validator: (val) {
                            print('You must enter valid value');
                          },
                          label: lastName.trim(),
                        ),
                        const SizedBox(height: 10),
                        defaultTextField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          prefix: IconBroken.Call,
                          validator: (val) {
                            print('You must enter valid value');
                          },
                          label: user.userModel.phone!,
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
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
