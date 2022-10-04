import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mega_chat/modules/authentication/auth%20methods/auth%20cubit/cubit.dart';
import 'package:mega_chat/modules/authentication/auth%20methods/auth%20cubit/states.dart';
import 'package:mega_chat/shared/styles/icons_broken.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var user = AuthCubit.get(context);
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              buildPost(context),
              buildPost(context),
              buildPost(context),
            ],
          ),
        );
      },
    );
  }

  Widget buildPost(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: Image.network(
                                'https://img.freepik.com/premium-photo/young-arab-man-isolated-beige-background-smiles-pointing-fingers-mouth_1187-210769.jpg?w=996')
                            .image,
                        radius: 25,
                      ),
                      const SizedBox(width: 10.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Mohamed Ali',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(width: 5),
                              const Icon(
                                Icons.check_circle,
                                color: Colors.blue,
                                size: 16,
                              ),
                            ],
                          ),
                          Text(
                            'October 4, 2022 at 11:23am',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.more_horiz_rounded,
                          size: 20,
                        ),
                      )
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                    height: 20,
                  ),
                  const Text(
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the \'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.'),
                  const SizedBox(height: 10),
                  Container(
                    height: 250,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Image.network(
                      'https://img.freepik.com/free-photo/large-group-fans-with-arms-raised-having-fun-music-concert-night_637285-584.jpg?w=996&t=st=1664876193~exp=1664876793~hmac=e87ede6c0bca45a43bc7cb4b12bcaefb2eca7071fb153bd2376d445daa0c9abb',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      buildTypeUserReact(
                          context, Colors.red, IconBroken.Heart, '55'),
                      buildTypeUserReact(
                          context, Colors.amber, IconBroken.Chat, '55'),
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                    height: 20,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: Image.network(
                          AuthCubit.get(context).userModel.imgUrl!,
                        ).image,
                        radius: 15,
                      ),
                      SizedBox(width: 5),
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'Write a commint...',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ),
                        onTap: () {},
                      ),
                      Spacer(),
                      buildTypeUserReact(
                        context,
                        Colors.red,
                        IconBroken.Heart,
                        'Like',
                      ),
                      buildTypeUserReact(
                        context,
                        Colors.green,
                        IconBroken.Send,
                        'Share',
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildTypeUserReact(
    context,
    Color color,
    IconData iconData,
    String value,
  ) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Icon(
              iconData,
              color: color,
              size: 18,
            ),
            const SizedBox(width: 3),
            Text(
              value,
              style: Theme.of(context).textTheme.caption,
            ),
            const SizedBox(width: 12),
          ],
        ),
      ),
      onTap: () {},
    );
  }
}
