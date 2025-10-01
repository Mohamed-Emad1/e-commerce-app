part of 'darkmode_cubit.dart';

@immutable
sealed class DarkModeState {}

final class LightMode extends DarkModeState {}
final class DarkMode extends DarkModeState {}
