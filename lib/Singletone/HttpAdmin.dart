import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class HttpAdmin {
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

      // Ahora, también obtenemos datos de PokeAPI y Chuck Norris Jokes
      fetchPokemonData('pikachu'); // Puedes cambiar 'pikachu' por otro Pokémon
      fetchChuckNorrisJoke();

      return temperaturaActual;
    } else {
      print('Request failed with status: ${response.statusCode}.');

      // Si hay un error, puedes lanzar una excepción o retornar un valor por defecto
      throw Exception('Error al obtener la temperatura');
    }
  }

  Future<Map<String, dynamic>> fetchPokemonData(String pokemonName) async {
    var url = Uri.https('pokeapi.co', '/api/v2/pokemon/$pokemonName');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Error al obtener datos del Pokémon');
    }
  }

  Future<String> fetchChuckNorrisJoke() async {
    var url = Uri.https('api.chucknorris.io', '/jokes/random');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
      return jsonResponse['value'];
    } else {
      throw Exception('Error al obtener la broma de Chuck Norris');
    }
  }
}
