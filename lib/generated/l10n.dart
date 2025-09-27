// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `All Your Favorite Brands in One Place`
  String get onboarding_first_title {
    return Intl.message(
      'All Your Favorite Brands in One Place',
      name: 'onboarding_first_title',
      desc: '',
      args: [],
    );
  }

  /// `Discover and shop the latest trends from top brands, with a seamless checkout experience.`
  String get onboarding_first_subtitle {
    return Intl.message(
      'Discover and shop the latest trends from top brands, with a seamless checkout experience.',
      name: 'onboarding_first_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Discover Your Style`
  String get onboarding_second_title {
    return Intl.message(
      'Discover Your Style',
      name: 'onboarding_second_title',
      desc: '',
      args: [],
    );
  }

  /// `Explore a curated selection of products tailored just for you. Find what you love, effortlessly.`
  String get onboarding_second_subtitle {
    return Intl.message(
      'Explore a curated selection of products tailored just for you. Find what you love, effortlessly.',
      name: 'onboarding_second_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Fast & Easy Checkout`
  String get onboarding_third_title {
    return Intl.message(
      'Fast & Easy Checkout',
      name: 'onboarding_third_title',
      desc: '',
      args: [],
    );
  }

  /// `Complete your purchase in just a few taps with our streamlined and secure checkout process.`
  String get onboarding_third_subtitle {
    return Intl.message(
      'Complete your purchase in just a few taps with our streamlined and secure checkout process.',
      name: 'onboarding_third_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get get_started {
    return Intl.message('Get Started', name: 'get_started', desc: '', args: []);
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Skip`
  String get skip {
    return Intl.message('Skip', name: 'skip', desc: '', args: []);
  }

  /// `test`
  String get test {
    return Intl.message('test', name: 'test', desc: '', args: []);
  }

  /// `hallo`
  String get hallo {
    return Intl.message('hallo', name: 'hallo', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
