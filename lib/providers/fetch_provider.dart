import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:stan_horraire/models/Ligne.dart';
import 'package:stan_horraire/models/arret.dart';
import 'package:stan_horraire/models/passage.dart';

class FetchProvider extends ChangeNotifier {
  final dio = Dio();
  

  Future<List<Ligne>> fetchLignes() async {
    var _data;

    try {
      final response = await dio.get("https://www.reseau-stan.com/");
        _data = _extractDataLignes(response.data);
        for (Ligne ligne in _data) {
          ligne.image = "https://www.reseau-stan.com/typo3conf/ext/kg_package/Resources/Public/images/pictolignes/${ligne.numLignePublic.replaceAll(" ", "_")}.png";
        }
        notifyListeners();
    }catch(e) {
      print(e);
    }
    return _data;
  }

  Future<List<Arret>> fetchArrets(Ligne ligne) async {
    var _data;
    try {
      final response = await dio.post("https://www.reseau-stan.com/?type=476", 
      data: FormData.fromMap({
        'requete': 'tempsreel_arrets', 
        'requete_val': {
          'ligne': ligne.id,
          'numLignePublic': ligne.numLignePublic,
      },
      }),
      options: Options(
        headers: {
        'X-Requested-With': 'XMLHttpRequest'
        }
      )
    );
      _data = _extractDataArrets(response.data);
      for (Arret arret in _data) {
        arret.setLigne(ligne);
      }
      notifyListeners();
    }catch(e) {
      print(e);
    }
    return _data;
  }

  Future<List<Map<String, List<Passage>>>> fetchPassages(Arret arret) async {
    var data;
    try {
      final response = await dio.post("https://www.reseau-stan.com/?type=476",
      data: FormData.fromMap({
        'requete': 'tempsreel_submit', 
        'requete_val': {
          'arret': arret.osmid,
          'ligne_omsid': arret.ligne!.osmId,


      },
      }),
      options: Options(
        headers: {
        'X-Requested-With': 'XMLHttpRequest'
        }
      )
    );
      data = _extractDataPassages(response.data);
      notifyListeners();
    }catch(e) {
      print(e);
    }
    return data;
  }

  List<Ligne> _extractDataLignes(String responseBody) {
    final regex = RegExp(r'data-ligne="(\d+)" data-numlignepublic="([^"]+)" data-osmid="(line[^"+]+)" data-libelle="([^"]+)" value="[^"]+">');
    final matches = regex.allMatches(responseBody);
    return matches.map((match) {
      return Ligne(id: match.group(1)!, numLignePublic: match.group(2)!,osmId: match.group(3)!,libelle: match.group(4)!);
    }).toList();
  }

  List<Arret> _extractDataArrets(String responseBody) {
    final regex = RegExp(r'data-libelle="([^"]+)" data-ligne="(\d+)" data-numlignepublic="([^"]*)" value="([^"]+)">([^<]+)<\/option>');
    final matches = regex.allMatches(responseBody);
    return matches.map((match) {
      return Arret(libelle: match.group(1)!, osmid: match.group(4)!);
    }).toList();
  }
  
   List<Map<String, List<Passage>>> _extractDataPassages(String responseBody) {
    List<Map<String, List<Passage>>> passagesRetour = [];
    List<String> res = responseBody.split('<li>').sublist(1);

    for (String rawPassageLi in res) {
  final directionRegex = RegExp(r'<span>([^"]+)<\/span><\/span>');
  final regexPassagesNow = RegExp(r'class="tpsreel-temps-item large-1 "><i class="icon-car1"><\/i><i title="Temps Réel" class="icon-wifi2"><\/i>');
  final regexPassagesMin = RegExp(r'class="tpsreel-temps-item large-1 ">(\d+) min');
  final regexPassagesH = RegExp(r'temps-item-heure">(\d+)h(\d+)(.*)<\/a>');

  final directionMatch = directionRegex.firstMatch(rawPassageLi);

   if (directionMatch != null) {
    String direction = directionMatch.group(1)!;
    List<Passage> passages = [];
  
    // Capturer tous les passages en minutes
    for (final rawPassage in regexPassagesMin.allMatches(rawPassageLi)) {
      passages.add(Passage(
        temps: int.parse(rawPassage.group(1)!),
        theorique: false,
      ));
    }
  
    // Capturer tous les passages en heures
    for (final rawPassage in regexPassagesH.allMatches(rawPassageLi)) {
      passages.add(Passage(
        temps: int.parse(rawPassage.group(1)!) * 60 + int.parse(rawPassage.group(2)!),
        theorique: rawPassage.group(3)!.contains('tpsreel-temps-item-tpstheorique'),
      ));
    }
  
    // Capturer tous les passages en temps réel
    for (final rawPassage in regexPassagesNow.allMatches(rawPassageLi)) {
      passages.add(Passage(
        temps: 0,
        theorique: false,
      ));
    }
  
    passagesRetour.add(
      {
        direction: passages,
      }
    );
  }
}
    return passagesRetour;
  }
}