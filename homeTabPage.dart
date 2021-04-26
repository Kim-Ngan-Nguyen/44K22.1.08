import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:drivers_app/AllScreens/registerationScreen.dart';
import 'package:drivers_app/Assistants/assistantMethods.dart';
import 'package:drivers_app/Models/Garage.dart';
import 'package:drivers_app/Models/drivers.dart';
import 'package:drivers_app/Notifications/pushNotificationService.dart';
import 'package:drivers_app/configMaps.dart';
import 'package:drivers_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeTabPage extends StatefulWidget {
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController newGoogleMapController;

  var geoLocator = Geolocator();

  // Create near garage icon
  BitmapDescriptor nearByIcon;

  Color garageStatusColor = Colors.blueGrey;

  bool isGarageAvailable =
      garageInformation.status == "avaiable" ? true : false;

  String garageStatusText = "Offline Now - Go Online";

  List<Garage> lstGarage = [];

  Set<Marker> markersSet = {};
  Set<Circle> circlesSet = {};

  @override
  void initState() {
    super.initState();
  }

  void getAllLocationOfAnotherGarage() {
    List<Garage> tempData = [];
    garageRef.once().then((DataSnapshot dataSnapShot) {
      if (dataSnapShot != null) {
        Map<dynamic, dynamic> values = dataSnapShot.value;
        values.forEach((key, values) {
          tempData.add(new Garage(
              id: key,
              email: values["email"],
              nameOfGarage: values["nameOfGarage"],
              phone: values["phone"],
              status: values["status"],
              longtitude: values["location"]["longtitude"].toString(),
              latitude: values["location"]["latitude"].toString()));
        });

        // Get another garage
        tempData.forEach((element) {
          if (element.id != currentfirebaseUser.uid) {
            lstGarage.add(element);
          }
        });
        // Update on google map
        updateAvailableGarageOnMap();
      }
    });
  }

  void getCurrentGarageInfo() {
    garageRef
        .child(currentfirebaseUser.uid)
        .once()
        .then((DataSnapshot snapshot) {
      if (snapshot != null) {
        garageInformation = Garage.fromSnapshot(snapshot);
        // Get current
        locatePosition();

        // Get posotion of Another garage
        getAllLocationOfAnotherGarage();
      }
    });
  }

  void updateAvailableGarageOnMap() {
    setState(() {
      markersSet.clear();
    });

    Set<Marker> tMakers = Set<Marker>();
    for (Garage garage in lstGarage) {
      LatLng driverAvaiablePosition = LatLng(
          double.parse(garage.latitude), double.parse(garage.longtitude));

      Marker marker = Marker(
        markerId: MarkerId('driver${garage.id}'),
        position: driverAvaiablePosition,
        icon: nearByIcon,
        rotation: AssistantMethods.createRandomNumber(360),
      );

      tMakers.add(marker);
    }
    setState(() {
      markersSet = tMakers;
    });
  }

  void createIconMarker() {
    if (nearByIcon == null) {
      ImageConfiguration imageConfiguration =
          createLocalImageConfiguration(context, size: Size(10, 2));
      BitmapDescriptor.fromAssetImage(imageConfiguration, "images/garage.png")
          .then((value) {
        nearByIcon = value;
      });
    }
  }

  void locatePosition() async {
    LatLng latLatPosition = LatLng(double.parse(garageInformation.latitude),
        double.parse(garageInformation.longtitude));

    CameraPosition cameraPosition =
        new CameraPosition(target: latLatPosition, zoom: 14);
    newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  @override
  Widget build(BuildContext context) {
    createIconMarker();
    garageStatusText =
        isGarageAvailable ? "Online Now" : "Offline Now - Go Online";
    garageStatusColor = isGarageAvailable ? Colors.green : Colors.black;

    return Stack(
      children: [
        GoogleMap(
          mapType: MapType.normal,
          myLocationButtonEnabled: true,
          initialCameraPosition: HomeTabPage._kGooglePlex,
          myLocationEnabled: true,
          markers: markersSet,
          onMapCreated: (GoogleMapController controller) {
            _controllerGoogleMap.complete(controller);
            newGoogleMapController = controller;

            // Get current position of garage
            getCurrentGarageInfo();
          },
        ),

        //online offline driver Container
        Container(
          height: 140.0,
          width: double.infinity,
          color: Colors.black87,
        ),

        Positioned(
          top: 60.0,
          left: 0.0,
          right: 0.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                // ignore: deprecated_member_use
                child: RaisedButton(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(24.0),
                  ),
                  onPressed: () {
                    if (isGarageAvailable != true) {
                      makeDriverOnlineNow();
                      setState(() {
                        garageStatusColor = Colors.green;
                        garageStatusText = "Online Now ";
                        isGarageAvailable = true;
                      });
                      displayToastMessage("you are Online Now.", context);
                    } else {
                      makeDriverOfflineNow();

                      setState(() {
                        garageStatusColor = Colors.black;
                        garageStatusText = "Offline Now - Go Online ";
                        isGarageAvailable = false;
                      });

                      displayToastMessage("you are Offline Now.", context);
                    }
                  },
                  color: garageStatusColor,
                  child: Padding(
                    padding: EdgeInsets.all(17.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          garageStatusText,
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Icon(
                          Icons.phone_android,
                          color: Colors.white,
                          size: 26.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void makeDriverOnlineNow() async {
    garageRef.child(currentfirebaseUser.uid).child("status").set("avaiable");
  }

  void makeDriverOfflineNow() {
    garageRef.child(currentfirebaseUser.uid).child("status").set("waiting");
  }
}
