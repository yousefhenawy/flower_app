
// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flower_app/shared/getdataFromFireBase.dart';
import 'package:flower_app/shared/ImgUser.dart';
import 'package:flower_app/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' show basename;

import '../shared/snackbar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final credential = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  File? imgPath;
  String? imgName;

  uploadImage(ImageSource cameraORphotos) async {
    final pickedImg = await ImagePicker().pickImage(source: cameraORphotos);
    try {
      if (pickedImg != null) {
        setState(() {
          imgPath = File(pickedImg.path);
          imgName = basename(pickedImg.path);
          int random = Random().nextInt(9999999);
          imgName = "$random$imgName";
        });
      } else {
        // print("NO img selected");
           showSnackBar(context, "NO img selected");
      }
    } catch (e) {
      // print("Error => $e");
         showSnackBar(context, "Error => $e");
    }
    if (!mounted) return;
    Navigator.pop(context);
  }

  showmodelbottoum() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(22),
          // color: Colors.amber[100],

          height: 170,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  await uploadImage(ImageSource.camera);
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.camera,
                      size: 30,
                    ),
                    Text(
                      " From Camera",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              GestureDetector(
                onTap: () async {
                  await uploadImage(ImageSource.gallery);
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.photo_library,
                      size: 30,
                    ),
                    Text(
                      " From gallery",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    )
                  ],
                ),  
                )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton.icon(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                if (!mounted) return;
                Navigator.pop(context);
              },
              label: const Text(
                "Logout",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
            )
          ],
          backgroundColor: appbarGreen,
          title: const Text("Profile Page"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(22.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                    child: Stack(children: [
                      imgPath == null
                          ? const ImgUser()
                          : ClipOval(
                              child: Image.file(
                                imgPath!,
                                width: 145,
                                height: 145,
                                fit: BoxFit.cover,
                              ),
                            ),
                      Positioned(
                        left: 103,
                        bottom: -10,
                        child: IconButton(
                            onPressed: () async {
                              await     showmodelbottoum();
                              // Upload image to firebase storage
                              if (imgPath != null) {
                                final storageRef =
                                    FirebaseStorage.instance.ref(imgName);
                                await storageRef.putFile(imgPath!);
                                // Get img url
                                String url = await storageRef.getDownloadURL();
                                users.doc(credential!.uid).update({
                                  "link": url,
                                });
                              }
                            },
                            icon: const Icon(Icons.add_a_photo),
                            color: const Color.fromRGBO(255, 94, 115, 128)),
                      ),
                    ]),
                  ),
                ),
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(11),
                    decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: const Text(
                      "info from firebase auth",
                      style: TextStyle(fontSize: 21),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Email:  ${credential!.email}",
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    Text(
                      "Created date:  ${DateFormat("MMMM d, y").format(credential!.metadata.creationTime!)}    ",
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    Text(
                      "Last signin : ${DateFormat("MMMM d, y").format(credential!.metadata.lastSignInTime!)}             ",
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            credential!.delete();

                            Navigator.pop(context);
                          });
                        },
                        child: const Text(
                          "Delete User",
                          style: TextStyle(fontSize: 22),
                        ))),
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(11),
                    decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: const Text(
                      "info from firebase fireStore",
                      style: TextStyle(fontSize: 21),
                    ),
                  ),
                ),
                GetDataFromFirestore(documentId: credential!.uid)
              ],
            ),
          ),
        ));
  }
}
