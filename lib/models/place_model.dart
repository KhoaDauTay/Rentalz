import 'package:flutter/material.dart';

class PlaceModel {
  String propertyTypes;
  String bedRoom;
  DateTime createAt;
  late String furnitureTypes;
  late String notes;
  String reporter;

  String title, details;
  int rent;
  String imagePath;
  List<String> photoCollections = [
    "asset/images/image1.jpg",
    "asset/images/image2.jpg",
    "asset/images/image3.jpg",
    "asset/images/image4.jpg",
    "asset/images/image5.jpg",
    "asset/images/image6.jpg",
    "asset/images/image7.jpg",
    "asset/images/image8.jpg",
    "asset/images/image9.jpg",
  ];
  PlaceModel({
    required this.title,
    required this.details,
    required this.rent,
    required this.imagePath,
    required this.propertyTypes,
    required this.bedRoom,
    required this.createAt,
    required this.reporter,
  });
}

List<PlaceModel> placeCollection = [
  PlaceModel(
      title: "The Coach House",
      details: "4 College Court Holyoke, MA",
      rent: 1500,
      imagePath: "asset/images/image1.jpg",
      propertyTypes: "house",
      bedRoom: "20",
      createAt: DateTime.now(),
      reporter: "Khoa"),
  PlaceModel(
      title: "Wheenwright Cottage",
      details: "221 Filmore St, Princetone, IA",
      rent: 1400,
      imagePath: "asset/images/image4.jpg",
      propertyTypes: "house",
      bedRoom: "20",
      createAt: DateTime.now(),
      reporter: "Khoa"),
  PlaceModel(
      title: "La Vie est Belle VN",
      details: "4 College Court Holyoke, MA",
      rent: 1800,
      imagePath: "asset/images/image5.jpg",
      propertyTypes: "house",
      bedRoom: "20",
      createAt: DateTime.now(),
      reporter: "Khoa"),
  PlaceModel(
      title: "The Old Vicarage",
      details: "4 College Court Holyoke, MA",
      rent: 1200,
      imagePath: "asset/images/image7.jpg",
      propertyTypes: "house",
      bedRoom: "20",
      createAt: DateTime.now(),
      reporter: "Khoa"),
];
