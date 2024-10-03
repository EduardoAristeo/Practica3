import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pmsn2024/database/movies_databases.dart';
import 'package:pmsn2024/models/moviesdao.dart';
import 'package:pmsn2024/settings/global_values.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';



class MovieView extends StatefulWidget {
  MovieView(
    {super.key,
     this.moviesDAO });

  MoviesDAO? moviesDAO;

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

    if (widget.moviesDAO != null) {
  conName.text = widget.moviesDAO?.nameMovie ?? '';  // Si nameMovie es nulo, asigna una cadena vacía
  conOverview.text = widget.moviesDAO?.overview ?? '';  // Igual con overview
  conImgMovie.text = widget.moviesDAO?.imgMovie ?? '';  // Igual con imgMovie
  conRelease.text = widget.moviesDAO?.releaseDate ?? '';  // Igual con releaseDate
}

  }

  @override
  Widget build(BuildContext context) {

    final txtNameMovie = TextFormField(
      controller: conName,
      decoration: const InputDecoration(
        hintText: 'Nombre de la película'
      ),
    );
    final txtOverview = TextFormField(
      controller: conOverview,
      maxLines: 5,
      decoration: const InputDecoration(
        hintText: 'Sinapsis de la película'
      ),
    );
    final txtImgMovie = TextFormField(
      controller: conImgMovie,
      decoration: const InputDecoration(
        hintText: 'Poster de la película'
      ),
    );
    final txtRelease = TextFormField(
      readOnly: true,
      controller: conRelease,
      decoration: const InputDecoration(
        hintText: 'Fecha de lanzamiento'
      ),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context, 
          initialDate: DateTime.now(),
          firstDate: DateTime(2024), 
          lastDate: DateTime(2050)
        );

        if( pickedDate != null ){
          String formatDate = DateFormat('dd-MM-yyyy').format(pickedDate);
          conRelease.text = formatDate;
          setState(() {});
        }
      },
    );

    final btnSave = ElevatedButton(
      onPressed: (){
       if( widget.moviesDAO == null ){
    // Realizar inserción si widget.moviesDAO es nulo
    moviesDatabase!.INSERT('tblmovies', {
      "nameMovie" : conName.text,
      "overview" : conOverview.text,
      "imgMovie" : conImgMovie.text,
      "releaseDate" : conRelease.text
    }).then((value){
        if( value > 0 ){
          GlobalValues.banUpdListMovie.value = !GlobalValues.banUpdListMovie.value;
          return QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            text: 'Transaction Completed Successfully!',
            autoCloseDuration: const Duration(seconds: 2),
            showConfirmBtn: false,
          );
        } else {
          return QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            text: 'Something went wrong! :(',
            autoCloseDuration: const Duration(seconds: 2),
            showConfirmBtn: false,
          );
        }
    });
} else {
    // Realizar actualización si widget.moviesDAO no es nulo
    moviesDatabase!.UPDATE('tblmovies', {
      "idMovie": widget.moviesDAO!.idMovie,
      "nameMovie" : conName.text,
      "overview" : conOverview.text,
      "imgMovie" : conImgMovie.text,
      "releaseDate" : conRelease.text
    }).then((value){
        final msj;
        QuickAlertType type= QuickAlertType.success;
        if(value > 0){
          GlobalValues.banUpdListMovie.value = !GlobalValues.banUpdListMovie.value;
          type = QuickAlertType.success;
          msj = "update completed successfully";
          
        } else {
          type = QuickAlertType.error;
          msj = "Something went wrong!";
        }
        return QuickAlert.show(
          context: context,
  type: QuickAlertType.success,
  text: 'Transaction Completed Successfully!',
  autoCloseDuration: const Duration(seconds: 2),  // Tiempo en segundos para que se cierre automáticamente
  showConfirmBtn: false,  // No mostrar botón de confirmación si deseas que se cierre automáticamente
        );
    });
}

      }, 
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue[200]
      ),
      child: const Text('Guardar'),
    ); 

    return ListView(
      padding: EdgeInsets.all(10),
      shrinkWrap: true,
      children: [
        txtNameMovie,
        txtOverview,
        txtImgMovie,
        txtRelease,
        btnSave
      ],
    );
  }
}