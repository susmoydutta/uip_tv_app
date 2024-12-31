import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uip_tv_app/controller_binder.dart';
import 'package:uip_tv_app/presentation/utils/asset_colors_path.dart';
import 'package:uip_tv_app/presentation/widget/crafty_bay.dart';
import 'package:uip_tv_app/presentation/widget/custom_nav_bar.dart';

class App extends StatelessWidget {
  App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Uip Tv',
      navigatorKey: CraftyBay.navigatorKey,
      initialBinding: ControllerBinder(),
      theme: ThemeData(
        scaffoldBackgroundColor: AssetColorsPath.backgroundColors,
        inputDecorationTheme: _inputDecorationTheme(),
        fontFamily: 'Akatab',
        textTheme: buildTextTheme(),
      ),
      home: CustomNavBar(),
    );
  }

  InputDecorationTheme _inputDecorationTheme() => InputDecorationTheme(
        border: _outlineInputBorder,
        focusedBorder: _outlineInputBorder,
        enabledBorder: _outlineInputBorder,
        disabledBorder: _outlineInputBorder.copyWith(
          borderSide: BorderSide(
            color: AssetColorsPath.textSmallColors,
          ),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
      );

  final OutlineInputBorder _outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(40),
    borderSide: const BorderSide(
      color: AssetColorsPath.textSmallColors,
      width: 2.0,
    ),
  );

  TextTheme buildTextTheme() {
    return TextTheme(
      bodyMedium: TextStyle(
        fontFamily: 'Akatab',
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 14,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
