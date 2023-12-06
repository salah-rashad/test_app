part of 'theme_bloc.dart';

@immutable
sealed class ThemeEvent {}

final class ToggleThemeMode extends ThemeEvent {}
