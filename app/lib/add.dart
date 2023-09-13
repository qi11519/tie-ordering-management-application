import 'package:app/MongoDbModel.dart';
import 'package:app/dbHelper/mongodb.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:intl/intl.dart';

class MongoDbInsert extends StatefulWidget {
  MongoDbInsert({Key? key}) : super(key: key);

  @override
  _MongoDbInsertState createState() => _MongoDbInsertState();
}

class _MongoDbInsertState extends State<MongoDbInsert> {
  DateTime selectedorder_date = DateTime.now();
  DateTime selectedfinish_date = DateTime.now();

  String selectedorder_dateString =
      DateFormat("yyyy-MM-dd").format(DateTime.now()).toString();

  String selectedfinish_dateString = "";

  var Order_Status = "未完成";
  var statusColor = Colors.red;
  bool isSwitched = false;

  var schoolTextController = new TextEditingController();
  var colorTextController = new TextEditingController();
  var lengthTextController = new TextEditingController();
  var numberTextController = new TextEditingController();

  var _checkInsertUpdate = "Insert";
  var buttonName = "新增";

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHight = MediaQuery.of(context).size.height;

    /*
    MongoDbModel? data =
        ModalRoute.of(context)!.settings.arguments as MongoDbModel;

    if (data != null) {
      schoolTextController.text = data.school;
      colorTextController.text = data.color;
      lengthTextController.text = data.length;
      numberTextController.text = data.number;
      selectedorder_date = DateTime.parse(data.order_date);
      Order_Status = data.order_status;
      if (data.order_status == "完成") {
        statusColor = Colors.green;
        isSwitched = true;
        selectedfinish_date = DateTime.parse(data.finish_date);
        selectedfinish_dateString = selectedfinish_date.toString();
      }
      _checkInsertUpdate = "Update";
      buttonName = "修改";
    }
    */

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('新增订单'),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(
              horizontal: 0.05 * deviceWidth, vertical: 0.03 * deviceHight),
          child: Column(
            children: <Widget>[
              Column(
                children: [
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 0.75 * deviceWidth,
                        child: TextField(
                          controller: schoolTextController,
                          decoration: InputDecoration(labelText: "学校"),
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      FutureBuilder<List<String>>(
                          future: MongoDatabase.getSchool(),
                          builder: (context, snapshot) {
                            return PopupMenuButton<String>(
                              itemBuilder: (context) => snapshot.data!
                                  .map((content) => PopupMenuItem<String>(
                                        value: content,
                                        child: Text(
                                          content,
                                          textScaleFactor: 1.0,
                                        ),
                                      ))
                                  .toList(),
                              onSelected: (value) {
                                setState(() {
                                  if (value == "未选择") {
                                    value = "";
                                  }
                                  //schoolTextController = TextEditingController(text: value);
                                  schoolTextController.text = value;
                                });
                              },
                            );
                          })
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
              Text(
                "订单日期",
                textScaleFactor: 1.2,
                style: TextStyle(fontSize: 20.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${selectedorder_dateString}".split(' ')[0],
                    textScaleFactor: 1.2,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  RaisedButton(
                    onPressed: () => _selectorder_date(context),
                    child: Text(
                      '选择日期',
                      textScaleFactor: 1.2,
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ),
                ],
              ),
              TextField(
                controller: colorTextController,
                decoration: InputDecoration(labelText: "颜色"),
                style: TextStyle(fontSize: 15.0),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    new Flexible(
                      child: new TextField(
                        controller: lengthTextController,
                        decoration: InputDecoration(labelText: "长度"),
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    new Flexible(
                      child: new TextField(
                        controller: numberTextController,
                        decoration: InputDecoration(labelText: "数量"),
                        style: TextStyle(fontSize: 15.0),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  "订单状态",
                  textScaleFactor: 1.1,
                  style: TextStyle(fontSize: 20.0),
                ),
                Text(
                  "${Order_Status}".split(' ')[0],
                  textScaleFactor: 1.1,
                  style: TextStyle(
                      fontSize: 20.0,
                      color: statusColor,
                      fontWeight: FontWeight.bold),
                ),
                Switch(
                  onChanged: toggleSwitch,
                  value: isSwitched,
                  activeColor: Color.fromARGB(255, 26, 156, 54),
                  activeTrackColor: Color.fromARGB(255, 105, 211, 133),
                  inactiveThumbColor: Colors.redAccent,
                  inactiveTrackColor: Colors.orange,
                )
              ]),
              Text(
                "订单完成日期",
                textScaleFactor: 1.2,
                style: TextStyle(fontSize: 20.0),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  "${selectedfinish_dateString}".split(' ')[0],
                  textScaleFactor: 1.2,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                RaisedButton(
                  onPressed: () {
                    Order_Status == '完成' ? _selectfinish_date(context) : null;
                  },
                  child: Text(
                    '选择日期',
                    textScaleFactor: 1.2,
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
              ]),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    /*
                    if (_checkInsertUpdate == "Update") {
                      _updateData(
                        data.id,
                        schoolTextController.text,
                        selectedorder_dateString,
                        colorTextController.text,
                        lengthTextController.text,
                        numberTextController.text,
                        Order_Status,
                        selectedfinish_dateString,
                      );
                    } else {*/
                    _insertData(
                      schoolTextController.text,
                      selectedorder_dateString,
                      colorTextController.text,
                      lengthTextController.text,
                      numberTextController.text,
                      Order_Status,
                      selectedfinish_dateString,
                    );
                    //}
                  },
                  child: Text(buttonName, style: TextStyle(fontSize: 20.0))),
            ],
          ),
        ));
  }

  Future<void> _insertData(
      String school,
      String order_date,
      String color,
      String length,
      String number,
      String order_status,
      String finish_date) async {
    var _id = M.ObjectId();
    final data = MongoDbModel(
        id: _id,
        order_date: order_date,
        school: school,
        color: color,
        length: length,
        number: number,
        order_status: order_status,
        finish_date: finish_date);
    var result = await MongoDatabase.insert(data);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("已新增订单")));
    _clearAll();
  }

  /*
  Future<void> _updateData(
      var id,
      String school,
      String order_date,
      String color,
      String length,
      String number,
      String order_status,
      String finish_date) async {
    final updateData = MongoDbModel(
        id: id,
        order_date: order_date,
        school: school,
        color: color,
        length: length,
        number: number,
        order_status: order_status,
        finish_date: finish_date);
    await MongoDatabase.update(updateData)
        .whenComplete(() => Navigator.pop(context));
  }*/

  void _clearAll() {
    schoolTextController.text = "";
    colorTextController.text = "";
    lengthTextController.text = "";
    numberTextController.text = "";

    selectedorder_date = DateTime.now();
    DateTime? selectedfinish_date = null;

    Order_Status = "未完成";
    statusColor = Colors.red;
    isSwitched = false;
  }

  Future<void> _selectorder_date(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedorder_date,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedorder_date) {
      setState(() {
        selectedorder_date = picked.toLocal();
        selectedorder_dateString = selectedorder_date.toString();
        selectedorder_dateString =
            DateFormat("yyyy-MM-dd").format(selectedorder_date);
      });
    }
  }

  Future<void> _selectfinish_date(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedorder_date,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedfinish_date) {
      setState(() {
        selectedfinish_date = picked.toLocal();
        selectedfinish_dateString = selectedfinish_date.toString();
        selectedfinish_dateString =
            DateFormat("yyyy-MM-dd").format(selectedfinish_date);
      });
    }
  }

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
        Order_Status = '完成';
        statusColor = Colors.green;
        selectedfinish_date = selectedorder_date;
        selectedfinish_dateString = selectedfinish_date.toString();
        selectedfinish_dateString =
            DateFormat("yyyy-MM-dd").format(selectedfinish_date);
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        isSwitched = false;
        Order_Status = '未完成';
        statusColor = Colors.red;
        selectedfinish_date = DateTime.now();
        selectedfinish_dateString = "";
      });
      print('Switch Button is OFF');
    }
  }
}
