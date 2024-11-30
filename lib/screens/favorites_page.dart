import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:provider/provider.dart';
import 'package:stan_horraire/providers/favorite_provider.dart';
import 'package:stan_horraire/screens/arrets_passages.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    final unescape = HtmlUnescape();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoris'),
      ),
      body: Center(
        child: Consumer<FavoritesProvider>(
          builder: (BuildContext context, FavoritesProvider provider, Widget? child) { 
            if (provider.favorites.isEmpty) {
              return const Text('Aucun favoris');
            }
            return ListView.builder(
              itemCount: provider.favorites.length,
              itemBuilder: (BuildContext context, int index) {
                final favoris = provider.favorites[index];
                return Container(
                  margin: const EdgeInsets.only(top: 5, left: 5, right: 5),
                  child: ListTile(
                    tileColor: Theme.of(context).colorScheme.secondary,
                    title: Text("${favoris.arret.ligne!.numLignePublic} | ${favoris.arret.libelle}"),
                    subtitle: Text(unescape.convert(favoris.arret.ligne!.libelle)),
                    trailing: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        provider.removeFavorite(favoris);
                      },
                    ),
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ArretsPassages(arret: favoris.arret),
                        ),
                      ),
                    },
                  ),
                );
              },
            );
           },
          
        ),
      ),
    );
  }
}