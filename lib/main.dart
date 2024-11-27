import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'main_app.dart';
import 'providers/fetch_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([ 
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown, 
  ]).then((_) {
    runApp(
      ChangeNotifierProvider(
        create: (context) => FetchProvider(),
        child: const MainApp(),
      ),
    ); 
  });
}
