import 'package:ez_parking_app/domain/repositories/auth_repository.dart';

class GetOnBoarding {
  GetOnBoarding(this.authRepository);

  final AuthRepository authRepository;

  int call() {
    return authRepository.getOnBoading();
  }
}
