import 'package:shared_preferences/shared_preferences.dart';

Future<void> setLoginState(bool isLoggedIn) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', isLoggedIn);
}

Future<bool> getLoginState() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isLoggedIn') ?? false;
}
