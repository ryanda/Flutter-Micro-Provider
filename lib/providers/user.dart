import 'package:flutter/material.dart';
import 'package:micro/obj.dart';
import 'package:micro/repository.dart';

enum UserStatus { none, fetching, done }

class UserState extends ChangeNotifier with Endpoints {
  User? _user;
  UserStatus _userState = UserStatus.none;

  User? get user => _user;
  UserStatus get userStatus => _userState;

  set _setStatus(UserStatus state) {
    _userState = state;
    if (state == UserStatus.none || state == UserStatus.fetching) _user = null;
    notifyListeners();
  }

  set _setUser(User user) {
    _user = user;
    _userState = UserStatus.done;
    notifyListeners();
  }

  Future<void> fetchUser() async {
    _setStatus = UserStatus.fetching;

    await new Future.delayed(const Duration(seconds: 2));

    try {
      ObjHolder res = await profile();
      ProfileResponse response = ProfileResponse.fromJson(res.response);

      _setUser = response.data;
    } on Exception catch (e) {
      print(e);
      _setStatus = UserStatus.none;
    }
  }

  void resetUser() {
    _setStatus = UserStatus.none;
  }
}
