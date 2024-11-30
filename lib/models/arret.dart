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
    this.ligne,
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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'libelle': libelle,
      'osmid': osmid,
      'ligne': ligne?.toMap(),
    };
  }

  factory Arret.fromMap(Map<String, dynamic> map) {
    return Arret(
      ligne: map['ligne'] != null ? Ligne.fromMap(map['ligne']) : null,
      libelle: map['libelle'],
      osmid: map['osmid'],
    );
  }
}