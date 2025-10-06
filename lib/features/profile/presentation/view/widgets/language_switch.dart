import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kshk/core/Services/service_locator.dart';
import 'package:kshk/core/Services/shared_prefrences_singletone.dart';
import 'package:kshk/core/cubits/language_cubit/language_cubit.dart';
import 'package:kshk/core/utils/constants.dart';
import 'package:kshk/core/utils/styles.dart';
import 'package:kshk/generated/l10n.dart';

class LanguageSwitch extends StatelessWidget {
  const LanguageSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<LanguageCubit>(),
      child: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, state) {
          return Row(
            children: [
              Text(
                S.of(context).language,
                style: AppStyles.size18W700(context),
              ),
              Spacer(),
              Switch(
                value: SharedPreferencesSingleton.getBool(kIsArabicLanguage),
                onChanged: ((value) {
                  SharedPreferencesSingleton.setBool(kIsArabicLanguage, value);

                  context.read<LanguageCubit>().toggleLanguage();
                }),
              ),
            ],
          );
        },
      ),
    );
  }
}
