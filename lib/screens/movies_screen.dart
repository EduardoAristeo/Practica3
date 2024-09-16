import 'package:flutter/material.dart';
import 'package:pmsn2024/database/movies_databases.dart';
import 'package:pmsn2024/models/moviesdao.dart';

class MoviesScreen extends StatefulWidget {

  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {

 // MoviesDatabases moviesDatabases = MoviesDatabases();
  late MoviesDatabases moviesDatabases;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies'),
        
      ),
      body: FutureBuilder(
        future: moviesDatabases.SELECT(),
        builder: (context,AsyncSnapshot<List<MoviesDAO>> snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
            return ListView.builder(
            itemBuilder: (context, index) {
             //return MovieView();
            },
          );
          }else{
            if(snapshot.hasData){
              return Center(child: Text("Something was wrong! :("),);
            }else{
              return Center(child: CircularProgressIndicator(),);
            }
          }
          
        }
      ),
    );
      
  }
}