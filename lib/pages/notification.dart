import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../widgets/pick_image_widget.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  XFile? pickedImage;
  String? userReturnedUrl;

  Future<void> uploadUserImageAndGiveLink(
    BuildContext context,
  ) async {
    var uid = const Uuid();
    final ref = FirebaseStorage.instance
        .ref()
        .child('users_images')
        .child("${uid.v4()}.jpg");

    await ref.putFile(File(pickedImage!.path)).then((p0) async {
      await ref.getDownloadURL().then((url) {
        userReturnedUrl = url;
        print(userReturnedUrl ?? "No url found");
      });
    });
  }

  Future<void> localImagePicker() async {
    final ImagePicker picker = ImagePicker();
    await imagePickerDialog(
      context: context,
      cameraFCT: () async {
        pickedImage = await picker.pickImage(source: ImageSource.camera);
        setState(() {});
        await uploadUserImageAndGiveLink(context);
      },
      galleryFCT: () async {
        pickedImage = await picker.pickImage(source: ImageSource.gallery);
        setState(() {});
        print("++++++++++++++++++");
        print(pickedImage);
      },
      removeFCT: () {
        setState(() {
          pickedImage = null;
        });
      },
    );
  }

  Future<void> imagePickerDialog({
    required BuildContext context,
    required Function cameraFCT,
    required Function galleryFCT,
    required Function removeFCT,
  }) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: const Center(
            child: Text(
              "Choose option",
            ),
          ),
          content: SingleChildScrollView(
              child: ListBody(
            children: [
              TextButton.icon(
                onPressed: () {
                  cameraFCT();
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                icon: const Icon(Icons.camera),
                label: const Text(
                  "Camera",
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  galleryFCT();
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                icon: const Icon(Icons.image),
                label: const Text(
                  "Gallery",
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  removeFCT();
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                icon: const Icon(Icons.remove),
                label: const Text(
                  "Remove",
                ),
              ),
            ],
          )),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade300,
      appBar: AppBar(
        backgroundColor: Colors.green.shade900,
        title: const Text(
          "Notification",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        actions: [
          SizedBox(
            width: 100,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                style: const TextStyle(color: Colors.white, fontSize: 10),
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 2,
                        )),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(color: Colors.black))),
              ),
            ),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.width * 0.9,
              width: MediaQuery.of(context).size.width * 0.7,
              child: PickImageWidget(
                pickedImage: pickedImage,
                function: () async {
                  await localImagePicker();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
