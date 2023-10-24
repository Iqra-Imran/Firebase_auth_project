import 'dart:io';
import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_shield/firestore/firestore_screen.dart';
import 'package:login_shield/reusable_widgets/reusable_button.dart';
import 'package:login_shield/utensils/utils.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({super.key});

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  bool loading = false;
  File? _image;
  final imagePicker = ImagePicker();
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.ref('let post');

  Future getGalleryImage() async {
    final pickFile = await imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 80);
    if (pickFile != null) {
      _image = File(pickFile.path);
    } else {
      print('image is not found');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image picker'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                getGalleryImage();
              },
              child: Center(
                child: Container(
                  height: 200,
                  width: 200,
                  child: _image != null
                      ? Image.file(_image!.absolute)
                      : Icon(Icons.image),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ReusableButton(
                title: 'Upload Image',
                loading: loading,
                ontap: () async {
                  setState(() {
                    loading = true;
                  });
                  firebase_storage.Reference ref = firebase_storage
                      .FirebaseStorage.instance
                      .ref('/imageFolder' +
                          DateTime.now().millisecondsSinceEpoch.toString());
                  firebase_storage.UploadTask uploadTask =
                      ref.putFile(_image!.absolute);
                  Future.value(uploadTask).
                  then((value) async {
                    var newUrl = await ref.getDownloadURL();
                    databaseReference.child('1').set({
                      'id': 1,
                      'title': newUrl.toString(),
                    }).then((value) {
                      setState(() {
                        loading = false;
                      });
                      Utils().toastMessage('uploaded');
                    }).onError((error, stackTrace) {
                      Utils().toastMessage(error.toString());
                    });
                  }).onError((error, stackTrace) {
                    Utils().toastMessage(error.toString());
                    setState(() {
                      loading= false;
                    });
                  });
                }),
          ],
        ),
      ),
    );
  }
}
