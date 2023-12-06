part of 'theme_bloc.dart';

@immutable
sealed class ThemeState {
  final ThemeMode themeMode;
  const ThemeState(this.themeMode);
}

final class ThemeInitial extends ThemeState {
  const ThemeInitial() : super(ThemeMode.system);
}

final class ThemeChanged extends ThemeState {
  const ThemeChanged(ThemeMode themeMode) : super(themeMode);
}
