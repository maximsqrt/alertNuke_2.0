
import 'dart:io';

import 'package:alertnukeapp_ver2/src/data/firestore/firebaseimagestorage.dart';
import 'package:alertnukeapp_ver2/src/data/provider/profilepictureprovider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfilePicScreen extends StatefulWidget {
  @override
  _ProfilePicScreenState createState() => _ProfilePicScreenState();
}

class _ProfilePicScreenState extends State<ProfilePicScreen> {
  File? _imageFile; // Variable to store the selected image file
  bool _isMounted = false; //Ob das Widget gemounted ist?

  @override 
  void initState(){
    super.initState();
    _isMounted = true;
  }

  @override
  void dispose(){
    _isMounted = false; //Widget mark unmounted wenn disposed
    super.dispose();
  }
  // n diesem Fall bezieht sich die Meldung darauf, 
  // dass das State-Objekt, das den Bildschirm repräsentiert
  //  (_ProfilePicScreenState), nicht mehr gemounted ist.
  //   Dies bedeutet, dass das Widget bereits aus dem 
  //   Widget-Baum entfernt wurde, möglicherweise weil der Benutzer 
  //   den Bildschirm verlassen hat oder die App 
  //   eine andere Ansicht angezeigt hat.

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);

    setState(() {
      // Update the state with the selected image file
      _imageFile = pickedImage != null ? File(pickedImage.path) : null;
    });

    if (_imageFile != null) {
      // Upload the selected image to Firebase Storage
      await _uploadImage(_imageFile!);
    }
  }
Future<void> _uploadImage(File imageFile) async {
    try {
      // Implement your Firebase Image Storage functionality here
      // Get the current user's ID
      String? userId = await FirebaseImageStorageService().getCurrentUserId();
      if (_isMounted && userId != null) { // Check if the widget is still mounted
        // Upload the image to Firebase Storage
        String? downloadUrl = await FirebaseImageStorageService().uploadProfilePicture(imageFile, userId);
        if (downloadUrl != null) {
          print('Uploaded image URL: $downloadUrl');
          if (_isMounted) { // Check if the widget is still mounted
            Provider.of<ProfilePictureProvider>(context, listen: false).updateProfilePictureUrl(downloadUrl);
          }
        } else {
          print('Failed to upload image');
        }
      }
    } catch (e) {
      print('Error uploading profile picture: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Your UI implementation
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Picture'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imageFile != null
                ? Image.file(
                    _imageFile!,
                    height: 200,
                    width: 200,
                  )
                : Placeholder(
                    fallbackHeight: 200,
                    fallbackWidth: 200,
                  ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _pickImage(ImageSource.gallery),
              child: Text('Pick Image from Gallery'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _pickImage(ImageSource.camera),
              child: Text('Take Photo'),
            ),
          ],
        ),
      ),
    );
  }
}
