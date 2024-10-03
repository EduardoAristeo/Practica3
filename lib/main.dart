import 'package:flutter/material.dart';
import 'package:pmsn2024/onbording.dart';
import 'package:pmsn2024/screens/home_screen.dart';
import 'package:pmsn2024/screens/login_screen.dart';
import 'package:pmsn2024/screens/movies_screen.dart';
import 'package:pmsn2024/screens/theme_settings_screen.dart';
import 'package:pmsn2024/settings/global_values.dart';
import 'package:pmsn2024/settings/theme_preferences.dart';
import 'package:pmsn2024/settings/theme_settings.dart';

void main() async{

   WidgetsFlutterBinding.ensureInitialized();
  int savedTheme = await ThemePreference().getTheme();
  GlobalValues.themeMode.value = savedTheme;
  runApp(const MyApp());
}





class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return  ValueListenableBuilder(
      valueListenable: GlobalValues.themeMode,
      builder: (context, themeMode, _){ {
        return MaterialApp(
          title: 'Material App',
          debugShowCheckedModeBanner: false,
          theme: getThemeByMode(themeMode),
          home: LoginScreen(),
          routes: {
            "/home":(context) => HomeScreen(),
            "/db" : (context) => MoviesScreen(),
            "/onBoarding": (context) =>OnboardingScreen (),
            "/theme": (context) => ThemeSettingsScreen(),
          },
        );
      }
      }
    );
  }


  ThemeData getThemeByMode(int mode) {
    switch (mode) {
      case 1:
        return ThemeSettings.darkTheme();
      case 2:
        return ThemeSettings.customTheme();
      default:
        return ThemeSettings.lightTheme();
    }
  }
}
