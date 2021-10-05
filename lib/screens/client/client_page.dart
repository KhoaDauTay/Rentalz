import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:mobile_final/constants.dart';
import 'package:mobile_final/core/services/api_service.dart';
import 'package:mobile_final/models/house_model.dart';
import 'package:mobile_final/screens/client/list_house_client.dart';
import 'package:mobile_final/screens/client/recent_page.dart';

import 'best_offer_page_client.dart';

class ClientPage extends StatefulWidget {
  @override
  _ClientPageState createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  API _api = API();
  late List<House> best_house = [];
  late List<House> recent_house = [];
  getData() async {
    var result = await _api.getClientHouses();
    if (result["status"]) {
      setState(() {
        best_house = result["best_offer"];
        recent_house = result["recent"];
      });
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

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
          padding: const EdgeInsets.all(14.0),
          child: ListView(
            children: [
              SizedBox(
                height: space,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image(
                          width: width / 8,
                          height: height / 14,
                          fit: BoxFit.cover,
                          image: AssetImage('asset/images/avatar.jpeg'),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: space + 10,
              ),
              recent_house.length == 0
                  ? Text("No loaded data")
                  : RencentAddedSection(
                      textTheme: textTheme,
                      recent_house: recent_house,
                    ),
              Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Todays Best Offer",
                      style: textTheme.headline5,
                    ),
                    TextButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.grey),
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered))
                                return Colors.grey.withOpacity(0.04);
                              if (states.contains(MaterialState.focused) ||
                                  states.contains(MaterialState.pressed))
                                return Colors.blue.withOpacity(0.12);
                              return Colors.grey.withOpacity(0.12);
                            },
                          ),
                        ),
                        onPressed: () {
                          if (best_house.isNotEmpty) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ListHouseClient(houses: best_house);
                            }));
                          }
                        },
                        child: Text('See All'))
                  ],
                ),
                SizedBox(
                  height: space + 8,
                ),
                best_house.length == 0
                    ? Text("No Data is loaded")
                    : BestOffer(house: best_house[0])
              ]),
              SizedBox(
                height: space * 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RencentAddedSection extends StatelessWidget {
  final List<House> recent_house;
  RencentAddedSection(
      {Key? key, required this.textTheme, required this.recent_house})
      : super(key: key);

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
            TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.grey),
                  overlayColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.hovered))
                        return Colors.grey.withOpacity(0.04);
                      if (states.contains(MaterialState.focused) ||
                          states.contains(MaterialState.pressed))
                        return Colors.blue.withOpacity(0.12);
                      return Colors.grey.withOpacity(0.12);
                    },
                  ),
                ),
                onPressed: () {
                  if (recent_house.isNotEmpty) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ListHouseClient(houses: recent_house);
                    }));
                  }
                },
                child: Text('See All'))
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 350,
          child: ListView(
              scrollDirection: Axis.horizontal,
              children: loadRecent(recent_house)),
        ),
      ],
    );
  }
}

List<Widget> loadRecent(List<House> recentHouse) {
  if (recentHouse.length >= 2) {
    return [
      RecentAdded(house: recentHouse[0]),
      RecentAdded(house: recentHouse[1])
    ];
  } else {
    return [
      RecentAdded(house: recentHouse[0]),
    ];
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
