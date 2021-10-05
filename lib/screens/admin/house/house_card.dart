import 'package:flutter/material.dart';
import 'package:mobile_final/core/services/api_service.dart';
import 'package:mobile_final/models/house_model.dart';

import '../../../constants.dart';
import 'house_detail_page.dart';

class HouseCard extends StatelessWidget {
  final House house;
  API _api = API();
  Function deleteHouse;
  HouseCard({required this.house, required this.deleteHouse});

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
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red, size: 30),
                onPressed: () async {
                  showDialog(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) => AlertDialog(
                            title: const Text('Confirm your\'s action'),
                            content: SingleChildScrollView(
                              child: Center(
                                child: ListBody(
                                  children: [
                                    const Text(
                                      "Check your house's data: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18),
                                    ),
                                    Text(house.name),
                                    Text(house.address),
                                    Text(house.propertyTypes),
                                    Text(house.bedRoom),
                                    Text(house.rent.toString()),
                                    Text(house.reporter),
                                    Text(house.createAt),
                                    Text(house.notes),
                                    Text(house.furnitureTypes),
                                  ],
                                ),
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancel'),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  var isDeleted = await _api.deleteHouse(house);
                                  if (isDeleted) {
                                    deleteHouse(house.name);
                                  }
                                  Navigator.pop(context, 'OK');
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
