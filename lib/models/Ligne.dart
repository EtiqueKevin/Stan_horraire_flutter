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
}