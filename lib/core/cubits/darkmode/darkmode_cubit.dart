import 'package:bloc/bloc.dart';
import 'package:kshk/core/Services/shared_prefrences_singletone.dart';
import 'package:kshk/core/utils/constants.dart';
import 'package:meta/meta.dart';

part 'darkmode_state.dart';

class DarkModeCubit extends Cubit<DarkModeState> {
  DarkModeCubit()
    : super(
        SharedPreferencesSingleton.getBool(kisDarkMode)
            ? DarkMode()
            : LightMode(),
      );

  void toggleDarkMode() {
    if (state is LightMode) {
      emit(DarkMode());
    } else {
      emit(LightMode());
    }
  }
}
