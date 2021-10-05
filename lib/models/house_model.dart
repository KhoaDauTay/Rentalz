import 'dart:ffi';

class House {
  String name;
  String address;
  String propertyTypes;
  String bedRoom;
  String createAt;
  String reporter;
  double rent;
  // Optional
  late int id;
  late String furnitureTypes;
  late String notes;
  late String image;
  bool isLiked = false;
  bool isBestOffer = false;
  House(
      {required this.name,
      required this.address,
      required this.propertyTypes,
      required this.bedRoom,
      required this.rent,
      required this.reporter,
      required this.createAt});

  factory House.fromJson(Map<String, dynamic> json) {
    var house = House(
        name: json["name"],
        address: json["address"],
        propertyTypes: json['property'],
        bedRoom: json['bed_rooms'],
        reporter: json['name_reporter'],
        rent: double.parse(json['rent']),
        createAt: json["create_at"]);
    house.furnitureTypes = "";
    house.notes = "";
    if (json["furniture"] != "") {
      house.furnitureTypes = json["furniture"];
    }
    if (json["notes"] != "") {
      house.notes = json["notes"];
    }
    if (json["is_best_offer"]) {
      house.isBestOffer = true;
    }
    house.image = json["image"];
    house.id = json["id"];
    return house;
  }

  Map toJson() => {
        "name": name,
        "address": address,
        "property": propertyTypes.toLowerCase(),
        "bed_rooms": bedRoom.toLowerCase(),
        "create_at": createAt,
        "rent": rent,
        "furniture": furnitureTypes.toLowerCase(),
        "notes": notes,
        "image": null,
        "name_reporter": reporter,
        "reporter": null,
        "is_best_offer": isBestOffer
      };
}
