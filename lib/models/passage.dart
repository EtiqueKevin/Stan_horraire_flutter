class Passage {
  final int temps;
  final bool theorique;

  Passage({
    required this.temps,
    required this.theorique,
  });

  String get destination {
    return 'Destination';
  }

  String get tempsString {
    if (temps == 0) {
      return 'Imminent';
    } else if (temps < 60) {
      return '$temps min';
    } else {
      final heures = temps ~/ 60;
      final minutes = temps % 60;
      return '$heures h $minutes min';
    }
  }

  String calculHeureArrivee() {
    final now = DateTime.now();
    final arrivee = now.add(Duration(minutes: temps));
    final formattedHour = arrivee.hour.toString().padLeft(2, '0');
    final formattedMinute = arrivee.minute.toString().padLeft(2, '0');
    return '$formattedHour:$formattedMinute';
  }
}