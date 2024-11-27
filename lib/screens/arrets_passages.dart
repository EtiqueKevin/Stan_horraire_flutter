import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stan_horraire/models/arret.dart';
import 'package:stan_horraire/models/passage.dart';
import 'package:stan_horraire/providers/fetch_provider.dart';

class ArretsPassages extends StatefulWidget {
  final Arret arret;

  const ArretsPassages({required this.arret, super.key});

  @override
  State<ArretsPassages> createState() => _ArretsPassagesState();
}

class _ArretsPassagesState extends State<ArretsPassages> {
  Timer? _timer;
  late Future<List<Map<String, List<Passage>>>> _futurePassages;

  @override
  void initState() {
    super.initState();
    _futurePassages = _fetchPassages();
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      setState(() {
        _futurePassages = _fetchPassages();
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<List<Map<String, List<Passage>>>> _fetchPassages() {
    return Provider.of<FetchProvider>(context, listen: false).fetchPassages(widget.arret);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  
        Text(
          '${widget.arret.ligne!.numLignePublic} | Passages pour ${widget.arret.libelle}',
          style: Theme.of(context).textTheme.headlineMedium,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: FutureBuilder<List<Map<String, List<Passage>>>>(
        future: _futurePassages,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Erreur: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('Aucune donnée disponible');
          } else {
           return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final map = snapshot.data![index];
              final direction = map.keys.first;
              final passages = map[direction]!;
              passages.sort((a, b) => a.temps.compareTo(b.temps));

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      direction,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: passages.length,
                    itemBuilder: (context, index) {
                      final passage = passages[index];
                      return Container(
                        margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
                        child: ListTile(
                          tileColor: Theme.of(context).colorScheme.tertiary,
                          title: 
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Temps: ${passage.tempsString}', style: Theme.of(context).textTheme.bodyLarge),
                              Text('Temps réel: ${passage.theorique ? "Non" : "Oui"}', style: Theme.of(context).textTheme.bodySmall),
                            ],
                          ),
                          trailing: Text(passage.calculHeureArrivee(), style: Theme.of(context).textTheme.bodyLarge),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          );
          }
        },
      ),
    );
  }
}