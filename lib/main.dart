import 'package:flutter/material.dart';
import 'package:s18_mapbox_maps/routing/app_routing.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: AppRouting.initialRoute,
      routes: AppRouting.routes
    );
  }

}