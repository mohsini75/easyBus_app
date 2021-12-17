
/*
import '/providers/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  late String authId;
  late DateTime expiryTime;
  late String token;

  bool get isAuth {
    return Token != null;
  }

  String get Token {
    if (token != null &&
        expiryTime.isAfter(DateTime.now()) &&
        expiryTime != null) {
      return token;
    }
    return "";
  }

  Future<void> notification_post(List notification) async {
    final url = Uri.parse(
        'https://authentication-16dfc-default-rtdb.firebaseio.com/notification.json');

    final response = await http.post(url,
        body: json.encode({
          'Notification Message': notification,

          //'date': widget.transactions.date.toString(),
        }));
  }

  Future<void> authentication(
      String email, String password, String urlType) async {
    try {
      final url = Uri.parse(
          'https://identitytoolkit.googleapis.com/v1/accounts:${urlType}?key=AIzaSyCQnKv1hhPXL4JRK4Fcf6KtccN0T4soGEQ');
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final ResponseData = json.decode(response.body);
      print(ResponseData);
      if (ResponseData['error'] != null) {
        throw Exception(ResponseData['error']['message']);
      }
      token = ResponseData['idToken'];
      expiryTime = DateTime.now().add(
        Duration(
          seconds: int.parse(ResponseData['expiresIn']),
        ),
      );
      authId = ResponseData['localId'];
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    return authentication(email, password, "signUp");
  }

  Future<void> Login(String email, String password) async {
    return authentication(email, password, "signInWithPassword");
  }
}
*/