import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordVisibilityCubit extends Cubit<PasswordVisibilityState> {
  PasswordVisibilityCubit() : super(PasswordNotVisible());
  changeVisiblity() {
    if (state is PasswordNotVisible) {
      emit(PasswordVisible());
    } else {
      emit(PasswordNotVisible());
    }
  }
}

class PasswordVisibilityState {}

class PasswordVisible extends PasswordVisibilityState {}

class PasswordNotVisible extends PasswordVisibilityState {}
