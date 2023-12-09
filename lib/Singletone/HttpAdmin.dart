import 'package:examenmcb/CustomViews/CustomDialog.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class HttpAdmin{


  HttpAdmin();


  Future<double> pedirTemperaturasEn(double lat, double lon) async {
    var url = Uri.https('api.open-meteo.com', '/v1/forecast', {
      'latitude': lat.toString(),
      'longitude': lon.toString(),
      'hourly': 'temperature_2m',
    });

    print("URL RESULTANTE: " + url.toString());

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
      print("MAPA ENTERO: " + jsonResponse.toString());

      var jsonHourly = jsonResponse['hourly'];
      var jsonTimes = jsonHourly['time'];
      var jsonTiempoActual = jsonTimes[0];
      var jsonTemperaturas = jsonHourly['temperature_2m'];
      var jsonTemperaturaActual = jsonTemperaturas[0];

      double temperaturaActual = jsonTemperaturaActual.toDouble();

      return temperaturaActual;
    } else {
      print('Request failed with status: ${response.statusCode}.');

      // Si hay un error, puedes lanzar una excepción o retornar un valor por defecto
      throw Exception('Error al obtener la temperatura');
    }
  }


}