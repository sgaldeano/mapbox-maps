import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:mapbox_gl/mapbox_gl.dart';

class FullScreenMapPage extends StatefulWidget {

  static const String routeName = 'fullscreen_map_page';

  const FullScreenMapPage({super.key});

  @override
  State<FullScreenMapPage> createState() => _FullScreenMapPageState();
}

class _FullScreenMapPageState extends State<FullScreenMapPage> {

  MapboxMapController? _mapController;
  final LatLng _initialPosition = const LatLng(37.810575, -122.477174);
  final String _mapStyleMonochromeGreen = 'mapbox://styles/seba-galdeano/cliukrwbq021v01qgfkwja5de';
  final String _mapStyleStreetsViolet = 'mapbox://styles/seba-galdeano/cliukvpak020i01qp9jgs6k6h';

  String _selectedStyle = 'mapbox://styles/seba-galdeano/cliukvpak020i01qp9jgs6k6h';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildMapboxMap(),
      floatingActionButton: buildFloatingButtons(),
    );
  }

  MapboxMap _buildMapboxMap() {
    return MapboxMap(
      styleString: _selectedStyle,
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: _initialPosition,
        zoom: 18
      )
    );
  }

  _onMapCreated(MapboxMapController controller) {
    _mapController = controller;
    _onStyleLoaded();
  }

  _onStyleLoaded() {
    addImageFromAsset('assetImage', 'assets/custom_icon.png');
    addImageFromUrl('networkImage', Uri.parse('https://thenounproject.com/api/private/icons/1506761/edit/?backgroundShape=SQUARE&backgroundShapeColor=%23000000&backgroundShapeOpacity=0&exportSize=752&flipX=false&flipY=false&foregroundColor=%23000000&foregroundOpacity=1&imageFormat=png&rotation=0'));
  }

  /// Adds an asset image to the currently displayed style
  Future<void> addImageFromAsset(String name, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return _mapController!.addImage(name, list);
  }

  /// Adds a network image to the currently displayed style
  Future<void> addImageFromUrl(String name, Uri uri) async {
    var response = await http.get(uri);
    return _mapController!.addImage(name, response.bodyBytes);
  }

  Column buildFloatingButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        //Add Symbols
        FloatingActionButton(
          child: const Icon(Icons.emoji_symbols),
          onPressed: () {
            _mapController?.addSymbol(SymbolOptions(
                geometry: _initialPosition,
                iconImage: 'networkImage',
                iconSize: 0.5,
                textField: 'Telecaster',
                textOffset: const Offset(0, 3)
              )
            );
          }
        ),

        const SizedBox(height: 10),

        //ZoomIn
        FloatingActionButton(
          child: const Icon(Icons.zoom_in),
          onPressed: () => _mapController?.animateCamera(CameraUpdate.zoomIn())
        ),

        const SizedBox(height: 10),

        //ZoomOut
        FloatingActionButton(
          child: const Icon(Icons.zoom_out),
          onPressed: () => _mapController?.animateCamera(CameraUpdate.zoomOut())
        ),

        const SizedBox(height: 10),

        //Style modifier
        FloatingActionButton(
          child: const Icon(Icons.map_outlined),
          onPressed: () {
            _selectedStyle == _mapStyleMonochromeGreen
                ? _selectedStyle = _mapStyleStreetsViolet
                : _selectedStyle = _mapStyleMonochromeGreen;

            _onStyleLoaded();

            setState(() {});
          }
        )
      ],
    );
  }

}