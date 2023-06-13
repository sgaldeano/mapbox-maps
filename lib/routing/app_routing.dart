import 'package:flutter/material.dart';
import 'package:s18_mapbox_maps/pages/pages.dart';

class AppRouting {

  static const String initialRoute = FullScreenMapPage.routeName;

  static final Map<String, WidgetBuilder> routes = {
    FullScreenMapPage.routeName: (_) => const FullScreenMapPage()
  };

}