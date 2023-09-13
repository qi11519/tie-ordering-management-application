import 'package:flutter/material.dart';

class MongoDbUpdate extends StatefulWidget {
  const MongoDbUpdate({Key? key}) : super(key: key);

  @override
  _MongoDbUpdateState createState() => _MongoDbUpdateState();
}

class _MongoDbUpdateState extends State<MongoDbUpdate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
        child: FutureBuilder(builder: ((context, AsyncSnapshot snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        if (snapshot.hasData) {
          return Container();
        } else {
          return Center(
            child: Text("No Data Found"),
          );
        }
      }
    }))));
  }
}
