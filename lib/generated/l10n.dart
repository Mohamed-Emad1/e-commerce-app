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

  /// `Welcome Back!`
  String get welcome {
    return Intl.message('Welcome Back!', name: 'welcome', desc: '', args: []);
  }

  /// `Sign in to your account to continue`
  String get sign_in_to_continue {
    return Intl.message(
      'Sign in to your account to continue',
      name: 'sign_in_to_continue',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Forgot Password?`
  String get forgot_password {
    return Intl.message(
      'Forgot Password?',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get sign_in {
    return Intl.message('Sign In', name: 'sign_in', desc: '', args: []);
  }

  /// `Don't have an account? `
  String get dont_have_an_account {
    return Intl.message(
      'Don\'t have an account? ',
      name: 'dont_have_an_account',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account? `
  String get already_have_an_account {
    return Intl.message(
      'Already have an account? ',
      name: 'already_have_an_account',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get sign_up {
    return Intl.message('Sign Up', name: 'sign_up', desc: '', args: []);
  }

  /// `Name`
  String get name {
    return Intl.message('Name', name: 'name', desc: '', args: []);
  }

  /// `Confirm Password`
  String get confirm_password {
    return Intl.message(
      'Confirm Password',
      name: 'confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get create_account {
    return Intl.message(
      'Create Account',
      name: 'create_account',
      desc: '',
      args: [],
    );
  }

  /// `Let's get you started!`
  String get let_get_started {
    return Intl.message(
      'Let\'s get you started!',
      name: 'let_get_started',
      desc: '',
      args: [],
    );
  }

  /// `This field is required`
  String get required_field {
    return Intl.message(
      'This field is required',
      name: 'required_field',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email`
  String get invalid_email {
    return Intl.message(
      'Please enter a valid email',
      name: 'invalid_email',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters`
  String get password_too_short {
    return Intl.message(
      'Password must be at least 6 characters',
      name: 'password_too_short',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwords_do_not_match {
    return Intl.message(
      'Passwords do not match',
      name: 'passwords_do_not_match',
      desc: '',
      args: [],
    );
  }

  /// `The password provided is too weak.`
  String get weak_password {
    return Intl.message(
      'The password provided is too weak.',
      name: 'weak_password',
      desc: '',
      args: [],
    );
  }

  /// `The account already exists for that email.`
  String get email_already_in_use {
    return Intl.message(
      'The account already exists for that email.',
      name: 'email_already_in_use',
      desc: '',
      args: [],
    );
  }

  /// `Network request failed. Please check your internet connection.`
  String get network_request_failed {
    return Intl.message(
      'Network request failed. Please check your internet connection.',
      name: 'network_request_failed',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred. Please try again.`
  String get an_error_occurred {
    return Intl.message(
      'An error occurred. Please try again.',
      name: 'an_error_occurred',
      desc: '',
      args: [],
    );
  }

  /// `No user found for that email.`
  String get user_not_found {
    return Intl.message(
      'No user found for that email.',
      name: 'user_not_found',
      desc: '',
      args: [],
    );
  }

  /// `Wrong password provided for that user.`
  String get wrong_password {
    return Intl.message(
      'Wrong password provided for that user.',
      name: 'wrong_password',
      desc: '',
      args: [],
    );
  }

  /// `Or sign in with`
  String get or_sign_in_with {
    return Intl.message(
      'Or sign in with',
      name: 'or_sign_in_with',
      desc: '',
      args: [],
    );
  }

  /// `All Products`
  String get all_products {
    return Intl.message(
      'All Products',
      name: 'all_products',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message('Categories', name: 'categories', desc: '', args: []);
  }

  /// `Favorites`
  String get favorites {
    return Intl.message('Favorites', name: 'favorites', desc: '', args: []);
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Search`
  String get search {
    return Intl.message('Search', name: 'search', desc: '', args: []);
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Cart`
  String get cart {
    return Intl.message('Cart', name: 'cart', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Add to Cart`
  String get add_to_cart {
    return Intl.message('Add to Cart', name: 'add_to_cart', desc: '', args: []);
  }

  /// `Added to Cart`
  String get added_to_cart {
    return Intl.message(
      'Added to Cart',
      name: 'added_to_cart',
      desc: '',
      args: [],
    );
  }

  /// `Size`
  String get size {
    return Intl.message('Size', name: 'size', desc: '', args: []);
  }

  /// `Color`
  String get color {
    return Intl.message('Color', name: 'color', desc: '', args: []);
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
