import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ez_parking_app/domain/use_cases/auth/set_on_boarding.dart';

part 'welcome_state.dart';

class WelcomeCubit extends Cubit<WelcomeState> {
  WelcomeCubit({required this.setOnBoarding}) : super(WelcomeInitial());

  final SetOnBoarding setOnBoarding;

  Future<void> setOnBoardingValue() async {
    await setOnBoarding();
  }
}
