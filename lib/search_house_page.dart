import 'package:flutter/material.dart';
import 'package:mobile_final/models/house_model.dart';
import 'package:mobile_final/screens/admin/house/house_card.dart';
import 'package:mobile_final/screens/client/house_card_client.dart';

import 'core/services/api_service.dart';

class SearchHouse extends SearchDelegate {
  final Function deleteHouse;
  SearchHouse(this.deleteHouse);
  API _api = API();
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<House>>(
        future: _api.finHouse(query),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<House>? data = snapshot.data;
          return ListView.builder(
              itemCount: data?.length,
              itemBuilder: (context, index) {
                return HouseCard(house: data![index], deleteHouse: deleteHouse);
              });
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text('Search House'),
    );
  }
}
