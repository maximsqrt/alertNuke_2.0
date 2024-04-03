import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseImageStorageService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String?> getCurrentUserId() async {
    return _auth.currentUser?.uid;
  }
Future<String?> getProfilePictureUrl(String userId) async {
  try {
    return await _storage.ref().child('userProfilePics/$userId').getDownloadURL();
  } catch (e) {
    return null;
  }
}

  Future<String?> uploadProfilePicture(File imageFile, String userId) async {
    try {
      // Create a reference to the location you want to upload to in firebase
      Reference ref = _storage.ref().child('userProfilePics/$userId');

      // Upload the file to firebase
      UploadTask uploadTask = ref.putData(imageFile.readAsBytesSync());

      // Waits till the file is uploaded then stores the download url 
      final TaskSnapshot downloadUrl = (await uploadTask);
      
      // The URL of the image stored in firebase
      final String url = (await downloadUrl.ref.getDownloadURL());
      
      return url;

    } catch (e) {
      return null;
    }
  }
  Future<void> storeImageUrl(String imageUrl, String userId) async {
     await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'profilePictureUrl': imageUrl,
     });
  }
}