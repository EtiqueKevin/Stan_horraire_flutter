import 'package:stan_horraire/models/Ligne.dart';

import 'arret.dart';

class Favorite {
  final Arret arret;

  Favorite({required this.arret});

  Map<String, dynamic> toMap() {
    return {
      'libelle_arret': arret.libelle,
      'osmid_arret': arret.osmid,
      'num_ligne': arret.ligne!.numLignePublic,
      'id_ligne': arret.ligne!.id,
      'libelle_ligne': arret.ligne!.libelle,
      'osmid_ligne': arret.ligne!.osmId,
    };
  }

  factory Favorite.fromMap(Map<String, dynamic> map) {
    return Favorite(
      arret: Arret(
        libelle: map['libelle_arret'],
        osmid: map['osmid_arret'],
        //faire en sorte que la ligne se recrée 
        ligne: Ligne(
          numLignePublic: map['num_ligne'],
          id: map['id_ligne'],
          libelle: map['libelle_ligne'],
          osmId: map['osmid_ligne'],
          ),
      )
    );
  }
}