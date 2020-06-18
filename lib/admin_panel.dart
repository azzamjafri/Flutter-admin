import 'package:AdminPanel/add_new_category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminPanel extends StatefulWidget {
  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  TextEditingController nameController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text('Admin Panel'),
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 50.0,
            width: MediaQuery.of(context).size.width / 4,
            color: Colors.grey,
            child: FlatButton(
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => NewCategory()));
              },
              child: Center(
                  child: new Row(
                children: [
                  Icon(Icons.add),
                  Text(
                    'Add a new Category',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              )),
            ),
          ),
          Padding(padding: EdgeInsets.all(20.0)),
          ListView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: <Widget>[_buildList()],
          ),
        ],
      ),
    );
  }

  Widget _buildList() {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('categories').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error : ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: new Container(
                height: MediaQuery.of(context).size.height / 8,
                width: MediaQuery.of(context).size.width / 8,
                child: CircularProgressIndicator(),
              ),
            );
          default:
            final int count = snapshot.data.documents.length;
            return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: count,
              itemBuilder: (_, int index) {
                final DocumentSnapshot document =
                    snapshot.data.documents[index];

                return Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 0.0),
                  child: new Container(
                    height: 80.0,
                    width: 350.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                    child: FlatButton(
                        onPressed: () {
                          
                        },
                        child: Row(children: [
                          new Icon(Icons.add),
                          new Text(
                            document['name'],
                            textAlign: TextAlign.center,
                          ),
                        ])),
                  ),
                );
              },
            );
        }
      },
    );
  }
}
