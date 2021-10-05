import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_final/core/services/api_service.dart';
import 'package:mobile_final/models/house_model.dart';
import 'package:mobile_final/screens/admin/house/house_detail_page.dart';

import '../../../constants.dart';

class HouseCardClient extends StatefulWidget {
  final House house;
  Function? removeHouse;
  Function addHouse;
  HouseCardClient(
      {required this.house, required this.removeHouse, required this.addHouse});

  @override
  State<HouseCardClient> createState() => _HouseCardClientState();
}

class _HouseCardClientState extends State<HouseCardClient> {
  final _api = API();

  addBookMark() async {
    bool status = await _api.addBookMark(widget.house);
    if (status) {
      setState(() {
        widget.house.isLiked = true;
        widget.addHouse();
      });
    }
  }

  removeBookMark() async {
    bool status = await _api.removeBookMark(widget.house);
    if (status) {
      setState(() {
        if (widget.removeHouse != null) {
          widget.removeHouse!(widget.house.name);
        }
        widget.house.isLiked = false;
      });
    }
  }

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
                builder: (context) => HouseDetailPage(house: widget.house)));
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
                tag: widget.house.name,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image(
                    height: height.toInt() / 10,
                    width: height.toInt() / 8,
                    fit: BoxFit.cover,
                    image: NetworkImage(widget.house.image == null
                        ? image_default
                        : widget.house.image),
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
                      widget.house.name,
                      style: textTheme.headline5,
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      widget.house.address,
                      style: textTheme.bodyText1!.apply(color: Colors.black45),
                    ),
                    SizedBox(
                      height: space,
                    ),
                    RichText(
                      text: TextSpan(
                          text: "\$ ${widget.house.rent} / ",
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
                      "Reporter: " + widget.house.reporter,
                      style: textTheme.bodyText1!.apply(color: Colors.black),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: space,
              ),
              loadIcon(),
              SizedBox(
                width: space,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget loadIcon() {
    if (widget.house.isLiked) {
      return IconButton(
        icon: Icon(Icons.favorite, color: Colors.pink, size: 30),
        onPressed: () async {
          await removeBookMark();
        },
      );
    } else {
      return IconButton(
        icon: Icon(Icons.favorite_border, color: Colors.pink, size: 30),
        onPressed: () async {
          await addBookMark();
        },
      );
    }
  }
}
