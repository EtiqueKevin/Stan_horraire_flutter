import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:stan_horraire/models/Ligne.dart';
import 'package:stan_horraire/models/arret.dart';
import 'package:stan_horraire/providers/fetch_provider.dart';
import 'package:stan_horraire/screens/arrets_passages.dart';

class LigneArrets extends StatefulWidget {
  final Ligne ligne;

  const LigneArrets({required this.ligne, super.key});

  @override
  State<LigneArrets> createState() => _LigneArretsState();
}

class _LigneArretsState extends State<LigneArrets> {
  late Future<List<Arret>> _futureArrets;

  @override
  void initState() {
    super.initState();
    _futureArrets = _fetchArrets();
  }

  Future<List<Arret>> _fetchArrets() {
    return Provider.of<FetchProvider>(context, listen: false).fetchArrets(widget.ligne);
  }

  @override
  Widget build(BuildContext context) {
    final unescape = HtmlUnescape();
    return Scaffold(
      appBar: AppBar(
        title: 
        Text(
          unescape.convert(widget.ligne.libelle),
          style: Theme.of(context).textTheme.headlineMedium,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Center(
        child: FutureBuilder<List<Arret>>(
          future: _futureArrets,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Erreur: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('Aucune donnée disponible');
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final arret = snapshot.data![index];
                  return Container(
                    margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
                    child: ListTile(
                      tileColor: Theme.of(context).colorScheme.tertiary,
                      title: Center(child: Text(unescape.convert(arret.libelle),style: Theme.of(context).textTheme.bodyMedium)),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ArretsPassages(arret: arret),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}