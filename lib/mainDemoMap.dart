import 'dart:async';

import 'package:findingmotels/config_app/configApp.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  @override
  void initState() {
    super.initState();
    ConfigApp.myGoogleMapService.getLocation();
    ConfigApp.myGoogleMapService.gotoMyLocation();
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        buildingsEnabled: false,
        zoomControlsEnabled: false,
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          ConfigApp.ggMapcontroller.complete(controller);
        },
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //     onPressed: () {
      //       ConfigApp.myGoogleMapService.gotoMyLocation();
      //     },
      //     label: Text('Location'),
      //     icon: Icon(Icons.directions_boat)),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Location location = Location();

  Future<void> _showInfoDialog() {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Demo Application'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Text('Created by Guillaume Bernos'),
                InkWell(
                    child: Text(
                      'https://github.com/Lyokone/flutterlocation',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onTap: () => print('onTap')
                    // launch('https://github.com/Lyokone/flutterlocation'),
                    ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    ConfigApp.myGoogleMapService.getLocation();
    ConfigApp.myGoogleMapService.listenLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: _showInfoDialog,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ConfigApp.myGoogleMapService.stopListen();
        },
      ),
      body: Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: <Widget>[
            // PermissionStatusWidget(),
            // Divider(height: 32),
            // ServiceEnabledWidget(),
            // Divider(height: 32),
            // GetLocationWidget(),
            // Divider(height: 32),
            // ListenLocationWidget()
          ],
        ),
      ),
    );
  }
}

// class ListenLocationWidget extends StatefulWidget {
//   const ListenLocationWidget({Key key}) : super(key: key);

//   @override
//   _ListenLocationState createState() => _ListenLocationState();
// }

// class _ListenLocationState extends State<ListenLocationWidget> {
//   final Location location = Location();

//   LocationData _location;
//   StreamSubscription<LocationData> _locationSubscription;
//   String _error;

//   Future<void> _listenLocation() async {
//     _locationSubscription =
//         location.onLocationChanged.handleError((dynamic err) {
//       setState(() {
//         _error = err.code;
//       });
//       _locationSubscription.cancel();
//     }).listen((LocationData currentLocation) {
//       setState(() {
//         _error = null;

//         _location = currentLocation;
//       });
//     });
//   }

//   Future<void> _stopListen() async {
//     _locationSubscription.cancel();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Text(
//           'Listen location: ' + (_error ?? '${_location ?? "unknown"}'),
//           style: Theme.of(context).textTheme.body2,
//         ),
//         Row(
//           children: <Widget>[
//             Container(
//               margin: const EdgeInsets.only(right: 42),
//               child: RaisedButton(
//                 child: const Text('Listen'),
//                 onPressed: _listenLocation,
//               ),
//             ),
//             RaisedButton(
//               child: const Text('Stop'),
//               onPressed: _stopListen,
//             )
//           ],
//         ),
//       ],
//     );
//   }
// }

// class ServiceEnabledWidget extends StatefulWidget {
//   const ServiceEnabledWidget({Key key}) : super(key: key);

//   @override
//   _ServiceEnabledState createState() => _ServiceEnabledState();
// }

// class _ServiceEnabledState extends State<ServiceEnabledWidget> {
//   final Location location = Location();

//   bool _serviceEnabled;

//   Future<void> _checkService() async {
//     final bool serviceEnabledResult = await location.serviceEnabled();
//     setState(() {
//       _serviceEnabled = serviceEnabledResult;
//     });
//   }

//   Future<void> _requestService() async {
//     if (_serviceEnabled == null || !_serviceEnabled) {
//       final bool serviceRequestedResult = await location.requestService();
//       setState(() {
//         _serviceEnabled = serviceRequestedResult;
//       });
//       if (!serviceRequestedResult) {
//         return;
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Text('Service enabled: ${_serviceEnabled ?? "unknown"}',
//             style: Theme.of(context).textTheme.body2),
//         Row(
//           children: <Widget>[
//             Container(
//               margin: const EdgeInsets.only(right: 42),
//               child: RaisedButton(
//                 child: const Text('Check'),
//                 onPressed: _checkService,
//               ),
//             ),
//             RaisedButton(
//               child: const Text('Request'),
//               onPressed: _serviceEnabled == true ? null : _requestService,
//             )
//           ],
//         )
//       ],
//     );
//   }
// }

// class PermissionStatusWidget extends StatefulWidget {
//   const PermissionStatusWidget({Key key}) : super(key: key);

//   @override
//   _PermissionStatusState createState() => _PermissionStatusState();
// }

// class _PermissionStatusState extends State<PermissionStatusWidget> {
//   final Location location = Location();

//   PermissionStatus _permissionGranted;

//   Future<void> _checkPermissions() async {
//     final PermissionStatus permissionGrantedResult =
//         await location.hasPermission();
//     setState(() {
//       _permissionGranted = permissionGrantedResult;
//     });
//   }

//   Future<void> _requestPermission() async {
//     if (_permissionGranted != PermissionStatus.granted) {
//       final PermissionStatus permissionRequestedResult =
//           await location.requestPermission();
//       setState(() {
//         _permissionGranted = permissionRequestedResult;
//       });
//       if (permissionRequestedResult != PermissionStatus.granted) {
//         return;
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Text(
//           'Permission status: ${_permissionGranted ?? "unknown"}',
//           style: Theme.of(context).textTheme.body2,
//         ),
//         Row(
//           children: <Widget>[
//             Container(
//               margin: const EdgeInsets.only(right: 42),
//               child: RaisedButton(
//                 child: const Text('Check'),
//                 onPressed: _checkPermissions,
//               ),
//             ),
//             RaisedButton(
//               child: const Text('Request'),
//               onPressed: _permissionGranted == PermissionStatus.granted
//                   ? null
//                   : _requestPermission,
//             )
//           ],
//         )
//       ],
//     );
//   }
// }

// class GetLocationWidget extends StatefulWidget {
//   const GetLocationWidget({Key key}) : super(key: key);

//   @override
//   _GetLocationState createState() => _GetLocationState();
// }

// class _GetLocationState extends State<GetLocationWidget> {
//   final Location location = Location();

//   LocationData _location;
//   String _error;

//   Future<void> _getLocation() async {
//     setState(() {
//       _error = null;
//     });
//     try {
//       final LocationData _locationResult = await location.getLocation();
//       setState(() {
//         _location = _locationResult;
//       });
//     } on PlatformException catch (err) {
//       setState(() {
//         _error = err.code;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Text(
//           'Location: ' + (_error ?? '${_location ?? "unknown"}'),
//           style: Theme.of(context).textTheme.body2,
//         ),
//         Row(
//           children: <Widget>[
//             RaisedButton(
//               child: const Text('Get'),
//               onPressed: _getLocation,
//             )
//           ],
//         ),
//       ],
//     );
//   }
// }
