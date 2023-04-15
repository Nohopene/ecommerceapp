import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:sizer/sizer.dart';

import '../../../constanst/color_constant.dart';
import '../../../models/user_model.dart';
import '../../../widget/circle_icon_button.dart';

class HeaderProfileWidget extends StatelessWidget {
  const HeaderProfileWidget({
    super.key,
    required this.height,
    required this.heightAva,
    required this.widthAva,
    required this.size,
  });
  final double height, heightAva, widthAva, size;
  @override
  Widget build(BuildContext context) {
    return FirestoreQueryBuilder<UserModel>(
        query: userQuery(),
        builder: (context, snapshot, _) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.docs.length,
            itemBuilder: (context, index) {
              // if we reached the end of the currently obtained items, we try to
              // obtain more items
              if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
                // Tell FirestoreQueryBuilder to try to obtain more items.
                // It is safe to call this function from within the build method.
                snapshot.fetchMore();
              }
              var user = snapshot.docs[index];

              UserModel userModel = user.data();
              return Container(
                width: double.infinity,
                height: height,
                color: primaryColor,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: heightAva,
                          width: widthAva,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: CircleAvatar(
                            backgroundImage: userModel.image!.isEmpty
                                ? const AssetImage(
                                    'assets/images/default_avatar.jpg')
                                : CachedNetworkImageProvider(
                                        userModel.image.toString())
                                    as ImageProvider<Object>,
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: CircleIconButton(
                            onPressed: () {},
                            svgIcon: 'assets/icons/Camera Icon.svg',
                            color: cardShadowColor,
                            size: size,
                          ),
                        )
                      ],
                    ),
                    Text(
                      userModel.name.toString(),
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
              );
            },
          );
        });
  }
}
