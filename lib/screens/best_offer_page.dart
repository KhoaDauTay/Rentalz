import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:mobile_final/models/place_model.dart';
import 'package:mobile_final/screens/place_detail_page.dart';

class BestOffer extends StatelessWidget {
  final PlaceModel placeModel;
  BestOffer({required this.placeModel});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PlaceDetail(placeModel: placeModel)));
      },
      child: Container(
        height: 220,
        width: 380,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              Hero(
                tag: placeModel.title,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image(
                    height: 190,
                    width: 120,
                    fit: BoxFit.cover,
                    image: AssetImage(placeModel.imagePath),
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
                      height: 12,
                    ),
                    Text(
                      placeModel.title,
                      style: textTheme.headline6,
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      placeModel.details,
                      style: textTheme.bodyText1!.apply(color: Colors.black45),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Flexible(
                        child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Container(
                            height: 30,
                            width: 50,
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
                            width: 50,
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
                            width: 50,
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
                    )),
                    SizedBox(
                      height: 12,
                    ),
                    RichText(
                      text: TextSpan(
                          text: "\$ ${placeModel.rent} / ",
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
