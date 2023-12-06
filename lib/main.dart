import 'package:easy_localization/easy_localization.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/bloc/theme_bloc.dart';

void main() {
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('ar', 'EG')],
      path: 'translations',
      fallbackLocale: const Locale('en', 'US'),
      startLocale: const Locale('en', 'US'),
      saveLocale: true,
      useFallbackTranslations: true,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: FlexColorScheme.light(useMaterial3: true).toTheme,
            darkTheme: FlexColorScheme.dark(useMaterial3: true).toTheme,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            themeMode: state.themeMode,
            home: const MyHomePage(title: 'Flutter Demo Home Page'),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  void _toggleLanguage(BuildContext context) {
    final locale = context.locale == const Locale('en', 'US')
        ? const Locale('ar', 'EG')
        : const Locale('en', 'US');
    context.setLocale(locale);
  }

  void _toggleTheme(BuildContext context, ThemeState state) {
    context.read<ThemeBloc>().add(ToggleThemeMode());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () => _toggleLanguage(context),
          ),
          BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              final IconData icon;
              switch (state.themeMode) {
                case ThemeMode.system:
                  icon = Icons.brightness_auto;
                  break;
                case ThemeMode.light:
                  icon = Icons.light_mode;
                  break;
                case ThemeMode.dark:
                  icon = Icons.dark_mode;
                  break;
              }
              return IconButton(
                icon: Icon(icon),
                onPressed: () => _toggleTheme(context, state),
                tooltip:
                    "Current: ${Theme.of(context).brightness == Brightness.dark ? 'Dark Mode' : 'Light Mode'}",
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("app_name").tr(),
          ],
        ),
      ),
    );
  }
}
