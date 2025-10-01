import 'package:bloc/bloc.dart';
import 'package:kshk/core/Services/shared_prefrences_singletone.dart';
import 'package:kshk/core/utils/constants.dart';
import 'package:meta/meta.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit()
    : super(
        SharedPreferencesSingleton.getBool(kIsArabicLanguage)
            ? ArabicStates()
            : EnglishStates(),
      );

  void toggleLanguage() {
    final bool isArabic = state is ArabicStates;
    SharedPreferencesSingleton.setBool(kIsArabicLanguage, !isArabic);
    // log( "is arabic in shared pref cubit" + isArabic.toString());

    if (!isArabic) {
      emit(ArabicStates());
    } else {
      emit(EnglishStates());
    }
  }
}
