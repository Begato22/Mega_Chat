// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mega_chat/layouts/social%20layout/social%20cubit/states.dart';
import 'package:mega_chat/modules/chats/chat_screen.dart';
import 'package:mega_chat/modules/feeds/feed_screen.dart';
import 'package:mega_chat/modules/new%20post/new_post_screen.dart';
import 'package:mega_chat/modules/other/other_screen.dart';
import 'package:mega_chat/modules/profile/profile_screen.dart';
import 'package:mega_chat/modules/settings/settings_screen.dart';
import 'package:mega_chat/modules/users/users_screen.dart';
import 'package:mega_chat/shared/styles/icons_broken.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInisialStates());
  static SocialCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<IconData> iconList = [
    IconBroken.Home,
    IconBroken.Chat,
    IconBroken.Location,
    IconBroken.Setting,
  ];

  List<Widget> screens = const [
    FeedsScreen(),
    ChatScreen(),
    UsersScreen(),
    SettingsScreen(),
    ProfileScreen()
  ];

  void changeNavigationBarScreen(int index) {
    currentIndex = index;
    emit(ChangeNavigationBarScreen());
  }
}
