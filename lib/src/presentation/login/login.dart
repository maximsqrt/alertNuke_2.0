
import 'package:alertnukeapp_ver2/src/Services/auth_login_service.dart';
import 'package:alertnukeapp_ver2/src/presentation/login/signup.dart';
import 'package:alertnukeapp_ver2/src/presentation/navigation/overview/overview.dart';
import 'package:alertnukeapp_ver2/src/presentation/theme/custombuttons.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  AuthenticationLoginService authenticationService = AuthenticationLoginService();  

  LoginScreen({super.key});

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
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildLogo(),
                _buildUsernameTextField(),
                _buildPasswordTextField(),
                _buildLoginButton(context),
                const SizedBox(height: 10),
                _buildForgotPasswordLink(),
                _buildSignUpLink(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Image.asset(
      'assets/alertnukelogo.png',
      width: 200,
      height: 200,
    );
  }

  Widget _buildUsernameTextField() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        controller: _usernameController,
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          labelText: 'Username',
          labelStyle: TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        controller: _passwordController,
        key: const Key('password'),
        style: const TextStyle(color: Colors.white),
        obscureText: true,
        decoration: const InputDecoration(
          labelText: 'Password',
          labelStyle: TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Password is required';
          }
          // if (value.length < 10) {
          //   return 'Password must be at least 10 characters';
          // }
          return null;
        },
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return FancyButton(
      title: 'Login',
      onTap: () async {
        if (_formKey.currentState?.validate() ?? false) {
          String username = _usernameController.text.trim();
          String password = _passwordController.text.trim();
          bool loggedIn = await authenticationService.signIn(username, password);
          if (loggedIn) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Overview()),
            );
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return _buildLoginFailedDialog(context);
              },
            );
          }
        }
      },
     
  key: const ValueKey('LogIn'     ),
    );
  }

  Widget _buildForgotPasswordLink() {
    return TextButton(
      onPressed: () {
        // Implement your forgot password functionality here
      },
      child: const Text(
        "Forgot Password?",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildSignUpLink(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  SignupScreen()),
      ),
      child: const Text('or signup'),
    );
  }

  Widget _buildLoginFailedDialog(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(  
        borderRadius: BorderRadius.circular(10.0)
      ),
      backgroundColor: Color.fromARGB(255, 255, 54, 54),
      title: const Text('Anmeldung fehlgeschlagen'),
      content: const Text('Benutzername oder Passwort ungültig.'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
