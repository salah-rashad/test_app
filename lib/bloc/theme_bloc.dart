import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeInitial()) {
    on<ThemeEvent>((event, emit) {
      switch (event) {
        case ToggleThemeMode():
          final mode = ThemeMode
              .values[(state.themeMode.index + 1) % ThemeMode.values.length];
          print(mode);
          emit(ThemeChanged(mode));
          break;
      }
    });
  }
}
