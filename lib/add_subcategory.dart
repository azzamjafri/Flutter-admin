import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';



class NewCategory extends StatefulWidget {
  @override
  _NewCategoryState createState() => _NewCategoryState();
}

class _NewCategoryState extends State<NewCategory> {
  TextEditingController nameController = new TextEditingController();
  
  final databaseReference = Firestore.instance;
  String url = "";

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
                  hintText: 'Enter Name',
                  fillColor: Colors.white,
                  filled: true,
                ),
                controller: nameController,
                // validator: (val) => val.isEmpty ? 'Enter a name' : null,
              ),
            ),
            Padding(padding: EdgeInsets.all(20.0)),
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
                  hintText: '',
                  fillColor: Colors.white,
                  filled: true,
                ),
                controller: nameController,
                // validator: (val) => val.isEmpty ? 'Enter a name' : null,
              ),
            ),
            Padding(padding: EdgeInsets.all(20.0)),
            Padding(padding: EdgeInsets.all(20.0)),
            RaisedButton(
              onPressed: () {
               },
              child: Container(
                  height: 50.0,
                  width: 300.0,
                  child: Row(children: [
                    new Icon(Icons.add),
                    new Text('Add', style: TextStyle(color: Colors.red)
                    ),
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

  
}
