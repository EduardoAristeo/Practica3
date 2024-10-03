import 'package:flutter/material.dart';
import 'package:pmsn2024/screens/login_screen.dart';

class ExitScreen extends StatelessWidget {
  const ExitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.door_back_door,
                color: const Color.fromARGB(255, 13, 180, 241),
                size: 180,
              ),
              const SizedBox(height: 20),
              const Text(
                'CERRAR SESIÓN ACTUAL',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                    (route) => false, // Elimina todas las pantallas anteriores
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 13, 180, 241), // Color del botón
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Salir',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                
              ),
              const SizedBox(height: 20),
              const Text(
                'Al salir de la aplicación, se cerrará la sesión actual y todas las ventanas abiertas se cerrarán.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.normal,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
