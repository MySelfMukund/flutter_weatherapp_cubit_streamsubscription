import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'temp_setting_state.dart';

class TempSettingCubit extends Cubit<TempSettingState> {
  TempSettingCubit() : super(TempSettingState.initial());

  void toggleTempUnit() {
    emit(state.copyWith(tempUnit: state.tempUnit == TempUnit.celsius ? TempUnit.fahrenheit : TempUnit.celsius));
  }
}
