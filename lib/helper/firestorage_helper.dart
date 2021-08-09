import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirestorageHelper {
  FirestorageHelper._();
  static FirestorageHelper firestorageHelper = FirestorageHelper._();
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  Future<String> uploadImage(File file, [String directoryName]) async {
    String imageName = file.path.split('/').last;
    // 1 make a refrence for uploading image
    try {
      Reference reference = firebaseStorage.ref(directoryName == null
          ? 'users/imageName'
          : '$directoryName/imageName');

      //2 uplad the image
      await reference.putFile(file);

      //3 get the image url
      String imageUrl = await reference.getDownloadURL();
      return imageUrl;
    } on Exception catch (e) {
      print(e);
    }
  }
}
