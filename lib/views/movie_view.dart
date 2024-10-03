import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pmsn2024/database/movies_databases.dart';
import 'package:pmsn2024/database/movies_databases.dart';
import 'package:pmsn2024/database/movies_databases.dart';
import 'package:pmsn2024/models/moviesdao.dart';
import 'package:quickalert/quickalert.dart';

import '../database/movies_databases.dart';

class MovieView extends StatefulWidget {
  const MovieView({super.key});

  @override
  State<MovieView> createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {
  TextEditingController conName = TextEditingController();
  TextEditingController conOverview = TextEditingController();
  TextEditingController conImgMovie = TextEditingController();
  TextEditingController conRelease = TextEditingController();
  MoviesDatabases? moviesDatabase;


  @override
  void initState() {
    super.initState();
    moviesDatabase = MoviesDatabases();
  }

  Widget build(BuildContext context) {
    final txtNameMovie = TextFormField(
      controller: conName,
      decoration: InputDecoration(
        labelText: 'Name Movie',
        hintText: 'Ingrese el nombre de la película',
      ),
    );
    final TextOverview = TextFormField(
      controller: conOverview,
      decoration: InputDecoration(
        labelText: 'Overview',
        hintText: 'Ingrese la descripción de la película',
      ),
    );
    final txtImgMovie = TextFormField(
      controller: conImgMovie,
      decoration: InputDecoration(
        labelText: 'Image Movie',
        hintText: 'Ingrese la URL de la imagen',
      ),
    );
    final txtRelease = TextFormField(
      readOnly: true,
      controller: conRelease,
      decoration: InputDecoration(
        labelText: 'Release',
        hintText: 'Escriba la fecha de lanzamiento',
      ),
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        );
        if (date != null) {
          String formatDate = DateFormat('dd-MM-yyyy').format(date);
          conRelease.text = formatDate;
        }
      },
    );

    final btnSave = ElevatedButton(
       onPressed: () {
        moviesDatabase!.INSERT('tblMovies', {
          'nameMovie': conName.text,
          'overview': conOverview.text,
          'imgMovie': conImgMovie.text,
          'releaseDate': conRelease.text,
        }).then((value) {
          if (value > 0) {
            return QuickAlert.show(
              context: context,
              type: QuickAlertType.success,
              title: 'Success',
              text: 'Movie added successfully',
              autoCloseDuration: const Duration(seconds: 2),
              showConfirmBtn: false,
            );
          }
        });
        ;},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
      ),
      child: const Text('Save'),
    );

    return ListView(
      padding: const EdgeInsets.all(25),
      shrinkWrap: true,
      children: [
        const Text('Add Movie into Data Base', style: TextStyle(fontSize: 25)),
        txtNameMovie,
        TextOverview,
        txtImgMovie,
        txtRelease,
        btnSave,
      ],
      
    );
  }
}