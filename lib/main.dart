import 'package:flutter/material.dart';
import 'package:peliculas/providers/peliculas_provider.dart';
import 'package:peliculas/routers/app_routes.dart';
import 'package:peliculas/theme/app_theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(const AppEstado());

//traer datos del provider, se puede traer en un screen en especifico
class AppEstado extends StatelessWidget {
  const AppEstado({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider( //traer todo los datos, prioritario
      providers: [
        ChangeNotifierProvider(create: (_) => PeliculasProvider(), lazy: false),
        //AGREGAR MAS PROVIDERS
      ],
      child: MyApp(),
    );
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Películas',
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.getAppRoutes(),
      theme: AppTheme.lightTheme
    );
  }
}
