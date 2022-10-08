import 'dart:async';

import '../models/PokemonPaginationResponse.dart';
import '../networking/ApiResponse.dart';
import '../repository/PokemonPaginationRepository.dart';

class PokemonBloc {
  PokemonPaginationRepository _pokemonPaginationRepository;

  StreamController _pokemonListController;

  StreamSink<ApiResponse<List<Pokemon>>> get pokemonListSink =>
      _pokemonListController.sink;

  Stream<ApiResponse<List<Pokemon>>> get pokemonListStream =>
      _pokemonListController.stream;

  PokemonBloc() {
    _pokemonListController = StreamController<ApiResponse<List<Pokemon>>>();
    _pokemonPaginationRepository = PokemonPaginationRepository();
    fetchPokemonList();
  }

  fetchPokemonList() async {
    pokemonListSink.add(ApiResponse.loading('Fetching Pokemons'));
    try {
      List<Pokemon> pokemons =
          await _pokemonPaginationRepository.fetchPokemonList();
      pokemonListSink.add(ApiResponse.completed(pokemons));
    } catch (e) {
      pokemonListSink.add(ApiResponse.error(e.toString()));
    }
  }

  dispose() {
    _pokemonListController?.close();
  }
}
