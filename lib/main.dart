import 'package:alertnukeapp_ver2/app.dart';
import 'package:alertnukeapp_ver2/firebase_options.dart'; //contains API keys and stuff
import 'package:firebase_core/firebase_core.dart'; ///for initializing Firebase
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure bindings are initialized.
///test
  // Starting Firebase in App:
  await Firebase.initializeApp(
    // Use specific configData on each platform.
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const AlertnukeApp());
}
 