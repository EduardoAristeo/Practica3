import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pmsn2024/settings/global_values.dart';
import 'package:pmsn2024/settings/theme_settings.dart';
import 'package:url_launcher/url_launcher_string.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      pages: [
        PageViewModel(
          title: "Bienvenido a la App Movies",
          body: "Esta aplicación está diseñada para que registres y veas tus películas favoritas.",
          image: Lottie.asset('assets/lottie/animation1.json', height: 300.0),
          decoration: PageDecoration(
            titleTextStyle: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
            bodyTextStyle: TextStyle(fontSize: 16.0, color: Colors.black54),
            imagePadding: EdgeInsets.only(top: 40),
          ),
        ),
        PageViewModel(
          title: "Configura el tema",
          bodyWidget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Selecciona el tema que prefieras:",
                style: TextStyle(fontSize: 18.0, color: Colors.black54),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildThemeButton(
                    context,
                    icon: Icons.wb_sunny,
                    label: "Claro",
                    onTap: () {
                      GlobalValues.themeMode.value = 0;
                      ThemeSettings.lightTheme(); // Aplica el tema claro
                    },
                  ),
                  _buildThemeButton(
                    context,
                    icon: Icons.nights_stay,
                    label: "Oscuro",
                    onTap: () {
                      GlobalValues.themeMode.value = 1;
                      ThemeSettings.darkTheme(); // Aplica el tema oscuro
                    },
                  ),
                  _buildThemeButton(
                    context,
                    icon: Icons.palette,
                    label: "Naranja",
                    onTap: () {
                      GlobalValues.themeMode.value = 2;
                      ThemeSettings.customTheme(); // Aplica el tema personalizado
                    },
                  ),
                ],
              ),
            ],
          ),
          image: Lottie.asset('assets/lottie/animation2.json', height: 250.0),
          decoration: PageDecoration(
            titleTextStyle: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
            imagePadding: EdgeInsets.only(top: 40),
          ),
        ),
        PageViewModel(
          title: "Ubicación de la tienda física",
          body: "Visítanos en nuestra tienda física. Haz clic en el ícono para ver la ubicación en Google Maps.",
          image: Icon(
            Icons.location_on,
            color: Theme.of(context).primaryColor,
            size: 150.0,
          ),
          footer: ElevatedButton(
            onPressed: () async {
              const url = 'https://www.google.com/maps/place/20.5139939,-100.9951458';
              if (await canLaunchUrlString(url)) {
                await launchUrlString(url);
              } else {
                throw 'No se pudo abrir el enlace $url';
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text("Ver en Google Maps", style: TextStyle(fontSize: 18.0)),
          ),
          decoration: PageDecoration(
            titleTextStyle: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
            bodyTextStyle: TextStyle(fontSize: 16.0, color: Colors.black54),
            imagePadding: EdgeInsets.only(top: 40),
          ),
        ),
      ],
      onDone: () {
        Navigator.of(context).pushReplacementNamed('/home'); // Redirige a la pantalla principal
      },
      onSkip: () {
        Navigator.of(context).pushReplacementNamed('/home'); // Permite saltar el onboarding
      },
      showSkipButton: true,
      skip: const Text("Saltar", style: TextStyle(fontSize: 16.0)),
      next: const Icon(Icons.arrow_forward, size: 24.0),
      done: const Text("Empezar", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
      dotsDecorator: DotsDecorator(
        size: const Size.square(10.0),
        activeSize: const Size(22.0, 10.0),
        activeColor: Theme.of(context).primaryColor,
        color: Colors.black26,
        spacing: const EdgeInsets.symmetric(horizontal: 3.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );
  }

  // Botón personalizado para selección de temas
  Widget _buildThemeButton(BuildContext context, {required IconData icon, required String label, required Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
            child: Icon(icon, size: 30, color: Theme.of(context).primaryColor),
          ),
          const SizedBox(height: 10),
          Text(label, style: TextStyle(fontSize: 16.0, color: Colors.black54)),
        ],
      ),
    );
  }
}
