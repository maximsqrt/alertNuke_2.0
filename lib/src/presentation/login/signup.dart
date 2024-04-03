
import 'package:alertnukeapp_ver2/src/Services/auth_signup_service.dart';
import 'package:alertnukeapp_ver2/src/presentation/navigation/overview/overview.dart';
import 'package:alertnukeapp_ver2/src/presentation/theme/custombuttons.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  AuthenticationSignupService authenticationService =
      AuthenticationSignupService();

//Wie mit => signup auf die Funktion verweisen
  String? repeatedEmail;
//store repeated Email

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF884082), Color(0xFF1E1854)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Logo
              Image.asset(
                'assets/logo.png', // Pfad zum Logo-Bild
                width: 200, // Größe des Logos
                height: 200,
              ),
              const SizedBox(height: 20),

              // Text Fields for Username and Password
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      authenticationService.username = value;
                    });
                  },
                  style: const TextStyle(
                      color: Colors.white), // Textfarbe der Eingabefelder
                  decoration: const InputDecoration(
                    labelText: 'Choose Username',
                    labelStyle:
                        TextStyle(color: Colors.white), // Textfarbe des Labels
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white), // Rahmenfarbe im Normalzustand
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white), // Rahmenfarbe im Fokus
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      authenticationService.password = value;
                    });
                  },
                  style: const TextStyle(color: Colors.white),
                  obscureText: true, // Versteckte Eingabe für Passwort
                  decoration: const InputDecoration(
                    labelText: 'Choose Password',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      authenticationService.repeatPassword = value;
                    });
                  },
                  style: const TextStyle(
                      color: Colors.white), // Textfarbe der Eingabefelder
                  obscureText: true, //versteckte Eingabe für Passwort
                  decoration: const InputDecoration(
                    labelText: 'Repeat Password',
                    labelStyle:
                        TextStyle(color: Colors.white), // Textfarbe des Labels
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white), // Rahmenfarbe im Normalzustand
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white), // Rahmenfarbe im Fokus
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      authenticationService.email = value;
                    });
                  },
                  style: const TextStyle(
                      color: Colors.white), // Textfarbe der Eingabefelder
                  obscureText: false, //versteckte Eingabe für Passwort
                  decoration: const InputDecoration(
                    labelText: 'E-Mail',
                    labelStyle:
                        TextStyle(color: Colors.white), // Textfarbe des Labels
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white), // Rahmenfarbe im Normalzustand
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white), // Rahmenfarbe im Fokus
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: FancyButton(
                  title: 'SignUp',
                  onTap: () async {
                    //ab in den AUthOrdner
                    bool signedUp = await authenticationService.signUp();
                    if (signedUp) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Overview()),
                      );
                    } else {
                     throw 'ERROR';
                    }
                  },
                  key: const ValueKey('signup_button'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
