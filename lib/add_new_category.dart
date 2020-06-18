
import 'dart:html';
import 'dart:typed_data';

import 'package:AdminPanel/image_helper_class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';


import 'dart:async';

class NewCategory extends StatefulWidget {
  @override
  _NewCategoryState createState() => _NewCategoryState();
}

class _NewCategoryState extends State<NewCategory> {
  TextEditingController nameController = new TextEditingController();
  Uri url;
  
  List<String> _uploadedImages;

  Uint8List uploadedImage;
  String option1Text;

  final databaseReference = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: new Column(
          children: [
            SizedBox(
              height: 100.0,
            ),
            Container(
              height: 50.0,
              width: MediaQuery.of(context).size.width / 3,
              child: new TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                    borderSide: BorderSide(
                      color: Colors.grey[200],
                      width: 1.8,
                    ),
                  ),
                  hintText: 'Enter Category Name',
                  fillColor: Colors.white,
                  filled: true,
                ),
                controller: nameController,
                // validator: (val) => val.isEmpty ? 'Enter a name' : null,
              ),
            ),
            Padding(padding: EdgeInsets.all(20.0)),
            RaisedButton(
              onPressed: () {
                // _pickImage();
                _startFilePicker();
              },
              child: Container(
                  height: 50.0,
                  width: 300.0,
                  child: Row(children: [
                    new Icon(Icons.add),
                    new Text('Select an image'),
                  ])),
            ),
            Padding(padding: EdgeInsets.all(20.0)),
            RaisedButton(
              onPressed: () {
                setState(() async {
                  print(uploadedImage.toString() + '(first **************');
                });
              },
              child: Container(
                  height: 50.0,
                  width: 300.0,
                  child: Row(children: [
                    new Icon(Icons.add),
                    new Text('Upload Image'),
                  ])),
            ),
            Padding(padding: EdgeInsets.all(20.0)),
            RaisedButton(
              onPressed: () {
                print(url.path +
                    " *************** " +
                    url.toString() +
                    "      .....           " +
                    url.scheme +
                    '\n\n\n');
              },
              child: Container(
                  height: 50.0,
                  width: 300.0,
                  child: Row(children: [
                    new Icon(Icons.add),
                    new Text('Add', style: TextStyle(color: Colors.red)),
                  ])),
            ),
          ],
        ),
      ),
    );
  }

  _createRecord() async {
    DocumentReference ref = await databaseReference
        .collection('categories')
        .add({'name': nameController.text, 'image': url});
    print(ref);
  }

//method to load image and update `uploadedImage`

  _startFilePicker() async {
    InputElement uploadInput = FileUploadInputElement();
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      // read file content as dataURL
      final files = uploadInput.files;
      if (files.length == 1) {
        final file = files[0];
        FileReader reader = FileReader();

        reader.onLoadEnd.listen((e) {
          setState(() {
            uploadedImage = reader.result;
          });
        });

        reader.onError.listen((fileEvent) {
          setState(() {
            option1Text = "Some Error occured while reading the file";
          });
        });

        reader.readAsArrayBuffer(file);
      }
    });
    print(uploadedImage.toString() + " ******************");
  }
}
