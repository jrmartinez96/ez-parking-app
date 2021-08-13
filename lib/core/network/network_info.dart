import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get hasConnection;
}

class NetworkInfoImpl implements NetworkInfo {
  NetworkInfoImpl(this.connectionChecker);
  final InternetConnectionChecker connectionChecker;

  @override
  Future<bool> get hasConnection => connectionChecker.hasConnection;
}
