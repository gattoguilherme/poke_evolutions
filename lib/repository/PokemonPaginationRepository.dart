import 'package:poke_evolutions/models/PokemonPaginationResponse.dart';

import '../networking/ApiBaseHelper .dart';

class PokemonPaginationRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<Pokemon>> fetchPokemonList() async {
    final response = await _helper.get("pokemon/");
    return PokemonPaginationResponse.fromJson(response).results;
  }
}
