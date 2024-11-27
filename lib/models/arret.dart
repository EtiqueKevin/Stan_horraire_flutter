import 'package:stan_horraire/models/Ligne.dart';

import 'direction.dart';

class Arret {
  Ligne? ligne; 
  final String libelle; 
  final String osmid; 
  int? id;
  Direction? direction; 

  Arret({
    required this.libelle,
    required this.osmid,
  });

  void setId(int id) {
    this.id = id;
  }

  void setDirection(Direction direction) {
    this.direction = direction;
  }

  void setLigne(Ligne ligne) {
    this.ligne = ligne;
  }
}