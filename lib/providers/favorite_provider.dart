import 'package:flutter/material.dart';
import 'package:stan_horraire/database/database_helper.dart';
import 'package:stan_horraire/models/favorite.dart';

class FavoritesProvider with ChangeNotifier {
  List<Favorite> _favorites = [];

  List<Favorite> get favorites => _favorites;

  Future<void> loadFavorites() async {
    _favorites = await DatabaseHelper().getFavorites();
    print(favorites);
    notifyListeners();
  }

  Future<void> addFavorite(Favorite favorite) async {
    await DatabaseHelper().insertFavorite(favorite);
    await loadFavorites();
  }

  Future<void> removeFavorite(Favorite favoris) async {
    await DatabaseHelper().deleteFavorite(favoris);
    await loadFavorites();
  }

  void toggleFavorite(Favorite favorite) {
    isFavorite(favorite) ? removeFavorite(favorite) : addFavorite(favorite);
  } 

  bool isFavorite(Favorite favoris) {
    //verifier si il y a un favori avec l'arret (par son osmid) et si il y a la ligne
    return _favorites.any((favorite) => favorite.arret.osmid == favoris.arret.osmid && favorite.arret.ligne!.osmId== favoris.arret.ligne!.osmId);
  }
}