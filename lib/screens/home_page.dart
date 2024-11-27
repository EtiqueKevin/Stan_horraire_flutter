import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:provider/provider.dart';
import 'package:stan_horraire/screens/ligne_arrets.dart';

import '../models/Ligne.dart';
import '../providers/fetch_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
 appBar: AppBar(
        title: const Text('Lignes'),
      ),
      body: const Center(
         child: FutureBuilderListeLigne(),
      ),
    );
  }
}

class FutureBuilderListeLigne extends StatelessWidget {
  const FutureBuilderListeLigne({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Ligne>>(
      future: Provider.of<FetchProvider>(context, listen: false).fetchLignes(),
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
            final unescape = HtmlUnescape();
             final ligne = snapshot.data![index];
             return Container(
              margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
               child: ListTile(
                tileColor: Theme.of(context).colorScheme.tertiary,
                leading: CircleAvatar(
                  radius: 20,
                  backgroundImage: ligne.image == null 
                  ? const AssetImage("assets/images/default_pp.png")
                  : FadeInImage.assetNetwork(
                    placeholder: "assets/images/default_pp.png",
                    image: ligne.image!,
                    fit: BoxFit.cover,
                  ).image,
                  backgroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
                 title: Text(unescape.convert(ligne.libelle), style: Theme.of(context).textTheme.titleSmall),
                 subtitle: Text('Numéro: ${ligne.numLignePublic}', style: Theme.of(context).textTheme.bodyMedium),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LigneArrets(ligne: ligne),
                      ),
                    );
                  },
               ),
             );
           },
         );
       }
      }
    );
  }
}
