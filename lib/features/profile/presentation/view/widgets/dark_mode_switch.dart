import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kshk/core/Services/service_locator.dart';
import 'package:kshk/core/Services/shared_prefrences_singletone.dart';
import 'package:kshk/core/cubits/darkmode/darkmode_cubit.dart';
import 'package:kshk/core/utils/constants.dart';
import 'package:kshk/core/utils/styles.dart';
import 'package:kshk/generated/l10n.dart';

class DarkModeSwitch extends StatelessWidget {
  const DarkModeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<DarkModeCubit>(),
      child: BlocBuilder<DarkModeCubit, DarkModeState>(
        builder: (context, state) {
          final isDarkMode = state is DarkMode;
          return Row(
            children: [
              Text(
                S.of(context).dark_mode,
                style: AppStyles.size18W700(context),
              ),
              Spacer(),
              Switch(
                value: isDarkMode,
                onChanged: ((value) {
                  SharedPreferencesSingleton.setBool(kisDarkMode, value);

                  context.read<DarkModeCubit>().toggleDarkMode();
                }),
              ),
            ],
          );
        },
      ),
    );
  }
}
