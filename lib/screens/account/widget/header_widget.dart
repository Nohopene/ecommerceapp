import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constanst/color_constant.dart';
import '../../../models/user_model.dart';
import '../../../services/user_service.dart';
import '../../../widget/circle_icon_button.dart';

class HeaderProfileWidget extends StatefulWidget {
  const HeaderProfileWidget({
    super.key,
    required this.height,
    required this.heightAva,
    required this.widthAva,
    required this.size,
  });
  final double height, heightAva, widthAva, size;

  @override
  State<HeaderProfileWidget> createState() => _HeaderProfileWidgetState();
}

class _HeaderProfileWidgetState extends State<HeaderProfileWidget> {
  UserService _service = UserService();
  @override
  Widget build(BuildContext context) {
    void _imagePicker() async {
      ImagePicker imagePicker = ImagePicker();

      XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
      print('${file?.path}');
      if (file == null) return;

      String uniqueFilename = DateTime.now().millisecondsSinceEpoch.toString();

      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceDirImages = referenceRoot.child('images');

      Reference referenceImagetoUpload =
          referenceDirImages.child(uniqueFilename);
      try {
        await referenceImagetoUpload.putFile(File(file!.path));
        await referenceImagetoUpload.getDownloadURL().then((value) {
          _service.updateImage(image: value);
        });
      } catch (e) {}
    }

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
                height: widget.height,
                color: primaryColor,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: widget.heightAva,
                          width: widget.widthAva,
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
                            onPressed: () {
                              _imagePicker();
                            },
                            svgIcon: 'assets/icons/Camera Icon.svg',
                            color: cardShadowColor,
                            size: widget.size,
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
