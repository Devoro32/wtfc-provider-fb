// import 'dart:async';

import 'package:wtfc_provider_app/export.dart';

//https://youtu.be/BqCEkBkbnQA

//!https://medium.com/@emrnel/solution-for-your-project-requires-a-newer-version-of-the-kotlin-gradle-plugin-error-3125f332c224
//1. Need to add the google key
//2.update android/app/src/build.gradle
//3. enabled location package within androidmanifest....see pub.dev
//!Disable because the map is loading a lot of data that the emulator cannot process
/*

class CLMapScreen extends StatefulWidget {
  const CLMapScreen({super.key});

  @override
  State<CLMapScreen> createState() => _CLMapScreenState();
}

class _CLMapScreenState extends State<CLMapScreen> {
  final Location _location = Location();
  static LatLng _currentLocation = const LatLng(51.5081402, -0.2732607);
  static const LatLng _sourceLocation = LatLng(51.492908, -0.225790);
  static const LatLng _destinationLocation = LatLng(51.515968, -0.237460);

  Completer<GoogleMapController> _gMapController =
      Completer<GoogleMapController>();

  Map<PolylineId, Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    _getCurrentLocation().then((_) => {
          _getPolylinePoints().then((coordinates) => {
                _createPolyLines(coordinates),
              })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        //Core google map
        child: GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            _gMapController.complete(controller);
          },
          initialCameraPosition: CameraPosition(
            target: _currentLocation,
            zoom: 12,
          ),
          markers: _createMarkers(),
          polylines: Set<Polyline>.of(_polylines.values),
        ),
      ),
    );
  }

//Set the marker on Google map
  Set<Marker> _createMarkers() {
    Set<Marker> markers = {
      Marker(
        //? Need to give each marker, their own ID
        markerId: const MarkerId('Current/Initial_Position'),
        position: _currentLocation,
      ),
      Marker(
        markerId: const MarkerId('Current/Source_Position'),
        position: _sourceLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ),
      Marker(
        markerId: const MarkerId('Current/destination_Position'),
        position: _destinationLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ),
    };

    return markers;
  }

  //get current location
  Future<void> _getCurrentLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

//ensure that permission is granted
    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    //Check if the location has changed on Google map, i.e rather than my locoation, you set a different start location
    _location.onLocationChanged.listen((LocationData currentLocation) {
      setState(() {
        _currentLocation = LatLng(
          _currentLocation.latitude,
          _currentLocation.longitude,
        );
        moveCamera(_currentLocation);
      });
    });
  }

//move Camera
  Future<void> moveCamera(LatLng position) async {
    final GoogleMapController controller = await _gMapController.future;

    CameraPosition newCameraPosition =
        CameraPosition(target: position, zoom: 12);
    controller.animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
  }

  //get the start and end polyline points
  Future<List<LatLng>> _getPolylinePoints() async {
    List<LatLng> coordinate = [];
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      Google_API_Key,
      PointLatLng(
        _sourceLocation.latitude,
        _sourceLocation.longitude,
      ),
      PointLatLng(
        _destinationLocation.latitude,
        _destinationLocation.longitude,
      ),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        coordinate.add(
          LatLng(point.latitude, point.longitude),
        );
      });
    }
    return coordinate;
  }

  //create polylines
  void _createPolyLines(List<LatLng> coordinates) {
    PolylineId id = PolylineId('polyline');
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: coordinates,
      width: 4,
    );

    setState(() {
      _polylines[id] = polyline;
    });
  }
}

*/

class CLMapScreen extends StatefulWidget {
  const CLMapScreen({super.key});

  @override
  State<CLMapScreen> createState() => _CLMapScreenState();
}

class _CLMapScreenState extends State<CLMapScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
