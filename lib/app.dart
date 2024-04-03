
import 'package:alertnukeapp_ver2/src/Services/icon_services/firebase_icon_repositorys.dart';
import 'package:alertnukeapp_ver2/src/Services/icon_services/iconservice.dart';
import 'package:alertnukeapp_ver2/src/data/provider/calendarstateprovider.dart';
import 'package:alertnukeapp_ver2/src/data/provider/locationprovider.dart';
import 'package:alertnukeapp_ver2/src/data/provider/profilepictureprovider.dart';
import 'package:alertnukeapp_ver2/src/data/provider/savediconsprovider.dart';
import 'package:alertnukeapp_ver2/src/data/provider/yearprovider.dart';
import 'package:alertnukeapp_ver2/src/presentation/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlertnukeApp extends StatelessWidget {
  const AlertnukeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
         StreamProvider<User?>.value(
          value: FirebaseAuth.instance.authStateChanges(),
          initialData: null,
        ),
        ChangeNotifierProvider(create: (context) => CalendarStateProvider()),
        ChangeNotifierProvider(create: (context) => LocationProvider()),
        ChangeNotifierProvider(create: (context) => YearProvider()),
        ChangeNotifierProvider(create: (context) => SavedIconsNotifier()),
        ChangeNotifierProvider(create: (context) => ProfilePictureProvider()),
        Provider(
          create: (context) => FirebaseIconRepository(),
        ),
        Provider<IconService>(
          create: (context) => IconService(
            Provider.of<FirebaseIconRepository>(context, listen: false),
            Provider.of<SavedIconsNotifier>(context, listen: false),
          ),
        ),
      ],
      child: MaterialApp(
        home: LoginScreen(), // Startseite ist der LoginScreen
      ),
    );
  }
}
