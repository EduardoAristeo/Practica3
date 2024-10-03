import 'package:dio/dio.dart';

class PopularApi {
  

  void getPopularMovies() async{
    // Lógica para obtener las películas populares
    final dio = Dio();
    void getPopularMovies() async{
     
      final response = await dio.get('https://api.themoviedb.org/3/movie/popular?api_key=YOUR_API_KEY&language=en-US&page=1');
      final res = response.data['results'];
      print(res);
  }
  
  }

}