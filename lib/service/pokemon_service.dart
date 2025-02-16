import 'dart:convert';
import 'package:http/http.dart' as http;

class PokemonService {
  final String baseUrl = "https://pokeapi.co/api/v2/pokemon/";

  Future<Map<String, dynamic>> fetchPokemon(String name) async {
    final response = await http.get(Uri.parse("$baseUrl$name"));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load Pokémon data");
    }
  }
}
