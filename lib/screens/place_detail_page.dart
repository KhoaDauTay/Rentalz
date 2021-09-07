import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:mobile_final/constants/colors.dart';
import 'package:mobile_final/models/place_model.dart';

class PlaceDetail extends StatelessWidget {
  final PlaceModel placeModel;

  PlaceDetail({required this.placeModel});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          child: ListView(
            children: [
              Hero(
                tag: placeModel.title,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image(
                    fit: BoxFit.cover,
                    image: AssetImage(placeModel.imagePath),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                      flex: 3,
                      child: Text(
                        placeModel.title,
                        style: textTheme.headline4!.apply(color: Colors.black),
                      )),
                  Flexible(
                      flex: 1,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "\$ ${placeModel.rent}",
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
                height: 20,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
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
                    padding: const EdgeInsets.only(right: 8.0),
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
                    padding: const EdgeInsets.only(right: 8.0),
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
                height: 20,
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
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Khoa',
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
                height: 20,
              ),
              Text(
                "About",
                style: textTheme.headline5,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris lobortis euismod magna ac ultricies. Nunc nec tristique tellus, non iaculis massa. Proin et eleifend mi, ac scelerisque ex. Vivamus eu ultricies enim. Suspendisse potenti. Aliquam orci libero, rhoncus molestie tellus a, scelerisque fringilla sem.",
                style: textTheme.subtitle1!.apply(color: Colors.black45),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Photos",
                style: textTheme.headline5,
              ),
              Container(
                height: 250,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: placeModel.photoCollections.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Image(
                            height: 220,
                            width: 120,
                            fit: BoxFit.cover,
                            image:
                                AssetImage(placeModel.photoCollections[index]),
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
