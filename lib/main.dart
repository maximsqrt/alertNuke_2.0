import 'package:alertnukeapp_ver2/app.dart';
import 'package:alertnukeapp_ver2/firebase_options.dart'; //contains API keys and stuff
import 'package:firebase_core/firebase_core.dart'; ///for initializing Firebase
import 'package:flutter/material.dart';

void main() async {

  // Necessary to initialise bindings, 
  //specific classes für communication between 
  // dart-level and native code level
  WidgetsFlutterBinding.ensureInitialized(); 
  //This is essential because Firebase initialization involves
  // communication with native code to set up its services, and thus,
  // requires the bindings to be fully initialized beforehand.
  await Firebase.initializeApp(

    // Use specific configData on each platform.
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const AlertnukeApp());
}
 
 