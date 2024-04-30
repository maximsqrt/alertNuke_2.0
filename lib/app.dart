
import 'package:alertnukeapp_ver2/src/Services/icon_services/firebase_icon_repositorys.dart';
import 'package:alertnukeapp_ver2/src/Services/icon_services/iconservice.dart';
import 'package:alertnukeapp_ver2/src/data/provider/calendarstateprovider.dart';
import 'package:alertnukeapp_ver2/src/data/provider/locationprovider.dart';
import 'package:alertnukeapp_ver2/src/data/provider/profilepictureprovider.dart';
import 'package:alertnukeapp_ver2/src/data/provider/savediconsprovider.dart';
import 'package:alertnukeapp_ver2/src/data/provider/yearprovider.dart';
import 'package:alertnukeapp_ver2/src/presentation/login/login.dart';
import 'package:alertnukeapp_ver2/src/presentation/navigation/overview/overview.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlertnukeApp extends StatelessWidget {
  const AlertnukeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //Streamprovider to react on changes of the auth-status of the user
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
        debugShowCheckedModeBanner: false,
        home: AuthWrapper(), // Startseite ist der LoginScreen
      ),
    );
  }
}
///CHeck If User is already Logged in 
class AuthWrapper extends StatelessWidget{
  @override
  Widget build(BuildContext) {
    User? user = FirebaseAuth.instance.currentUser;
      //check if user is logged in 
      if (user == null) {
        return LoginScreen();
      } else { 
        return Overview();
      }
  }
}