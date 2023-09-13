import 'package:app/MongoDbModel.dart';
import 'package:app/dbHelper/mongodb.dart';
import 'package:app/main.dart';
import 'package:app/edit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MongoDbShowDetails extends StatefulWidget {
  final MongoDbModel data;

  MongoDbShowDetails({Key? key, required this.data}) : super(key: key);

  @override
  State<MongoDbShowDetails> createState() => _MongoDbShowDetails();
}

class _MongoDbShowDetails extends State<MongoDbShowDetails> {
  //_getRequests() async {}
  late DateTime selectedorder_date;
  late DateTime selectedfinish_date;

  String selectedorder_dateString = "";
  String selectedfinish_dateString = "";

  @override
  Widget build(BuildContext context) {
    //data = widget.data;

    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          title: const Text('订单资料'),
        ),
        body: Container(
            //color: Color.fromARGB(255, 166, 210, 206),
            margin: EdgeInsets.symmetric(
                horizontal: 0.03 * deviceWidth, vertical: 0.03 * deviceHight),
            child: Row(children: <Widget>[
              displayOrderDetails(widget.data, context),
            ])));
  }

  Widget displayOrderDetails(MongoDbModel data, BuildContext context) {
    var statusColor = Colors.red;

    selectedorder_date = DateTime.parse(widget.data.order_date);
    selectedorder_dateString =
        DateFormat("yyyy-MM-dd").format(selectedorder_date.toLocal());

    if ("${data.order_status}" == ("完成")) {
      statusColor = Colors.green;
      selectedfinish_date = DateTime.parse(widget.data.finish_date);
      selectedfinish_dateString =
          DateFormat("yyyy-MM-dd").format(selectedfinish_date.toLocal());
    }

    return Container(
        width: MediaQuery.of(context).size.width - 25,
        child: Column(children: [
          DataTable(
            horizontalMargin: 10,
            //columnSpacing: 20.0,
            headingRowColor: MaterialStateColor.resolveWith(
                (states) => Color.fromARGB(255, 102, 152, 179)),
            columns: [
              DataColumn(
                  label: Text('Attribute',
                      textScaleFactor: 1.2,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white))),
              DataColumn(
                  label: Text('资料',
                      textScaleFactor: 1.3,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white))),
            ],
            rows: [
              DataRow(cells: [
                DataCell(Text('订单日期',
                    textScaleFactor: 1.2,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 123, 123, 123)))),
                DataCell(Text('${selectedorder_dateString}',
                    textScaleFactor: 1.2, style: TextStyle(fontSize: 20))),
              ]),
              DataRow(cells: [
                DataCell(Text('学校',
                    textScaleFactor: 1.2,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 123, 123, 123)))),
                DataCell(Text(
                  '${data.school}',
                  textScaleFactor: 1.2,
                  style: TextStyle(fontSize: 20),
                  overflow: TextOverflow.visible,
                  softWrap: true,
                )),
              ]),
              DataRow(cells: [
                DataCell(Text('颜色',
                    textScaleFactor: 1.2,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 123, 123, 123)))),
                DataCell(Text('${data.color}',
                    textScaleFactor: 1.2, style: TextStyle(fontSize: 20))),
              ]),
              DataRow(cells: [
                DataCell(Text('长度',
                    textScaleFactor: 1.2,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 123, 123, 123)))),
                DataCell(Text('${data.length}',
                    textScaleFactor: 1.2, style: TextStyle(fontSize: 20))),
              ]),
              DataRow(cells: [
                DataCell(Text('订单数量',
                    textScaleFactor: 1.2,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 123, 123, 123)))),
                DataCell(Text('${data.number}',
                    textScaleFactor: 1.2, style: TextStyle(fontSize: 20))),
              ]),
              DataRow(cells: [
                DataCell(Text('订单状态',
                    textScaleFactor: 1.2,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 123, 123, 123)))),
                DataCell(Text('${data.order_status}',
                    textScaleFactor: 1.2,
                    style: TextStyle(fontSize: 20, color: statusColor))),
              ]),
              DataRow(cells: [
                DataCell(Text('完成日期',
                    textScaleFactor: 1.2,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 123, 123, 123)))),
                DataCell(Text('${selectedfinish_dateString}',
                    textScaleFactor: 1.2, style: TextStyle(fontSize: 20))),
              ]),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  showAlertDialog(context);
                  //Navigator.pop(context);
                },
                child: Text("删除订单",
                    textScaleFactor: 1.2,
                    style: TextStyle(
                      fontSize: 20,
                      //fontWeight: FontWeight.bold,
                    )),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 150, 54, 54),
                  fixedSize: Size(120, 50),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return MongoDbUpdate(
                      data: data,
                    );
                  }));
                  //.then((value) {
                  //setState(() {});
                  //});
                },
                //Navigator.pop(context);
                child: Text("修改订单",
                    textScaleFactor: 1.2,
                    style: TextStyle(
                      fontSize: 20,
                      //fontWeight: FontWeight.bold,
                    )),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 102, 152, 179),
                  fixedSize: Size(120, 50),
                ),
              ),
            ],
          )
        ]));
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("确定"),
      onPressed: () async {
        await MongoDatabase.delete(widget.data);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("订单已删除")));

        Navigator.of(context).pop();

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage(title: '订单管理')),
          (Route<dynamic> route) => false,
        );

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SecondRoute()),
        );
      },
    );
    Widget continueButton = FlatButton(
      child: Text("取消"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("删除确认"),
      content: Text("确定删除该订单？"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
