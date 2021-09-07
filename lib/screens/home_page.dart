import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:mobile_final/constants/colors.dart';
import 'package:mobile_final/models/place_model.dart';
import 'package:mobile_final/screens/best_offer_page.dart';
import 'package:mobile_final/screens/recent_added_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        FlutterIcons.th_large_faw,
                        color: kCustomBlackColor,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: const Image(
                          width: 52,
                          height: 52,
                          fit: BoxFit.cover,
                          image: AssetImage('asset/images/avatar.jpeg'),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              SearchArea(),
              const SizedBox(
                height: 50,
              ),
              RencentAddedSection(textTheme: textTheme),
              Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Todays Best Offer",
                      style: textTheme.headline5,
                    ),
                    const Text(
                      "See all",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                BestOffer(placeModel: placeCollection[3])
              ]),
              const SizedBox(
                height: 90,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RencentAddedSection extends StatelessWidget {
  const RencentAddedSection({
    Key? key,
    required this.textTheme,
  }) : super(key: key);

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Recently Added",
              style: textTheme.headline5,
            ),
            const Text(
              "See all",
              style: TextStyle(
                color: Colors.grey,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 350,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              RecentAdded(placeModel: placeCollection[0]),
              RecentAdded(placeModel: placeCollection[1])
            ],
          ),
        ),
      ],
    );
  }
}

class SearchArea extends StatelessWidget {
  const SearchArea({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(24),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                      prefixIcon: const Icon(FlutterIcons.magnify_mco),
                      border: InputBorder.none,
                      hintText: "Search",
                      hintStyle: TextStyle(color: Colors.grey[800]),
                      fillColor: const Color(0xffF3F4F8)),
                ),
              ),
            )),
        Flexible(
            flex: 1,
            child: Container(
              height: 65,
              width: 65,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Icon(
                FlutterIcons.sliders_h_faw5s,
                color: Colors.grey[300],
              ),
            ))
      ],
    );
  }
}
