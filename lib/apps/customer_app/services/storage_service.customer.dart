import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final storageServiceProvider = Provider<StorageService>((ref) {
  return StorageService._(FirebaseStorage.instance);
});

abstract class ImageType {
  static const String passportPhotograph = '/images/passport-photograph';
  static const String validId = '/images/valid-id';
  static const String profilePicture = '/images/profile-picture';
}

class StorageService {
  StorageService._(this.firebaseStorage);

  static final instance = StorageService._(FirebaseStorage.instance);

  final FirebaseStorage firebaseStorage;

  Future<String?> uploadImage(
      {required String imageType,
      required String filename,
      required File file}) async {
    final storageRef = firebaseStorage.ref();
    final imageRef = storageRef.child("$imageType/$filename");

    bool isUploadSuccessful = false;

    try {
      final uploadTask = imageRef.putFile(file);
      uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) async {
        switch (taskSnapshot.state) {
          case TaskState.running:
            final progress =
                100 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
            break;
          case TaskState.paused:
            print("Upload is paused.");
            break;
          case TaskState.canceled:
            print("Upload was canceled");
            break;
          case TaskState.error:
            //TODO: Handle unsuccessful uploads
            break;
          case TaskState.success:
            isUploadSuccessful = true;
            break;
        }
      });
      if (isUploadSuccessful) {
        return await imageRef.getDownloadURL();
      }
    } on FirebaseException {
      return "";
    }
    return null;
  }
}

enum AuthResponse {
  success,
  incorrectPassword,
  noSuchEmail,
  unknownError,
  weakPassword,
  emailInUse,
  phoneInUse,
  invalidEmail,
  invalidPhone,
  invalidVerificationCode,
}
