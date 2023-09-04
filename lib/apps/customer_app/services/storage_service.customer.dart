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

  Stream<TaskSnapshot?> getImageUploadStream(
      {required String imageType,
      required String filename,
      required File file}) {
    final storageRef = firebaseStorage.ref();
    final imageRef = storageRef.child("$imageType/$filename");

    try {
      final uploadTask = imageRef.putFile(file);
      return uploadTask.snapshotEvents;
    } on FirebaseException {
      throw 'Upload Failed with Firebase Error';
    }
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
