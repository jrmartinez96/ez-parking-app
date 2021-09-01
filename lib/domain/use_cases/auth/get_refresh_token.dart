import 'package:ez_parking_app/domain/repositories/auth_repository.dart';

class GetRefreshToken {
  GetRefreshToken(this.authRepository);

  final AuthRepository authRepository;

  Future<String> call() {
    return authRepository.getRefreshToken();
  }
}
