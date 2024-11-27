import 'Ligne.dart';

class Direction {
  
  final Ligne ligne; 
  final int id; 
  final String direction; 
  final String libelle;

  Direction({
    required this.ligne,
    required this.id,
    required this.direction,
    required this.libelle,
  });
}