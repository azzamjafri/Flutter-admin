

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:image_picker_web/image_picker_web.dart';


class NewCategory extends StatefulWidget {
  @override
  _NewCategoryState createState() => _NewCategoryState();
}

class _NewCategoryState extends State<NewCategory> {

  TextEditingController nameController = new TextEditingController();
  String url;
  // PickedFile pickedImage;
  // Image pickedImage;
  File pickedImage;

  StorageReference storageReference ;

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
            width: MediaQuery.of(context).size.width / 5,
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
          RaisedButton(
            onPressed: () {
              _pickImage();
            },
            child:
                Container(
                  height: 50.0,
                  width: 300.0,
                  child: Row(children: [new Icon(Icons.add), new Text('Select an image'), ])),
          ),
          Padding(padding: EdgeInsets.all(20.0)),
          RaisedButton(
            onPressed: () {
              _uploadData();
            },
            child:
                Container(
                  height: 50.0,
                  width: 300.0,
                  child: Row(children: [new Icon(Icons.add), new Text('Add', style: TextStyle(color: Colors.red)), ])),
          ),
        ],
      ),
      ),
    );
  }

  _uploadData() async {
    storageReference = FirebaseStorage.instance.ref().child("image/${nameController.text}");
    final StorageUploadTask uploadTask = storageReference.putFile(pickedImage);
    final StorageTaskSnapshot downloadUrl = await (uploadTask.onComplete);
    url = (await downloadUrl.ref.getDownloadURL());
    print(url + "************");
  }
  _pickImage()  async {
    File temp = await ImagePickerWeb.getImage(outputType: ImageType.file);
    if(temp != null) {
      setState(() {
        pickedImage = temp;
        
      });
    }
  }
}