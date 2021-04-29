import 'package:firebase_database/firebase_database.dart';

class Garage {
  String id;
  String email;
  String nameOfGarage;
  String phone;
  String status;
  String latitude;
  String longtitude;

  Garage(
      {this.email,
      this.phone,
      this.nameOfGarage,
      this.id,
      this.latitude,
      this.status,
      this.longtitude});

  Garage.fromSnapshot(DataSnapshot dataSnapshot) {
    id = dataSnapshot.key;
    phone = dataSnapshot.value["phone"];
    email = dataSnapshot.value["email"];
    nameOfGarage = dataSnapshot.value["nameOfGarage"];
    status = dataSnapshot.value["status"];
    latitude = dataSnapshot.value["location"]["latitude"].toString();
    longtitude = dataSnapshot.value["location"]["longtitude"].toString();
  }
}
