class Ligne {
  final String id;
  final String numLignePublic;
  final String osmId;
  final String libelle;
  String? image;


  Ligne({
    required this.id,
    required this.numLignePublic,
    required this.osmId,
    required this.libelle,
  });

  void setImage(String image) {
    this.image = image;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'numLignePublic': numLignePublic,
      'osmId': osmId,
      'libelle': libelle,
      'image': image,
    };
  }

  factory Ligne.fromMap(Map<String, dynamic> map) {
    return Ligne(
      id: map['id'],
      numLignePublic: map['numLignePublic'],
      osmId: map['osmId'],
      libelle: map['libelle'],
    );
  }
}