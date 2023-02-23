import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:subapp/models/user_model.dart';

class AuthStore extends ChangeNotifier {
  final SharedPreferences prefs;
  bool _loggedIn = false;
  String _token = '';
  late User user = User(
    id: 0,
    firstname: '',
    lastname: '',
    userType: '',
    walletBalance: 0,
    totalContacts: 0,
    phone: '',
    email: '',
    avatar: '',
    status: false,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  AuthStore(this.prefs) {
    loggedIn = prefs.getBool('LoggedIn') ?? false;
  }

  bool get loggedIn => _loggedIn;
  String get token => _token;

  set loggedIn(bool value) {
    _loggedIn = value;
    prefs.setBool('LoggedIn', value);
    notifyListeners();
  }

  set token(String value) {
    if (value != _token) {
      _token = value;
      notifyListeners();
    }
  }

  void checkLoggedIn() {
    loggedIn = prefs.getBool('LoggedIn') ?? false;
    token = prefs.getString('token') ?? '';
  }

  void setLoggedIn(bool logged, String token) {
    _loggedIn = logged;
    _token = token;
    prefs.setBool('LoggedIn', logged);
    prefs.setString('token', token);
    notifyListeners();
  }

  void logout() {
    prefs.setBool('LoggedIn', false);
    prefs.remove('token');
    _loggedIn = false;
    _token = '';
    notifyListeners();
  }
}
