import 'package:http/http.dart' as http;
import 'dart:convert';

class PokemonListItem {
  final String url;
  final String name;

  const PokemonListItem({
    required this.url,
    required this.name,
  });

  factory PokemonListItem.fromJson(Map<String, dynamic> json) {
    return PokemonListItem(
      url: json['url'],
      name: json['name'],
    );
  }
}

class Pokemon {
  final String name;
  final int id;
  final int weight;
  final String spriteUrl;

  const Pokemon({
    required this.name,
    required this.id,
    required this.weight,
    required this.spriteUrl,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      name: json['name'],
      weight: json['weight'],
      spriteUrl: json['sprites']['front_default'],
    );
  }
}

Future<Pokemon> fetchPokemon(int id) async {
  final response =
      await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$id'));

  if (response.statusCode == 200) {
    return Pokemon.fromJson(
      jsonDecode(response.body),
    );
  } else {
    throw Exception('$id failed');
  }
}

Future<List<PokemonListItem>> fetchPokemonList() async {
  final response =
      await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon'));

  if (response.statusCode == 200) {
    List<PokemonListItem> pokemonList =
        (json.decode(response.body)['results'] as List)
            .map((data) => PokemonListItem.fromJson(data))
            .toList();

    return pokemonList;
  } else {
    throw Exception('Falied to load Pokemons');
  }
}
