import 'dart:async';

import 'package:career_paddy/models/user_model.dart';
import 'package:career_paddy/services/auth.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  late UserModel user;
  UserModel get getUser => user;

  StreamSubscription? subscription;

  var service = AuthService();

  listenToUser() {
    var u = service.getFirebaseUser()!;
    subscription = service.listen(u.uid).listen((event) {
      var model = UserModel.fromJson(
        event.id,
        event.data() as dynamic,
      );
      user = model;
      notifyListeners();
    });
  }

  cancel() => subscription?.cancel();

  @override
  void dispose() {
    cancel();
    super.dispose();
  }
}
