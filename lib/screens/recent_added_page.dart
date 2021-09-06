import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:mobile_final/models/place_model.dart';

class RecentAdded extends StatelessWidget {
  final PlaceModel placeModel;
  RecentAdded({required this.placeModel});
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 14),
      child: Container(
        height: 300,
        width: 250,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Color(0xffD6D6D6), width: 1.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  child: Image(image: AssetImage(placeModel.imagePath)),
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: GlassContainer(
                      height: 40,
                      width: 150,
                      blur: 5,
                      opacity: 0.5,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24),
                      ),
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                              text: "\$ ${placeModel.rent} / ",
                              style: textTheme.headline6,
                              children: <TextSpan>[
                                TextSpan(
                                    text: "Mo",
                                    style: DefaultTextStyle.of(context).style)
                              ]),
                        ),
                      ),
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                    height: 6,
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
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
