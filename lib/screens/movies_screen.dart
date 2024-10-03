import 'package:flutter/material.dart';
import 'package:pmsn2024/database/movies_databases.dart';
import 'package:pmsn2024/models/moviesdao.dart';
import 'package:pmsn2024/settings/global_values.dart';
import 'package:pmsn2024/views/movie_view_item.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class MoviesScreen extends StatefulWidget {

  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  late MoviesDatabases moviesDatabases;

  @override
  void initState() {
    super.initState();
    // Inicialización segura de la base de datos
    moviesDatabases = MoviesDatabases();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              WoltModalSheet.show(
                context: context,
                pageListBuilder: (context) => [
                   WoltModalSheetPage(child: MovieView())
                ],
              );
            },
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: GlobalValues.banUpdListMovie,
        builder: (context, value, _) {
          return FutureBuilder<List<MoviesDAO>>(
            future: moviesDatabases.SELECT(),
            builder: (context, AsyncSnapshot<List<MoviesDAO>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return MovieView(moviesDAO: snapshot.data![index]);
                    },
                  );
                } else {
                  // Si no hay películas en la base de datos
                  return const Center(
                    child: Text(
                      "No movies found. Add a new movie to get started!",
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                }
              } else if (snapshot.hasError) {
                // Mostrar detalles si hay un error
                return Center(
                  child: Text(
                    "Something went wrong! :(\n${snapshot.error}",
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                // Mostrar un indicador de carga mientras se obtienen los datos
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          );
        },
      ),
    );
  }
}
