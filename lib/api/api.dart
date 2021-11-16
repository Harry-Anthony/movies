import 'package:dio/dio.dart';
import 'package:connectivity/connectivity.dart';

const token = "4e0c5c780f41e79fdc5164b1eee8e79f";


// var connectivityResult = await (Connectivity().checkConnectivity());
// if (connectivityResult == ConnectivityResult.mobile) {
//   // I am connected to a mobile network.
// } else if (connectivityResult == ConnectivityResult.wifi) {
//   // I am connected to a wifi network.
// }
Future<dynamic> getFilmsFromApiWithSearchText(String text, dynamic page) async {
  dynamic result;
   String url = 'https://api.themoviedb.org/3/search/movie?api_key=' + token + '&language=fr&query=' + text + "&page="+ page.toString();
   result = await Dio().get(url);
   return result.data;
}

Future<String> getImageFromApi(String text) async {
  return  'https://image.tmdb.org/t/p/w300' + text;
}