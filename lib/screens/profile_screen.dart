import 'dart:io'; // Importa la librería para manejar archivos.
import 'package:flutter/material.dart'; // Importa la librería de widgets de Flutter.
import 'package:image_picker/image_picker.dart'; // Importa la librería para seleccionar imágenes.
import 'package:url_launcher/url_launcher.dart'; // Importa la librería para lanzar URLs.

class ProfileScreen extends StatefulWidget {
  // Constructor para la pantalla de perfil
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Variable que almacena la imagen seleccionada por el usuario
  XFile? _imageCargada;

  // Método que permite al usuario seleccionar una imagen de la galería o la cámara
  Future<void> _leerImg(ImageSource source) async {
    final ImagePicker _picker = ImagePicker(); // Crea una instancia de ImagePicker
    final XFile? selectedImage = await _picker.pickImage(source: source); // Permite seleccionar una imagen desde la fuente especificada

    // Actualiza el estado de la imagen seleccionada
    setState(() {
      _imageCargada = selectedImage;
    });
  }

  // Método que abre una URL en el navegador o en una aplicación específica
  Future<void> _abrirUrl(String url) async {
    final Uri parsedUrl = Uri.parse(url); // Convierte la cadena en una Uri

    // Verifica si se puede abrir la URL
    if (await canLaunchUrl(parsedUrl)) {
      await launchUrl(parsedUrl, mode: LaunchMode.externalApplication); // Lanza la URL
    } else {
      throw 'Imposible abrir url:  $url'; // Lanza una excepción si no se puede abrir
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Estructura principal de la pantalla
      body: Container(
        // Contenedor con un fondo degradado
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [const Color.fromARGB(255, 255, 255, 255), Colors.blue.shade50], // Colores del degradado
            begin: Alignment.topCenter, // Comienzo del degradado
            end: Alignment.bottomCenter, // Fin del degradado
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Espaciado interno del contenedor
          child: Column(
            children: [
              // Imagen de perfil
              GestureDetector(
                // Permite detectar gestos sobre el widget
                child: CircleAvatar(
                  radius: 80, // Radio del círculo externo
                  backgroundColor: const Color.fromARGB(255, 0, 255, 221), // Color de fondo del círculo externo
                  child: CircleAvatar(
                    radius: 75, // Radio del círculo interno
                    backgroundImage: _imageCargada != null
                        ? FileImage(File(_imageCargada!.path)) // Si hay una imagen seleccionada, se muestra
                        : const AssetImage('assets/profile.jpg') // Si no, se muestra una imagen predeterminada
                            as ImageProvider,
                  ),
                ),
                // Permite seleccionar una nueva imagen al tocar la imagen de perfil
                onTap: () => _leerImg(ImageSource.gallery),
              ),
              const SizedBox(height: 20), // Espacio vertical entre widgets
              
              // ListTile para mostrar el nombre
              const ListTile(
                leading: Icon(Icons.person_2_rounded, color: Color.fromARGB(255, 0, 255, 221)), // Icono
                title: Text('Name', style: TextStyle(fontWeight: FontWeight.bold)), // Título
                subtitle: Text('Aristeo Ramirez Sergio Eduardo'), // Subtítulo con el nombre
              ),

              // ListTile para mostrar el teléfono y permitir hacer una llamada
              ListTile(
                leading: const Icon(Icons.phone, color: Color.fromARGB(255, 0, 255, 221)), // Icono
                title: const Text('Telephone'), // Título
                subtitle: const Text('411-100-1969'), // Subtítulo con el número de teléfono
                onTap: () => _abrirUrl('tel:+52-411-100-19-69'), // Acción al tocar: hacer una llamada
              ),
              
              // ListTile para mostrar el correo electrónico y permitir enviar un correo
              ListTile(
                leading: const Icon(Icons.email, color: Color.fromARGB(255, 0, 255, 221)), // Icono
                title: const Text('Email'), // Título
                subtitle: const Text('20030628@itcelaya.edu.mx'), // Subtítulo con el correo electrónico
                onTap: () => _abrirUrl('mailto:20030628@itcelaya.edu.mx?subject=News&body=New%20plugin'), // Acción al tocar: enviar un correo
              ),
              
              // ListTile para mostrar el enlace a GitHub y permitir abrir la URL
              ListTile(
                leading: const Icon(Icons.web, color: Color.fromARGB(255, 0, 255, 221)), // Icono
                title: const Text('Git'), // Título
                subtitle: const Text('https://github.com/EduardoAristeo'), // Subtítulo con el enlace a GitHub
                onTap: () => _abrirUrl('https://github.com/EduardoAristeo'), // Acción al tocar: abrir la URL de GitHub
              ),
              
              // ListTile para mostrar el enlace a Instagram y permitir abrir la URL
              ListTile(
                leading: const Icon(Icons.car_repair, color: Color.fromARGB(255, 0, 255, 221)), // Icono
                title: const Text('GamesTech'), // Título
                subtitle: const Text('https://www.instagram.com/gamestech_villagran/'), // Subtítulo con el enlace a Instagram
                onTap: () => _abrirUrl('https://www.instagram.com/gamestech_villagran/'), // Acción al tocar: abrir la URL de Instagram
              ),
            ],
          ),
        ),
      ),
    );
  }
}
