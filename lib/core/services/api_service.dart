import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_final/models/house_model.dart';
import 'package:mobile_final/models/house_type_model.dart';
import 'package:mobile_final/models/user_model.dart';

import '../../constants.dart';

class API {
  final http.Client httpClient = http.Client();
  final storage = FlutterSecureStorage();
  Future signUp(Map body) async {
    final String path = "$API_URL/auth/sign-up/";
    final Uri uri = Uri.parse(path);

    http.Response response = await httpClient.post(uri,
        headers: {
          "Content-type": "application/json;charset=UTF-8",
          "Accept": "application/json"
        },
        body: jsonEncode(body));
    if (response.statusCode == 201) {
      var data = json.decode(response.body);
      var result = {
        "message": data["message"],
        "username": data["username"],
        "status": true
      };
      return result;
    } else {
      var result = {
        "message": "Sign up is not completed, try again",
        "status": false
      };
      return result;
    }
  }

  Future login(Map body) async {
    final String path = "$API_URL/auth/login/";
    final Uri uri = Uri.parse(path);

    http.Response response = await httpClient.post(uri,
        headers: {
          "Content-type": "application/json;charset=UTF-8",
          "Accept": "application/json"
        },
        body: jsonEncode(body));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var user = User.fromJson(data);
      var result = {
        "user": user,
        "message": "Login successfully",
        "status": true
      };
      return result;
    } else {
      var data = json.decode(response.body);
      var result = {"message": data["detail"], "status": false};
      return result;
    }
  }

  Future getHouses() async {
    final String path = "$API_URL/api/houses/";
    final Uri uri = Uri.parse(path);
    http.Response response =
        await httpClient.get(uri, headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      var result = {
        "status": true,
        "houses": data.map((house) => House.fromJson(house)).toList()
      };
      return result;
    } else {
      return {"status": false, "message": "Failed load data from server"};
    }
  }

  Future<List<House>> finHouse(String query) async {
    final String path = "$API_URL/api/houses/";
    final Uri uri = Uri.parse(path);
    http.Response response =
        await httpClient.get(uri, headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      var results = data.map((e) => House.fromJson(e)).toList();
      results = results
          .where((element) =>
              element.name.toLowerCase().contains((query.toLowerCase())))
          .toList();
      return results;
    } else {
      return [];
    }
  }

  Future createHouses(House house) async {
    final String path = "$API_URL/api/houses/";
    final Uri uri = Uri.parse(path);
    http.Response response = await httpClient.post(uri,
        headers: {
          "Content-type": "application/json;charset=UTF-8",
          "Accept": "application/json"
        },
        body: json.encode(house.toJson()));
    if (response.statusCode == 201) {
      var data = json.decode(response.body);
      var house = House.fromJson(data);
      var result = {
        "status": true,
        "house": house,
      };
      return result;
    } else {
      var result = {
        "status": false,
        "messages": "Create House failed, try again"
      };
      return result;
    }
  }

  Future<bool> findHouse(String name) async {
    final String path = "$API_URL/api/houses/?name=$name";
    final Uri uri = Uri.parse(path);
    http.Response response = await httpClient.get(
      uri,
      headers: {
        "Content-type": "application/json;charset=UTF-8",
        "Accept": "application/json"
      },
    );
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      var result = data.map((house) => House.fromJson(house)).toList();
      if (result.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future createHouseType(HouseType houseType) async {
    final String path = "$API_URL/api/houses/house-types/";
    final Uri uri = Uri.parse(path);
    http.Response response = await httpClient.post(uri,
        headers: {
          "Content-type": "application/json;charset=UTF-8",
          "Accept": "application/json"
        },
        body: json.encode(houseType.toJson()));
    if (response.statusCode == 201) {
      var data = json.decode(response.body);
      var result = {
        "status": true,
        "house": HouseType.fromJson(data),
      };
      return result;
    } else {
      var result = {
        "status": false,
        "messages": "Create House Type failed, try again"
      };
      return result;
    }
  }

  Future<String> uploadPhoto(String path, House house) async {
    Uri uri = Uri.parse('$API_URL/api/houses/${house.id}/upload-photo/');
    http.MultipartRequest request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath('file', path));

    http.StreamedResponse response = await request.send();
    var responseBytes = await response.stream.toBytes();
    var responseString = utf8.decode(responseBytes);
    return responseString;
  }

  Future<bool> deleteHouse(House house) async {
    final String path = "$API_URL/api/houses/${house.id}/";
    final Uri uri = Uri.parse(path);
    http.Response response = await httpClient.delete(uri,
        headers: {
          "Content-type": "application/json;charset=UTF-8",
          "Accept": "application/json"
        },
        body: json.encode(house.toJson()));
    if (response.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }

  Future getClientHouses() async {
    final String path = "$API_URL/api/houses/client/get-houses";
    final Uri uri = Uri.parse(path);
    http.Response response =
        await httpClient.get(uri, headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List bestOffer = data["best_offer"];
      List recent = data["recent"];
      List<House> resultBestOffer =
          bestOffer.map((house) => House.fromJson(house)).toList();
      List<House> resultRecent =
          recent.map((house) => House.fromJson(house)).toList();
      var result = {
        "status": true,
        "recent": resultRecent,
        "best_offer": resultBestOffer
      };
      return result;
    } else {
      return {"status": false, "message": "Failed load data from server"};
    }
  }

  Future<bool> addBookMark(House house) async {
    String? userId = await storage.read(key: "user_id");
    final String path = "$API_URL/api/users/$userId/add-favorite/${house.id}";
    final Uri uri = Uri.parse(path);
    http.Response response = await httpClient.get(
      uri,
      headers: {
        "Content-type": "application/json;charset=UTF-8",
        "Accept": "application/json"
      },
    );
    if (response.statusCode == 200) {
      String? bookMarks = await storage.read(key: "bookmark");
      List book_mark_house = json.decode(bookMarks!);
      book_mark_house.add(house.id);
      await storage.write(key: "bookmark", value: book_mark_house.toString());
      return true;
    } else {
      return false;
    }
  }

  Future<bool> removeBookMark(House house) async {
    String? userId = await storage.read(key: "user_id");
    final String path =
        "$API_URL/api/users/$userId/remove-favorite/${house.id}";
    final Uri uri = Uri.parse(path);
    http.Response response = await httpClient.get(
      uri,
      headers: {
        "Content-type": "application/json;charset=UTF-8",
        "Accept": "application/json"
      },
    );
    if (response.statusCode == 200) {
      String? bookMarks = await storage.read(key: "bookmark");
      List book_mark_house = json.decode(bookMarks!);
      book_mark_house.remove(house.id);
      await storage.write(key: "bookmark", value: book_mark_house.toString());
      return true;
    } else {
      return false;
    }
  }
}
