import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:mobile_final/models/house_model.dart';
import 'package:mobile_final/screens/admin/house/house_detail_page.dart';

import '../../constants.dart';

class BestOffer extends StatelessWidget {
  final House house;
  BestOffer({required this.house});

  @override
  Widget build(BuildContext context) {
    final height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final width = MediaQuery.of(context).size.width -
        MediaQuery.of(context).padding.left -
        MediaQuery.of(context).padding.right;
    final space = height > 650 ? kSpaceM : kSpaceS;
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HouseDetailPage(house: house)));
      },
      child: Container(
        height: height / 4,
        width: width - 20,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              Hero(
                tag: house.name,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image(
                    height: height / 2 - 60,
                    width: width / 2.5,
                    fit: BoxFit.cover,
                    image: NetworkImage(house.image),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
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
                      style: textTheme.headline6,
                    ),
                    SizedBox(
                      height: space,
                    ),
                    Text(
                      house.address,
                      style: textTheme.bodyText1!.apply(color: Colors.black45),
                    ),
                    SizedBox(
                      height: space,
                    ),
                    height > 650
                        ? Flexible(
                            child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: (space - 7)),
                                child: Container(
                                  height: height / 20,
                                  width: width / 8,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        FlutterIcons.bed_faw,
                                        size: space + 4,
                                      ),
                                      Text("5") // TODO: Add data
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: (space - 7)),
                                child: Container(
                                  height: height / 20,
                                  width: width / 8,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        FlutterIcons.bath_faw,
                                        size: space + 4,
                                      ),
                                      Text("3") // TODO: Add data
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: (space - 7)),
                                child: Container(
                                  height: height / 20,
                                  width: width / 8,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        FlutterIcons.fridge_outline_mco,
                                        size: space + 4,
                                      ),
                                      Text("2") // TODO: Add data
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ))
                        : SizedBox(
                            height: 1,
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
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
