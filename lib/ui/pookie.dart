import 'package:flutter/material.dart';

import '../service/pokemon_service.dart';


class PokemonScreen extends StatefulWidget {
  @override
  _PokemonScreenState createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen> {
  final PokemonService _pokemonService = PokemonService();
  Map<String, dynamic>? _pokemonData;
  String _pokemonName = "ditto"; // Default Pokémon

  @override
  void initState() {
    super.initState();
    _fetchPokemon();
  }

  void _fetchPokemon() async {
    try {
      var data = await _pokemonService.fetchPokemon(_pokemonName);
      setState(() {
        _pokemonData = data;
      });
    } catch (e) {
      print("Error fetching Pokémon: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pokémon Info")),
      body: _pokemonData == null
          ? Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Name: ${_pokemonData!['name']}", style: TextStyle(fontSize: 24)),
                Image.network(_pokemonData!['sprites']['front_default']),
                Text("Height: ${_pokemonData!['height']}"),
                Text("Weight: ${_pokemonData!['weight']}"),
                Text("Base Experience: ${_pokemonData!['base_experience']}"),
              ],
            ),
    );
  }
}
