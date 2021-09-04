import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  _homeScreenState createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {

  // late Position _currentPosition;
  // late String _currentAddress;
  //
  // double _longitude = 37.42796133580664,
  //     _latitude = -122.085749655962;
  //
  // final Geolocator _geolocatr = Geolocator()
  //   ..forceAndroidLocationManager;
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: new LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  Completer<GoogleMapController> _controller = Completer();

  // _getCurrentLocation() {
  //   _geolocatr.getCurrentPosition(desiredAccuracy: LocationAccuracy.best).then((Position)  {
  //    setState((){
  //      _currentPosition = Position;
  //      _latitude = _currentPosition.latitude;
  //      _longitude = _currentPosition.longitude;
  //   });
  //     _getAddressFromLatLng();
  //   }).catchError((e){
  //     print(e);
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Welcome to app'),
        ),
        body: Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              myLocationButtonEnabled: true,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController gmc) {
                _controller.complete(gmc);
              },
            ),
          ],
        )
    );
  }
}

//   void _getAddressFromLatLng() async {
//     try{
//       List<Placemark> p = await _geolocatr.placemarkFromCoordinates(_currentPosition.latitude, _currentPosition.longitude);
//       Placemark place = p[0];
//       setState(() {
//         _currentAddress = "${place.locality},${place.postalCode},${place.country}";
//       });
//     } catch (e){
//       print(e);
//     }
//   }
// }
