import 'package:flutter/material.dart';
import 'package:mobile_final/core/services/api_service.dart';
import 'package:mobile_final/models/house_model.dart';
import 'package:mobile_final/screens/admin/house/house_detail_page.dart';
import '../../constants.dart';

class SearchClient extends SearchDelegate {
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
                return HouseCardClientSearch(
                  house: data![index],
                );
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

class HouseCardClientSearch extends StatelessWidget {
  final House house;
  HouseCardClientSearch({required this.house});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final space = (height > 650 ? kSpaceM : kSpaceS) - 8.0;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HouseDetailPage(house: house)));
      },
      child: Container(
        height: height.toInt() / 6,
        width: height.toInt() / 10,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Padding(
          padding: const EdgeInsets.all(kPaddingS),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Hero(
                tag: house.name,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image(
                    height: height.toInt() / 10,
                    width: height.toInt() / 8,
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        house.image == null ? image_default : house.image),
                  ),
                ),
              ),
              SizedBox(
                width: space + 5,
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: space,
                    ),
                    Text(
                      house.name,
                      style: textTheme.headline5,
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      house.address,
                      style: textTheme.bodyText1!.apply(color: Colors.black45),
                    ),
                    SizedBox(
                      height: space,
                    ),
                    RichText(
                      text: TextSpan(
                          text: "\$ ${house.rent} / ",
                          style: textTheme.headline6,
                          children: <TextSpan>[
                            TextSpan(
                                text: "Mo",
                                style: DefaultTextStyle.of(context).style)
                          ]),
                    ),
                    SizedBox(
                      height: space,
                    ),
                    Text(
                      "Reporter: " + house.reporter,
                      style: textTheme.bodyText1!.apply(color: Colors.black),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: space,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
