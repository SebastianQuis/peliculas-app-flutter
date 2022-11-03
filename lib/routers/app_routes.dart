import 'package:flutter/material.dart';
import 'package:peliculas/pages/details_screen.dart';
import 'package:peliculas/pages/home_screen.dart';

class AppRoutes {
  static const initialRoute = 'home';

   //AGREGANDO SCREENS
  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};

    appRoutes.addAll({'home': ( BuildContext context ) => HomeScreen()});
    appRoutes.addAll({'details': ( BuildContext contest) => DetailsScreen()});

    return appRoutes; 
  }

}


