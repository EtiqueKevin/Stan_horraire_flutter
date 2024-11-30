import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:stan_horraire/providers/favorite_provider.dart';

import 'main_app.dart';
import 'providers/fetch_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => FetchProvider()),
          ChangeNotifierProvider(create: (context) => FavoritesProvider()),
        ],
        child: const MainApp(),
      ),
    );
  });
}
