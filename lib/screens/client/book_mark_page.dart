import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_final/core/services/api_service.dart';
import 'package:mobile_final/models/house_model.dart';
import 'package:mobile_final/screens/client/house_card_client.dart';

import '../../search_house_page.dart';

class BookMarkPage extends StatefulWidget {
  const BookMarkPage({Key? key}) : super(key: key);

  @override
  _BookMarkPageState createState() => _BookMarkPageState();
}

class _BookMarkPageState extends State<BookMarkPage>
    with AutomaticKeepAliveClientMixin<BookMarkPage> {
  late List<House> houses;
  final _api = API();
  final storage = FlutterSecureStorage();
  bool isSuccess = false;
  Future getData() async {
    var result = await _api.getHouses();
    String? bookMarks = await storage.read(key: "bookmark");
    List book_mark_house = json.decode(bookMarks!);
    if (book_mark_house != null) {
      if (result["status"]) {
        setState(() {
          houses = result["houses"];
          houses = houses
              .where((element) => book_mark_house.contains(element.id))
              .toList();
          for (var house in houses) {
            house.isLiked = true;
          }
          isSuccess = true;
        });
      } else {
        setState(() {
          isSuccess = false;
        });
      }
    }
  }

  void _deleteHouse(String name) {
    setState(() {
      houses.removeWhere((tx) => tx.name == name);
    });
  }

  void addHouse() {
    setState(() {
      getData();
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('Book Mark'),
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      getData();
                    });
                  },
                  icon: Icon(Icons.build))
            ],
          ),
          body: Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: isSuccess
                ? ListView.builder(
                    itemCount: houses.length,
                    itemBuilder: (context, index) {
                      return HouseCardClient(
                        house: houses[index],
                        removeHouse: _deleteHouse,
                        addHouse: addHouse,
                      );
                    })
                : Center(
                    child: Text("No House in your book mark"),
                  ),
          )),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
