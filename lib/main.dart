import 'package:flutter/material.dart';
import 'package:pmsn2024/screens/home_screen.dart';
import 'package:pmsn2024/screens/login_screen.dart';
import 'package:pmsn2024/settings/global_values.dart';
import 'package:pmsn2024/settings/theme_settings.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return  ValueListenableBuilder(
      valueListenable: GlobalValues.banThemeDark,
      builder: (context, value, Widget){ {
        return MaterialApp(
          title: 'Material App',
          debugShowCheckedModeBanner: false,
          home:LoginScreen(),
          theme: GlobalValues.banThemeDark.value ? ThemeSettings.darkTheme() : ThemeSettings.lightTheme(),
          routes: {"/home":(context) => HomeScreen()
          },
        );
      }
      }
    );
  }
}
