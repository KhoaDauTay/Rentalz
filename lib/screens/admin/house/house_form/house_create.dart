import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_final/core/services/api_service.dart';
import 'package:mobile_final/forms/number_field.dart';
import 'package:mobile_final/forms/text_field.dart';
import 'package:mobile_final/models/house_model.dart';
import 'package:intl/intl.dart';

import '../../../../constants.dart';
import 'house_type_form.dart';

class HouseForm extends StatefulWidget {
  @override
  _HouseFormState createState() => _HouseFormState();
}

class _HouseFormState extends State<HouseForm> {
  late XFile? _image;
  final ImagePicker _picker = ImagePicker();
  final _api = API();
  var propertyTypes = [
    "Choose one",
    "House",
    "Flat",
    "Bungalow",
  ];
  var furnitureTypes = [
    "Choose one",
    "Furnished",
    "Unfurnished",
    "Part Furnished",
  ];
  var bedRoomTypes = [
    "Choose one",
    "One",
    "Two",
    "Three",
    "Tuesday Room",
    "Studio",
  ];
  // Drop down variable
  late String _properTypeValue = propertyTypes[0];
  late String _bedRoomValue = bedRoomTypes[0];
  late String _furnitureValue = furnitureTypes[0];
  bool isClicked = false;
  bool isPicked = false;
  bool haveWifi = false;
  final _formKey = GlobalKey<FormState>();
  late DateTime _selectedDate = DateTime.now();
  final house = House(
      propertyTypes: '',
      bedRoom: '',
      reporter: '',
      rent: 0,
      address: '',
      name: '',
      createAt: '');
  PermissionStatus _permissionStatus = PermissionStatus.denied;
  @override
  void initState() {
    house.createAt = DateFormat('yyyy-MM-dd').format(_selectedDate);
    house.furnitureTypes = '';
    _listenForPermissionStatus();
    super.initState();
  }

  void _listenForPermissionStatus() async {
    final status = await Permission.camera.status;
    setState(() => _permissionStatus = status);
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        setState(() {
          house.createAt = DateFormat('yyyy-MM-dd').format(_selectedDate);
        });
      } else {
        setState(() {
          _selectedDate = pickedDate;
          house.createAt = DateFormat('yyyy-MM-dd').format(_selectedDate);
        });
      }
    });
  }

  _submitData() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      var result = await _api.findHouse(house.name);
      if (result) {
        _showMyDialog(context, "The Name is already exist!");
      } else {
        showDialog(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) => AlertDialog(
                  title: const Text('Confirm your data'),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: [
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
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () async {
                        showLoaderDialog(context);
                        var result = await _api.createHouses(house);
                        if (result["status"]) {
                          var imageUpload = await _api.uploadPhoto(
                              _image!.path, result["house"] as House);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return HouseTypePage(result["house"] as House);
                          }));
                        } else {
                          Navigator.pop(context);
                          _showMyDialog(context, result["message"]);
                        }
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ));
      }
    } else {
      _showMyDialog(context, "Check input try again");
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

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

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
                      "Create new house",
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
                        MyFormTextField(
                          isObscure: false,
                          decoration: const InputDecoration(
                            labelText: "Name of House",
                          ),
                          validator: (value) {
                            if (value == null || value == '') {
                              return 'Name of house is required field';
                            }
                            if (value.length > 50) {
                              return "No more than 50 character";
                            }
                            return null;
                          },
                          onChanged: (value) {},
                          onSaved: (value) {
                            house.name = value!;
                          },
                        ),
                        SizedBox(
                          height: space,
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          minLines: 1,
                          maxLines: 3,
                          keyboardType: TextInputType.multiline,
                          obscureText: false,
                          maxLength: 50,
                          decoration: const InputDecoration(
                            labelText: "Address",
                          ),
                          validator: (value) {
                            if (value == null || value == '') {
                              return 'Address is required field';
                            }
                            return null;
                          },
                          onChanged: (value) {},
                          onSaved: (value) {
                            house.address = value!;
                          },
                        ),
                        SizedBox(
                          height: space + 10,
                        ),
                        FormField<String>(
                          builder: (FormFieldState<String> state) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                  label: const Text("Property Types"),
                                  errorStyle: const TextStyle(
                                      color: Colors.redAccent, fontSize: 14.0),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(8.0))),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButtonFormField<String>(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value == 'Choose one') {
                                      return 'Property type must be required field';
                                    }
                                    return null;
                                  },
                                  hint: const Text("Select the Property type"),
                                  value: _properTypeValue,
                                  isDense: true,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _properTypeValue = newValue!;
                                      house.propertyTypes = _properTypeValue;
                                      state.didChange(newValue);
                                    });
                                  },
                                  items: propertyTypes.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      enabled:
                                          value == 'Choose one' ? false : true,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: space,
                        ),
                        FormField<String>(
                          builder: (FormFieldState<String> state) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                  label: const Text("Bed Room"),
                                  errorStyle: const TextStyle(
                                      color: Colors.redAccent, fontSize: 14.0),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(8.0))),
                              isEmpty: _bedRoomValue == '',
                              child: DropdownButtonHideUnderline(
                                child: DropdownButtonFormField<String>(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value == 'Choose one') {
                                      return 'Bed room must be required field';
                                    }
                                    return null;
                                  },
                                  hint: const Text("Select the bed room type"),
                                  value: _bedRoomValue,
                                  isDense: true,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _bedRoomValue = newValue!;
                                      house.bedRoom = _bedRoomValue;
                                      state.didChange(newValue);
                                    });
                                  },
                                  items: bedRoomTypes.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      enabled:
                                          value == 'Choose one' ? false : true,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: space,
                        ),
                        MyFormNumberField(
                          isObscure: false,
                          decoration: const InputDecoration(
                            labelText: "Money /Month",
                          ),
                          validator: (value) {
                            if (value == null || value == "") {
                              return 'Money is required field';
                            }
                            // if (value.contains(".") &&
                            //     value.substring(value.indexOf(".")).length >
                            //         3) {
                            //   return "The rent only accept 2 digits after the period";
                            // }
                            final n = num.tryParse(value);
                            if (n == null) {
                              return 'Money is required field';
                            } else if (n <= 0) {
                              return 'Number must be greater than 0';
                            }
                            return null;
                          },
                          onSaved: (rent) {
                            house.rent = double.parse(rent!);
                          },
                        ),
                        SizedBox(
                          height: space,
                        ),
                        MyFormTextField(
                          isObscure: false,
                          decoration: const InputDecoration(
                            labelText: "Reporter",
                          ),
                          validator: (reporter) {
                            if (reporter == null || reporter == '') {
                              return 'Reporter name is required field';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              isClicked = true;
                            });
                          },
                          onSaved: (reporter) {
                            house.reporter = reporter!;
                          },
                        ),
                        SizedBox(
                          height: space,
                        ),
                        FormField<String>(
                          validator: (value) {
                            return null;
                          },
                          builder: (FormFieldState<String> state) {
                            return SizedBox(
                              height: 50,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      _selectedDate == null
                                          ? 'Create day:'
                                          : 'Picked Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate)}',
                                      style: const TextStyle(
                                          color: Colors.black45, fontSize: 16),
                                    ),
                                  ),
                                  TextButton(
                                    child: Text(
                                      'Choose Date',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    onPressed: _presentDatePicker,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: space,
                        ),
                        FormField<String>(
                          builder: (FormFieldState<String> state) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                  label: Text("Furniture Types"),
                                  errorStyle: const TextStyle(
                                      color: Colors.redAccent, fontSize: 16.0),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(8.0))),
                              isEmpty: _furnitureValue == '',
                              child: DropdownButtonHideUnderline(
                                child: DropdownButtonFormField<String>(
                                  hint: const Text("Select the furniture type"),
                                  value: _furnitureValue,
                                  isDense: true,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _furnitureValue = newValue!;
                                      house.furnitureTypes = _furnitureValue;
                                      state.didChange(newValue);
                                    });
                                  },
                                  items: furnitureTypes.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          },
                        ),
                        TextFormField(
                          minLines: 1,
                          maxLines: 5,
                          keyboardType: TextInputType.multiline,
                          obscureText: false,
                          maxLength: 100,
                          decoration: const InputDecoration(
                            labelText: "Notes",
                          ),
                          validator: (value) {
                            return null;
                          },
                          onSaved: (note) {
                            house.notes = note!;
                          },
                        ),
                        Row(
                          children: [
                            Text(
                              "Best Offer: ",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: space,
                            ),
                            Switch(
                                value: haveWifi,
                                onChanged: (value) {
                                  setState(() {
                                    house.isBestOffer = value;
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
                        Row(
                          children: [
                            Text("Photo "),
                            InkWell(
                              onTap: () => _onAlertPress(context),
                              child: Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40.0),
                                      color: Colors.black),
                                  margin: EdgeInsets.only(left: 4, top: 4),
                                  child: Icon(
                                    Icons.photo_camera,
                                    size: 25,
                                    color: Colors.white,
                                  )),
                            ),
                          ],
                        ),
                        _previewImages(),
                        SizedBox(
                            child: ElevatedButton(
                              onPressed: isClicked ? _submitData : null,
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

  Widget _previewImages() {
    if (isPicked) {
      if (_image != null) {
        return Container(
          padding: EdgeInsets.all(10),
          width: 120,
          height: 160,
          child: Column(
            children: [Image.file(File(_image!.path))],
          ),
        );
      }
    }
    return Text("No Image");
  }

  Future requestPermission(Permission permission) async {
    final status = await permission.request();

    setState(() {
      _permissionStatus = status;
    });
    return status;
  }

  void _onAlertPress(context) async {
    PermissionStatus result = await requestPermission(Permission.camera);
    if (result.isGranted) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              actions: [
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        'asset/images/gallery.jpeg',
                        width: 50,
                      ),
                      Text('Gallery'),
                    ],
                  ),
                  onPressed: () => getGalleryImage(context),
                ),
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        'asset/images/take_picture.png',
                        width: 50,
                      ),
                      Text('Take Photo'),
                    ],
                  ),
                  onPressed: () => getCameraImage(context),
                ),
              ],
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
                title: Text('Camera Permission'),
                content: Text(
                    'This app needs camera access to take pictures for upload user profile photo'),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text('Deny'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  CupertinoDialogAction(
                    child: Text('Settings'),
                    onPressed: () => openAppSettings(),
                  ),
                ],
              ));
    }
  }

  Future getCameraImage(context) async {
    var image = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      isPicked = true;
      _image = image!;
      Navigator.pop(context);
    });
  }

  //============================== Image from gallery
  Future getGalleryImage(context) async {
    var image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      isPicked = true;
      _image = image!;
      Navigator.pop(context);
    });
  }
}
