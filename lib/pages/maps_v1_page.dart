import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_google_maps/data_dummy.dart';
import 'package:flutter_google_maps/map_type_google.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsV1Page extends StatefulWidget {
  const MapsV1Page({super.key});

  @override
  State<MapsV1Page> createState() => _MapsV1PageState();
}

class _MapsV1PageState extends State<MapsV1Page> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(MarkLocation.latitude, MarkLocation.longitude),
    zoom: MarkLocation.zoom,
  );
  var mapType = MapType.hybrid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Maps V1'),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              setState(() {
                switch (value) {
                  case Type.Normal:
                    mapType = MapType.normal;
                    break;
                  case Type.Hybrid:
                    mapType = MapType.hybrid;
                    break;
                  case Type.Satellite:
                    mapType = MapType.satellite;
                    break;
                  case Type.Terrain:
                    mapType = MapType.terrain;
                    break;      
                  default:
                }
              });
            },
            itemBuilder: (context) => googleMapTypes
            .map((type) => PopupMenuItem(
              value: type.type,
              child: Text(type.type.name),
              )
              ).toList(),
              )
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: mapType,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: {
              const Marker(
              markerId: MarkerId(MarkLocation.name),
              position: LatLng(MarkLocation.latitude, MarkLocation.longitude),
              infoWindow: InfoWindow(title: MarkLocation.infoWindow)
              ),
              }
            
          ),
          Align(
            alignment: Alignment.topRight,
            child: ElevatedButton(
              onPressed: _onPressed,
               child: const Padding(
                padding: EdgeInsets.all(4),
                child: Icon(Icons.place),)
               ),
          )
        ],
        
      ),
      
    );
  }
  _onPressed() async {
    final controller = await _controller.future;
    final cameraUpdate = CameraUpdate.newCameraPosition(_kGooglePlex);
    controller.animateCamera(cameraUpdate);
  }
}