import 'package:flutter/material.dart';
import 'package:gridview_test/dog_model.dart';

class AddDogFormPage extends StatefulWidget {
  @override
  _AddDogFormPageState createState() => new _AddDogFormPageState();
}

class _AddDogFormPageState extends State<AddDogFormPage> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController locationController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();

  void submitPup(context) {
    if (nameController.text.isEmpty) {
      Scaffold.of(context).showSnackBar(
            new SnackBar(
              backgroundColor: Colors.redAccent,
              content: new Text('Add the Bank Name!'),
            ),
          );
    } else {
      var newDog = new Dog(nameController.text, locationController.text,
          descriptionController.text);
      Navigator.of(context).pop(newDog);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Add a new card'),
        backgroundColor: Colors.black87,
      ),
      body: new Container(
        color: Colors.black54,
        child: new Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 32.0,
          ),
          child: new Column(
            children: [
              new Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: new TextField(
                    controller: nameController,
                    decoration: new InputDecoration(
                      labelText: 'Name on the card',
                    )),
              ),
              new Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: new TextField(
                    controller: locationController,
                    decoration: new InputDecoration(
                      labelText: "Card Number",
                    )),
              ),
              new Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: new TextField(
                    controller: descriptionController,
                    decoration: new InputDecoration(
                      labelText: 'Expiry Date ',
                    )),
              ),
              new Padding(
                padding: const EdgeInsets.all(16.0),
                child: new Builder(
                  builder: (context) {
                    return new RaisedButton(
                      color: Colors.indigoAccent,
                      child: new Text('Submit Card'),
                      onPressed: () => submitPup(context),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
