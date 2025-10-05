import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kshk/core/Services/block_observer.dart';
import 'package:kshk/core/Services/service_locator.dart';
import 'package:kshk/core/Services/shared_prefrences_singletone.dart';
import 'package:kshk/core/cubits/darkmode/darkmode_cubit.dart';
import 'package:kshk/core/cubits/language_cubit/language_cubit.dart';
import 'package:kshk/core/utils/app_router.dart';
import 'package:kshk/core/utils/constants.dart';
import 'package:kshk/core/utils/models/address_model.dart';
import 'package:kshk/core/utils/themes/theme.dart';
import 'package:kshk/firebase_options.dart';
import 'package:kshk/generated/l10n.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedPreferencesSingleton.init();
  setupServiceLocator();
  Bloc.observer = SimpleBlocObserver();
  Hive.registerAdapter<AddressModel>(AddressModelAdapter());
  await Hive.openBox<AddressModel>(kAddressBox);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Dark Mode Cubit
        BlocProvider<DarkModeCubit>(
          create: (context) => getIt<DarkModeCubit>(),
        ),
        // Language Cubit
        BlocProvider<LanguageCubit>(
          create: (context) => getIt<LanguageCubit>(),
        ),
      ],
      child: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, languageState) {
          return BlocBuilder<DarkModeCubit, DarkModeState>(
            builder: (context, darkModeState) {
              return MaterialApp.router(
                locale: languageState is ArabicStates
                    ? const Locale('ar')
                    : const Locale('en'),
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                title: 'Kshk app',
                routerConfig: AppRouter.router,
                theme: lightMode,
                darkTheme: darkMode,
                themeMode: darkModeState is DarkMode
                    ? ThemeMode.dark
                    : ThemeMode.light,
                debugShowCheckedModeBanner: false,
              );
            },
          );
        },
      ),
    );
  }
}
