import 'package:flutter/material.dart';
import 'package:mobile_final/core/services/api_service.dart';
import 'package:mobile_final/models/house_model.dart';

import '../../search_house_page.dart';
import 'house/house_card.dart';

class ListHouseAdmin extends StatefulWidget {
  const ListHouseAdmin({Key? key}) : super(key: key);

  @override
  _ListHouseAdminState createState() => _ListHouseAdminState();
}

class _ListHouseAdminState extends State<ListHouseAdmin> {
  late List<House> houses;
  final _api = API();
  bool isSuccess = false;
  Future getData() async {
    var result = await _api.getHouses();
    if (result["status"]) {
      setState(() {
        houses = result["houses"];
        isSuccess = true;
      });
    } else {
      setState(() {
        isSuccess = false;
      });
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  void _deleteHouse(String name) {
    setState(() {
      houses.removeWhere((tx) => tx.name == name);
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
                  showSearch(
                      context: context, delegate: SearchHouse(_deleteHouse));
                },
                icon: Icon(Icons.search_sharp),
              )
            ],
          ),
          body: Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: isSuccess
                ? ListView.builder(
                    itemCount: houses.length,
                    itemBuilder: (context, index) {
                      return HouseCard(
                        house: houses[index],
                        deleteHouse: _deleteHouse,
                      );
                    })
                : Center(
                    child: Text("Failed load data from server"),
                  ),
          )),
    );
  }
}
