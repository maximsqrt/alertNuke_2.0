
import 'package:alertnukeapp_ver2/src/data/provider/savediconsprovider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseIconRepository implements IconRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<void> addIconDataCollection(String userId, IconData iconData, String name, String iconDescription) async {
    try {
      // Convert IconData to a string representation
      String iconString = iconData.toString();

      // Store the IconData string in Firestore user document
      await FirebaseFirestore.instance.collection('users').doc(userId).collection('iconData').add({
        'icondata_unicode': iconString,
        'name': name,
        'iconDescription': iconDescription,
      });
    } catch (e) {
    }
  }

  
  Future<List<IconWithName>> getIcondataCollection(String userId) async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('iconData')
        .get();
  querySnapshot.docs.forEach((doc) {
  Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  
});

List<IconWithName> icons = querySnapshot.docs.map((doc) {
  Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  
// Extract the IconData string
  String iconString = data['icondata_unicode'] ?? '';
  
  // Extract the hexadecimal code point from the IconData string
  String hexString = iconString.substring(11, iconString.length-1); // Remove "IconData(U+" from the beginning
  
  // Convert the hexadecimal string to an integer code point
  int codePoint = int.parse(hexString, radix: 16);
  
  // Create the IconData object using the extracted code point
  IconData iconData = IconData(codePoint, fontFamily: 'UniconsLine');
  
  String name = data['name'] ?? 'no_name';
  String iconDescription = data['iconDescription'] ?? '';





  // int codePoint = int.parse(data['iconString'] ?? '0'); // Standardwert: 0
  // print(codePoint);
  // IconData iconData = IconData(codePoint, fontFamily: 'UniconsLine');
  // String name = data['name'] ?? 'no_name'; // Standardwert: leerer String
  // String iconDescription = data['iconDescription'] ?? ''; // Standardwert: leerer String
  return IconWithName(name: name, icon: iconData, iconDescription: iconDescription);
}).toList();

// icons.forEach((iconWithName) {
//   print('Name: ${iconWithName.name}');
//   print('Icon Data: ${iconWithName.icon}');
//   print('Icon Description: ${iconWithName.iconDescription}');
// });

    return icons;
  } catch (e) {
    throw e;
  }
}

Future<void> printIconDataCollection(String userId) async {
  try {
    List<IconWithName> iconDataCollection = await getIcondataCollection(userId);
    iconDataCollection.forEach((iconData) {
    });
  } catch (e) {
  }
}

  @override
  Future<String?> getCurrentUserId() async {
    return _auth.currentUser?.uid;
  }
}
