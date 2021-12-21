import 'package:shared_preferences/shared_preferences.dart';

saveUserRole(String role) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.setString('currentUserRole', role);
}

Future<String?> getUserRole() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // await prefs.setString('currentUserRole', role);
  return prefs.getString('currentUserRole');
}
