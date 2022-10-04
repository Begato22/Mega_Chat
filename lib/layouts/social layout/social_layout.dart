import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mega_chat/layouts/social%20layout/social%20cubit/cubit.dart';
import 'package:mega_chat/layouts/social%20layout/social%20cubit/states.dart';
import 'package:mega_chat/modules/authentication/auth%20methods/auth%20cubit/cubit.dart';
import 'package:mega_chat/modules/authentication/auth%20methods/auth%20cubit/states.dart';
import 'package:mega_chat/shared/styles/colors.dart';
import 'package:mega_chat/shared/styles/icons_broken.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var socialCubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: BlocConsumer<AuthCubit, AuthStates>(
              listener: (context, state) {},
              builder: (context, state) {
                var user = AuthCubit.get(context);
                return Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: Image.network(
                        user.userModel.imgUrl!,
                      ).image,
                      radius: 15,
                    ),
                    const SizedBox(width: 5),
                    const Text('MegaChat'),
                  ],
                );
              },
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Row(
                  children: const [
                    CircleAvatar(
                      radius: 15,
                      child: Icon(
                        IconBroken.Search,
                        size: 18,
                      ),
                    ),
                    SizedBox(width: 5),
                    CircleAvatar(
                      radius: 15,
                      child: Icon(
                        IconBroken.Notification,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          body: Container(
            child: socialCubit.screens[socialCubit.currentIndex],
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(
              IconBroken.Profile,
              size: 30,
            ),
            onPressed: () {
              socialCubit.changeNavigationBarScreen(4);
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: AnimatedBottomNavigationBar(
            icons: socialCubit.iconList,
            activeIndex: socialCubit.currentIndex,
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.verySmoothEdge,
            onTap: (index) {
              socialCubit.changeNavigationBarScreen(index);
            },
            activeColor: defaultColor,
          ),
        );
      },
    );
  }
}
