import 'package:funfy/ui/mapCodeTest.dart';
import 'package:funfy/utils/strings.dart';
import 'package:place_picker/place_picker.dart';
import 'package:flutter/material.dart';

class PickerDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PickerDemoState();
}

class PickerDemoState extends State<PickerDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Picker Example')),
      body: Center(
        child: FlatButton(
          child: Text("Pick Delivery location"),
          onPressed: () {
            showPlacePicker();
          },
        ),
      ),
    );
  }

  void showPlacePicker() async {
    LocationResult? result = await Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => PlacePickerB(Strings.mapKey)));

    // Handle the result in your way
    print(result);
  }
}
