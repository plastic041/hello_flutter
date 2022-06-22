import 'package:flutter/material.dart';

import 'pokemon.dart';

class PokemonPage extends StatefulWidget {
  const PokemonPage({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  State<PokemonPage> createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  late Future<Pokemon> futurePokemon;

  @override
  void initState() {
    super.initState();
    futurePokemon = fetchPokemon(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<Pokemon>(
          future: futurePokemon,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!.name);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const Text("불러오는 중...");
          },
        ),
      ),
      body: FutureBuilder<Pokemon>(
        future: futurePokemon,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Hero(
                  tag: snapshot.data!.name,
                  child: Image(
                    image: NetworkImage(snapshot.data!.spriteUrl),
                    width: 192,
                    height: 192,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No.${snapshot.data!.id.toString()}',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      snapshot.data!.name,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ],
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
