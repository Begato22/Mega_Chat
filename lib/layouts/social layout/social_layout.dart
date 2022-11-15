import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mega_chat/layouts/social%20layout/social%20cubit/cubit.dart';
import 'package:mega_chat/layouts/social%20layout/social%20cubit/states.dart';
import 'package:mega_chat/modules/authentication/auth%20methods/auth%20cubit/cubit.dart';
import 'package:mega_chat/modules/authentication/auth%20methods/auth%20cubit/states.dart';
import 'package:mega_chat/modules/new%20post/new_post_screen.dart';
import 'package:mega_chat/modules/notifications/notification.dart';
import 'package:mega_chat/shared/components/components.dart';
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
              listener: (context, state) {
                if (state is SignOutSuccessState) {
                  socialCubit.currentIndex = 0;
                }
              },
              builder: (context, state) {
                var user = AuthCubit.get(context);
                return Row(
                  children: [
                    InkWell(
                      onTap: (() {
                        socialCubit.changeNavigationBarScreen(4);
                      }),
                      child: CircleAvatar(
                        backgroundImage: Image.network(
                          user.userModel.imgUrl!,
                        ).image,
                        radius: 15,
                      ),
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
                  children: [
                    const CircleAvatar(
                      radius: 15,
                      child: Icon(
                        IconBroken.Search,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 5),
                    InkWell(
                      onTap: () =>
                          navigateTo(context, const NotificationScreen()),
                      child: Badge(
                        position: BadgePosition.topEnd(top: -10, end: -5),
                        badgeContent: const Text(
                          "10",
                          style: TextStyle(fontSize: 10, color: Colors.white),
                        ),
                        child: const CircleAvatar(
                          radius: 15,
                          child: Icon(
                            IconBroken.Notification,
                            size: 18,
                          ),
                        ),
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
              Icons.post_add_outlined,
              size: 30,
            ),
            onPressed: () {
              navigateTo(context, const NewPostScreen());
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
