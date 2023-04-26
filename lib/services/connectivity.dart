import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectivityService {
  var checker = InternetConnectionChecker();

  Future<bool> getConnection() async {
    bool result = await checker.hasConnection;
    return result;
  }
}
