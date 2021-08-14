import 'package:ez_parking_app/domain/repositories/auth_repository.dart';

class SetOnBoarding {
  SetOnBoarding(this.authRepository);

  final AuthRepository authRepository;

  Future<void> call() async {
    return authRepository.setOnBoading();
  }
}
