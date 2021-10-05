import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:mobile_final/constants.dart';
import 'package:mobile_final/models/house_model.dart';
import 'package:mobile_final/models/place_model.dart';

class HouseDetailPage extends StatefulWidget {
  final House house;
  final PlaceModel place = placeCollection[0];
  HouseDetailPage({required this.house});

  @override
  State<HouseDetailPage> createState() => _HouseDetailPageState();
}

class _HouseDetailPageState extends State<HouseDetailPage> {
  @override
  Widget build(BuildContext context) {
    final height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final width = MediaQuery.of(context).size.width -
        MediaQuery.of(context).padding.left -
        MediaQuery.of(context).padding.right;
    final space = height > 650 ? kSpaceM : kSpaceS;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: kPaddingM, vertical: kPaddingM - 2.0),
          child: ListView(
            children: [
              Hero(
                tag: widget.house.name,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    width: width,
                    height: height / 4,
                    child: Image(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.house.image),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: space,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                      flex: 3,
                      child: Text(
                        widget.house.name,
                        style: textTheme.headline4!.apply(color: Colors.black),
                      )),
                  Flexible(
                      flex: 1,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "\$ ${widget.house.rent}",
                              style: textTheme.headline5,
                            ),
                            Text(
                              "/ Mo",
                              style: textTheme.bodyText1,
                            ),
                          ]))
                ],
              ),
              SizedBox(
                height: space,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: kPaddingS),
                    child: Container(
                      height: 30,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            FlutterIcons.bed_faw,
                            size: 16,
                          ),
                          Text("5") // TODO: Add data
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: kPaddingS),
                    child: Container(
                      height: 30,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            FlutterIcons.bath_faw,
                            size: 16,
                          ),
                          Text("3") // TODO: Add data
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: kPaddingS),
                    child: Container(
                      height: 30,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            FlutterIcons.fridge_outline_mco,
                            size: 16,
                          ),
                          Text("2") // TODO: Add data
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: space,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 16.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image(
                          width: 65,
                          fit: BoxFit.cover,
                          image: AssetImage('asset/images/avatar.jpeg'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(kPaddingS),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.house.reporter,
                              style: textTheme.caption,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Huynh Tan")
                          ],
                        ),
                      ),
                      Spacer(),
                      Container(
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Icon(
                            FlutterIcons.comment_dots_faw5s,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: space,
              ),
              Text(
                "Address: ${widget.house.address}",
                style: textTheme.headline6,
              ),
              SizedBox(
                height: space,
              ),
              Text(
                "About",
                style: textTheme.headline5,
              ),
              SizedBox(
                height: space,
              ),
              Text(
                widget.house.notes == null
                    ? "Write your notes"
                    : widget.house.notes,
                style: textTheme.subtitle1!.apply(color: Colors.black45),
              ),
              SizedBox(
                height: space,
              ),
              Text(
                "Photos",
                style: textTheme.headline5,
              ),
              Container(
                height: 250,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.place.photoCollections.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Image(
                            height: 220,
                            width: 120,
                            fit: BoxFit.cover,
                            image: AssetImage(
                                widget.place.photoCollections[index]),
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: 90,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
