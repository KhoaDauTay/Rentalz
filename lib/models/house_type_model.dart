class HouseType {
  String inside_property;
  String outside_property;
  bool have_wifi;
  int house;
  HouseType(
      {required this.inside_property,
      required this.outside_property,
      required this.have_wifi,
      required this.house});
  factory HouseType.fromJson(Map<String, dynamic> json) {
    var houseType = HouseType(
        inside_property: json["inside_property"],
        outside_property: json["outside_property"],
        have_wifi: json['have_wifi'],
        house: json['house']);
    return houseType;
  }
  Map toJson() => {
        "inside_property": inside_property,
        "outside_property": outside_property,
        "have_wifi": have_wifi,
        "house": house,
      };
}
