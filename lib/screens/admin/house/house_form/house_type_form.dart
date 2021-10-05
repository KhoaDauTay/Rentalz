import 'package:flutter/material.dart';
import 'package:mobile_final/core/services/api_service.dart';
import 'package:mobile_final/forms/text_field.dart';
import 'package:mobile_final/models/house_model.dart';
import 'package:mobile_final/models/house_type_model.dart';
import 'package:mobile_final/screens/admin/list_house_page.dart';

import '../../../../constants.dart';
import '../../admin_home_page.dart';
import 'create_photo.dart';

class HouseTypePage extends StatefulWidget {
  final House house;
  HouseTypePage(this.house);

  @override
  _HouseTypePageState createState() => _HouseTypePageState();
}

class _HouseTypePageState extends State<HouseTypePage> {
  final _formKey = GlobalKey<FormState>();
  bool haveWifi = false;
  late HouseType houseType = HouseType(
      house: widget.house.id,
      inside_property: "",
      outside_property: "",
      have_wifi: haveWifi);
  API api = API();
  @override
  Widget build(BuildContext context) {
    final height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final space = height > 650 ? kSpaceM : kSpaceS;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kPaddingM),
          child: Container(
            padding: const EdgeInsets.all(kPaddingS),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      "Fill your information of house",
                      style: TextStyle(
                          color: Colors.black45,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: space,
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          minLines: 1,
                          maxLines: 5,
                          keyboardType: TextInputType.multiline,
                          obscureText: false,
                          maxLength: 200,
                          decoration: const InputDecoration(
                            labelText: "Inside Property",
                          ),
                          validator: (value) {
                            return null;
                          },
                          onSaved: (value) {
                            houseType.inside_property = value!;
                          },
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          minLines: 1,
                          maxLines: 5,
                          keyboardType: TextInputType.multiline,
                          obscureText: false,
                          maxLength: 200,
                          decoration: const InputDecoration(
                            labelText: "Outside Property",
                          ),
                          validator: (value) {
                            return null;
                          },
                          onSaved: (value) {
                            houseType.outside_property = value!;
                          },
                        ),
                        Row(
                          children: [
                            Text(
                              "Have Wifi: ",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Switch(
                                value: haveWifi,
                                onChanged: (value) {
                                  setState(() {
                                    houseType.have_wifi = value;
                                    haveWifi = value;
                                  });
                                },
                                activeColor: Colors.blue,
                                activeTrackColor: Colors.yellow,
                                inactiveThumbColor: Colors.redAccent,
                                inactiveTrackColor: Colors.orange),
                          ],
                        ),
                        SizedBox(
                          height: space,
                        ),
                        SizedBox(
                            child: ElevatedButton(
                              onPressed: _submitData,
                              child: const Text('CREATE'),
                            ),
                            width: double.infinity),
                        SizedBox(
                          height: space * 2,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _submitData() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      var result = await api.createHouseType(houseType);
      if (result["status"]) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return AdminPage();
        }));
      } else {
        _showMyDialog(
            context, "Failed create house type of ${widget.house.name}");
      }
    } else {
      _showMyDialog(context, "Input is not validate of ${widget.house.name}");
    }
  }

  Future<void> _showMyDialog(context, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Response status:'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
