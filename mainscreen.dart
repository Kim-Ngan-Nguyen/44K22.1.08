import 'dart:async';

import 'package:flashapp/AllScreens/Divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MainScreen extends StatefulWidget {
  static const String idScreen = "mainScreen";
  @override
  _MainScreenState createState() => _MainScreenState();
}


class _MainScreenState extends State<MainScreen>
{
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController newGoogleMapController;
  static final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962),
      zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Screen"),
      ),
      drawer: Container(
        color: Colors.white,
        width: 255.0,
        child: Drawer(
          child: ListView(
            children: [
              Container(
                height: 155.0,
                child: DrawerHeader(
                  decoration: BoxDecoration(color: Colors.white),
                  child:Row(
                    children: [
                      Image.asset("images/user_icon.png",height:45.0 ,width:45.0 ,),
                      SizedBox(width:14.0 ,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Profile Name", style: TextStyle(fontSize: 16.0, fontFamily: "Brand-Bold"),),
                          SizedBox(height: 5.0,),
                          Text("Visit Profile"),
                        ],
                      ),
                    ],
                  ) ,
                ),
              ),

              DividerWidget(),
              SizedBox(height:10.0 ,),

              ListView(
                leading: Icon(Icons.history),

              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller)
            {
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;
            },
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0 ,
            child: Container(
              height: 240.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(18.0),topRight: Radius.circular(18.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 16.0,
                    spreadRadius: 0.5,
                    offset: Offset(0.7, 0.7),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  SizedBox(height: 6.0),
                  Text("Hi there", style: TextStyle(fontSize:12.0),),
                  Text("Where to?", style: TextStyle(fontSize:20.0, fontFamily:"Brand-Bold" ),),
                    SizedBox(height: 20.0),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 6.0,
                            spreadRadius: 0.5,
                            offset: Offset(0.7, 0.7),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          children: [
                            Icon(Icons.search, color: Colors.blue,),
                            SizedBox(width: 10.0,),
                            Text("Tìm vị trí")
                          ],
                        ),
                      )
                    ),

                    SizedBox(height: 7.0),
                    Row(
                      children: [
                        Icon(Icons.home, color: Colors.blueGrey,),
                        SizedBox(width: 5.0,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Add Home"),
                            SizedBox(height: 4.0,),
                            Text("Địa chỉ của bạn", style: TextStyle(color: Colors.black, fontSize: 12.0),),
                          ],
                        )
                      ],
                    ),

                    SizedBox(height: 7.0),
                    DividerWidget(),
                    SizedBox(height: 5.0),
                    Row(
                      children: [
                        Icon(Icons.home, color: Colors.blueGrey,),
                        SizedBox(width: 7.0,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Add Home"),
                            SizedBox(height: 4.0,),
                            Text("Địa chỉ của bạn", style: TextStyle(color: Colors.black, fontSize: 12.0),),
                          ],
                        )
                      ],
                    )
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
