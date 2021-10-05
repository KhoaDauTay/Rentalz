import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_final/core/services/api_service.dart';
import 'package:mobile_final/models/house_model.dart';
import 'package:mobile_final/screens/client/house_card_client.dart';
import 'package:mobile_final/screens/client/search_client.dart';

class ListHouseClient extends StatefulWidget {
  final List<House> houses;
  const ListHouseClient({required this.houses});

  @override
  _ListHouseClientState createState() => _ListHouseClientState(houses: houses);
}

class _ListHouseClientState extends State<ListHouseClient> {
  final List<House> houses;
  final storage = FlutterSecureStorage();
  _ListHouseClientState({required this.houses});
  getData() async {
    String? bookMarks = await storage.read(key: "bookmark");
    List book_mark_house = json.decode(bookMarks!);
    setState(() {
      if (book_mark_house != null) {
        for (var house in houses) {
          if (book_mark_house.contains(house.id)) {
            house.isLiked = true;
          }
        }
      }
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  void addHouse() {
    setState(() {
      getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('House List'),
            actions: [
              IconButton(
                onPressed: () {
                  setState(() {
                    getData();
                  });
                  showSearch(context: context, delegate: SearchClient());
                },
                icon: Icon(Icons.search_sharp),
              )
            ],
          ),
          body: Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: houses.isNotEmpty
                ? ListView.builder(
                    itemCount: houses.length,
                    itemBuilder: (context, index) {
                      return HouseCardClient(
                        house: houses[index],
                        addHouse: addHouse,
                        removeHouse: null,
                      );
                    })
                : Center(
                    child: Column(
                      children: [
                        Text("Failed load data from server"),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(onSurface: Colors.red),
                          onPressed: () {
                            initState();
                          },
                          child: Text('Reload'),
                        )
                      ],
                    ),
                  ),
          )),
    );
  }
}
