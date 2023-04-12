import 'dart:async';

import 'package:career_paddy/models/user_model.dart';
import 'package:career_paddy/services/auth.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  late UserModel user;
  bool hasLoaded = false;

  UserModel get getUser => user;
  bool get getHasLoaded => hasLoaded;

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
      hasLoaded = true;
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
