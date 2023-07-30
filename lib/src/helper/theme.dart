import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class Themes{
  static final lightTheme = ThemeData(
    // primarySwatch: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    // colorScheme: ColorScheme.fromSwatch()
    //   .copyWith(secondary: Colors.white, brightness: Brightness.light),
    dividerColor: Colors.black12,
    inputDecorationTheme: const InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(33, 51, 69, 1)),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        )
    ),
    primaryTextTheme: const TextTheme(
      displayLarge: TextStyle(color: Colors.black)
    ),
    cardColor: const Color.fromRGBO(33, 51, 69, 1),
    primaryColor: Colors.black,
    canvasColor: Colors.black,
  );

  static final darkTheme = ThemeData(
    // primarySwatch: Color.fromRGBO(33, 51, 69, 1),
    scaffoldBackgroundColor: const Color.fromRGBO(33, 51, 69, 1),
    brightness: Brightness.dark,
    // colorScheme: ColorScheme.fromSwatch()
    //     .copyWith(secondary: Colors.white, brightness: Brightness.dark),
    dividerColor: Colors.white54,
    inputDecorationTheme: const InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      )
    ),
      primaryTextTheme: const TextTheme(
          displayLarge: TextStyle(color: Colors.white)
      ),
    cardColor: Colors.white,
    primaryColor: Colors.white,// text in white background
    canvasColor: Colors.black,
  );
}



final themeNotifierProvider = StateNotifierProvider<ThemeProvider, ThemeMode?>((ref) {
  return ThemeProvider();
});

class ThemeProvider extends StateNotifier<ThemeMode?>{
  ThemeProvider() : super(ThemeMode.light);
  void changeTheme(bool? isON){
    state = isON! ? ThemeMode.dark : ThemeMode.light;
  }
}
