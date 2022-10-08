import '../blocs/PokemonBloc.dart';
import '../models/PokemonPaginationResponse.dart';
import '../networking/ApiResponse.dart';
import 'package:flutter/material.dart';

class PokemonScreen extends StatefulWidget {
  @override
  State<PokemonScreen> createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen> {
  PokemonBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = PokemonBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Pokemons',
          style: TextStyle(
            fontSize: 28,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => _bloc.fetchPokemonList(),
        child: StreamBuilder<ApiResponse<List<Pokemon>>>(
            stream: _bloc.pokemonListStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.data.status) {
                  case Status.LOADING:
                    return Loading(loadingMessage: snapshot.data.message);
                    break;
                  case Status.COMPLETED:
                    return PokemonList(pokemonList: snapshot.data.data);
                    break;
                }
              }
              return Container();
            }),
      ),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class PokemonList extends StatelessWidget {
  final List<Pokemon> pokemonList;

  const PokemonList({Key key, this.pokemonList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(pokemonList[0].name);
    print(pokemonList[0].url);

    return GridView.builder(
      itemCount: pokemonList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5 / 1.8,
      ),
      itemBuilder: (context, index) {
        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
                onTap: () {
                  // Aqui vai abrir a segunda tela com as evoluções de cada pokemão
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(pokemonList[index].name),
                  ),
                )));
      },
    );
  }
}

class Loading extends StatelessWidget {
  final String loadingMessage;
  const Loading({Key key, this.loadingMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          loadingMessage,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24),
        ),
        SizedBox(height: 24),
        CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.lightGreen))
      ],
    ));

    return Container();
  }
}
