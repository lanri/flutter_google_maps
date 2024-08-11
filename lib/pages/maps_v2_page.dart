import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_google_maps/data_dummy.dart';
import 'package:flutter_google_maps/map_type_google.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsV2Page extends StatefulWidget {
  const MapsV2Page({super.key});

  @override
  State<MapsV2Page> createState() => _MapsV2PageState();
}

class _MapsV2PageState extends State<MapsV2Page> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(MarkLocation.latitude, MarkLocation.longitude),
    zoom: MarkLocation.zoom,
  );
  
  var mapType = MapType.hybrid;

  Position? devicePosition;
  String? address;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Geolocator.requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Maps V2'),
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
              
            
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              height: 150,
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(10),
                child: Column(
                  children: [
                    // KOLOM PENCARION
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 8, bottom: 4),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Masukkan alamat...",
                          suffixIcon: IconButton(
                            onPressed: () async {},
                            icon: const Icon(Icons.search),
                          ),
                        ),
                        onChanged: (value) {},
                      ),
                    ),

                    // TOMBOL DAPATKAN LOKASI
                    ElevatedButton(
                        onPressed: () async {},
                        child: const Text("Dapatkan lokasi saat ini")),

                    // TEKS LOKASI YANG DI DAPAT
                    devicePosition != null
                        ? Text(
                            "Lokasi saat ini : ${devicePosition?.latitude} ${devicePosition?.longitude}")
                        : const Text("Lokasi belum terdeteksi")
                  ],
                ),
              ),
            ),
          ),
        ],
        
      ),
      
    );
  }
}

class _onPressed {
}