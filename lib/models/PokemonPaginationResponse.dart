class PokemonPaginationResponse {
  int totalResults;
  String nextUrl;
  String previousUrl;
  List<Pokemon> results;

  PokemonPaginationResponse.fromJson(Map<String, dynamic> json) {
    nextUrl = json['next'];
    previousUrl = json['previous'];
    totalResults = json['count'];

    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results.add(Pokemon.fromJson(v));
      });
    }
  }
}

class Pokemon {
  String name;
  String url;

  Pokemon({this.name, this.url});

  Pokemon.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }
}
