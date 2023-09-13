import 'package:app/MongoDbModel.dart';
import 'package:app/orderDetails.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:app/dbHelper/mongodb.dart';
import 'package:intl/intl.dart';

class MongoDbDisplay extends StatefulWidget {
  MongoDbDisplay({Key? key}) : super(key: key);

  @override
  _MongoDbInsertState createState() => _MongoDbInsertState();
}

/*
class NewItem {
  bool isExpanded;
  final String header;
  final Widget body;
  final Icon iconpic;
  NewItem(this.isExpanded, this.header, this.body, this.iconpic);
}
*/
var AllSchoolList = MongoDatabase.getData() as String;

List<ExpandableController> controllerList = [
  ExpandableController(),
  ExpandableController(),
  ExpandableController()
];

class _MongoDbInsertState extends State<MongoDbDisplay> {
  var Order_Status = "未完成";
  var statusColor = Colors.red;
  bool isSwitched = false;

  bool clearAll = false;

  String dropdownvalue1 = '未选择';
  String dropdownvalue2 = '未选择';

  late DateTime selectedorder_dateStart;
  late DateTime selectedorder_dateEnd;
  late DateTime selectedfinish_dateStart;
  late DateTime selectedfinish_dateEnd;

  String selectedorder_dateStartString = "未选择";
  String selectedorder_dateEndString = "未选择";
  String selectedfinish_dateStartString = "未选择";
  String selectedfinish_dateEndString = "未选择";

  // List of items in our dropdown menu
  var statusList = [
    '未选择',
    '完成',
    '未完成',
  ];

  var schoolList = [
    '未选择',
    "SMK Hutan Melintang",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(children: <Widget>[
          filterMenu(context),
          Expanded(
              child: SafeArea(
            child: FutureBuilder(
                future: MongoDatabase.getQueryData(
                    dropdownvalue1,
                    dropdownvalue2,
                    selectedorder_dateStartString,
                    selectedorder_dateEndString,
                    selectedfinish_dateStartString,
                    selectedfinish_dateEndString),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshot.hasData) {
                      var totalData = snapshot.data.length;
                      //print("Total Data " + totalData.toString());
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return displayCard(
                                MongoDbModel.fromJson(snapshot.data[index]));
                          });
                    } else {
                      return Center(
                        child: Text("No data available."),
                      );
                    }
                  }
                }),
          ))
        ]));
  }

  Widget displayCard(MongoDbModel data) {
    Color statusColor;

    if ("${data.order_status}" == ("完成")) {
      statusColor = Colors.green;
    } else {
      statusColor = Colors.red;
    }

    return Card(
        child: ListTile(
            title: Text("${data.school}",
                textScaleFactor: 1.1,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            subtitle: Text("${data.order_date}",
                textScaleFactor: 1.1, style: TextStyle(fontSize: 18)),
            trailing: Text("${data.order_status}",
                textScaleFactor: 1.2,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: statusColor)),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MongoDbShowDetails(data: data)));
            }));
  }

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
        Order_Status = '完成';
        statusColor = Colors.green;
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        isSwitched = false;
        Order_Status = '未完成';
        statusColor = Colors.red;
      });
      print('Switch Button is OFF');
    }
  }

  int currentIndex = -1;

  Widget filterMenu(context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(2),
      child: Card(
        color: Color.fromARGB(255, 42, 135, 185),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            ScrollOnExpand(
              scrollOnExpand: true,
              scrollOnCollapse: false,
              child: ExpandablePanel(
                controller: controllerList[0],
                theme: const ExpandableThemeData(
                  iconColor: Colors.white,
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: true,
                ),
                header: InkWell(
                  onTap: () {
                    currentIndex = 0;
                    for (int i = 0; i < controllerList.length; i++) {
                      if (i == currentIndex) {
                        controllerList[i].expanded = true;
                      } else {
                        controllerList[i].expanded = false;
                      }
                    }
                  },
                  child: Container(
                    color: Color.fromARGB(255, 42, 135, 185),
                    child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 1,
                                child: Icon(
                                  Icons.calendar_today,
                                  color: Colors.white,
                                )),
                            Expanded(flex: 1, child: Container()),
                            Expanded(
                              flex: 4,
                              child: Text(
                                "筛选设定",
                                textScaleFactor: 0.9,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
                collapsed: Container(),
                expanded: Container(
                  //height: deviceHeight * 1.0,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '学校',
                              textScaleFactor: 0.9,
                              style: TextStyle(
                                fontSize: 17.0,
                              ),
                            ),
                            FutureBuilder<List<String>>(
                                future: MongoDatabase.getSchool(),
                                builder: (context, snapshot) {
                                  return DropdownButton(
                                      //hint: Text("Select"),
                                      value: dropdownvalue1,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropdownvalue1 = newValue!;
                                        });
                                      },
                                      items: snapshot.data?.map((items) {
                                        return DropdownMenuItem<String>(
                                          child: Text(
                                            items,
                                            textScaleFactor: 0.9,
                                          ),
                                          value: items,
                                        );
                                      }).toList());
                                }),
                            SizedBox(
                              width: 0,
                            ),
                          ],
                        ),
                        Divider(
                          color: Color.fromARGB(255, 42, 135, 185),
                          thickness: 2.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '订单状态',
                              textScaleFactor: 0.9,
                              style: TextStyle(
                                fontSize: 17.0,
                              ),
                            ),
                            DropdownButton(
                              // Initial Value
                              value: dropdownvalue2,

                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),

                              // Array list of items
                              items: statusList.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(
                                    items,
                                    textScaleFactor: 1.0,
                                  ),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownvalue2 = newValue!;
                                });
                              },
                            ),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                        Divider(
                          color: Color.fromARGB(255, 42, 135, 185),
                          thickness: 2.0,
                        ),
                        Container(
                          width: deviceWidth * 0.84,
                          child: Column(children: <Widget>[
                            Text(
                              '订单日期 (开始) ',
                              textScaleFactor: 0.9,
                              style: TextStyle(
                                fontSize: 17.0,
                              ),
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "${selectedorder_dateStartString}"
                                        .split(' ')[0],
                                    textScaleFactor: 0.9,
                                    style: TextStyle(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  RaisedButton(
                                    onPressed: () =>
                                        _selectorder_dateStart(context),
                                    child: Text(
                                      '选择日期',
                                      textScaleFactor: 0.9,
                                      style: TextStyle(fontSize: 15.0),
                                    ),
                                  ),
                                ])
                          ]),
                        ),
                        Divider(
                          color: Color.fromARGB(255, 42, 135, 185),
                          thickness: 2.0,
                        ),
                        Container(
                            width: deviceWidth * 0.84,
                            child: Column(
                              children: <Widget>[
                                Text(
                                  '订单日期 (截至)',
                                  textScaleFactor: 0.9,
                                  style: TextStyle(
                                    fontSize: 17.0,
                                  ),
                                ),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "${selectedorder_dateEndString}"
                                            .split(' ')[0],
                                        textScaleFactor: 0.9,
                                        style: TextStyle(
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      RaisedButton(
                                        onPressed: () =>
                                            _selectedorder_dateEnd(context),
                                        child: Text(
                                          '选择日期',
                                          textScaleFactor: 0.9,
                                          style: TextStyle(fontSize: 15.0),
                                        ),
                                      ),
                                    ])
                              ],
                            )),
                        Divider(
                          color: Color.fromARGB(255, 42, 135, 185),
                          thickness: 2.0,
                        ),
                        Container(
                            width: deviceWidth * 0.84,
                            child: Column(children: <Widget>[
                              Text(
                                '完成日期 (开始) ',
                                textScaleFactor: 0.9,
                                style: TextStyle(
                                  fontSize: 17.0,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "${selectedfinish_dateStartString}"
                                        .split(' ')[0],
                                    textScaleFactor: 0.9,
                                    style: TextStyle(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  RaisedButton(
                                    onPressed: () =>
                                        _selectedfinish_dateStart(context),
                                    child: Text(
                                      '选择日期',
                                      textScaleFactor: 0.9,
                                      style: TextStyle(fontSize: 15.0),
                                    ),
                                  ),
                                ],
                              )
                            ])),
                        Divider(
                          color: Color.fromARGB(255, 42, 135, 185),
                          thickness: 2.0,
                        ),
                        Container(
                          width: deviceWidth * 0.84,
                          child: Column(children: <Widget>[
                            Text(
                              '完成日期 (截至) ',
                              textScaleFactor: 0.9,
                              style: TextStyle(
                                fontSize: 17.0,
                              ),
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "${selectedfinish_dateEndString}"
                                        .split(' ')[0],
                                    textScaleFactor: 0.9,
                                    style: TextStyle(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  RaisedButton(
                                    onPressed: () =>
                                        _selectedfinish_dateEnd(context),
                                    child: Text(
                                      '选择日期',
                                      textScaleFactor: 0.9,
                                      style: TextStyle(fontSize: 15.0),
                                    ),
                                  ),
                                ]),
                          ]),
                        ),
                        Divider(
                          color: Color.fromARGB(255, 42, 135, 185),
                          thickness: 2.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  dropdownvalue1 = '未选择';
                                  dropdownvalue2 = '未选择';

                                  selectedorder_dateStartString = "未选择";
                                  selectedorder_dateEndString = "未选择";
                                  selectedfinish_dateStartString = "未选择";
                                  selectedfinish_dateEndString = "未选择";
                                });
                              },
                              //Navigator.pop(context);
                              child: Text("重置",
                                  textScaleFactor: 0.8,
                                  style: TextStyle(
                                    fontSize: 20,
                                    //fontWeight: FontWeight.bold,
                                  )),
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(255, 144, 102, 102),
                                fixedSize: Size(100, 30),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                builder: (_, collapsed, expanded) {
                  return Expandable(
                    collapsed: collapsed,
                    expanded: expanded,
                    theme: const ExpandableThemeData(crossFadePoint: 0),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }

  void clearFilter(bool clearAll) {
    if (clearAll = false) {
      dropdownvalue1 = '未选择';
      dropdownvalue2 = '未选择';

      selectedorder_dateStartString = "未选择";
      selectedorder_dateEndString = "未选择";
      selectedfinish_dateStartString = "未选择";
      selectedfinish_dateEndString = "未选择";

      //clearAll = true;
    }
  }

  Future<void> _selectorder_dateStart(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        selectedorder_dateStart = picked.toLocal();
        selectedorder_dateStartString = selectedorder_dateStart.toString();
        selectedorder_dateStartString =
            DateFormat("yyyy-MM-dd").format(selectedorder_dateStart);
      });
    }
  }

  Future<void> _selectedorder_dateEnd(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        selectedorder_dateEnd = picked.toLocal();
        selectedorder_dateEndString = selectedorder_dateEnd.toString();
        selectedorder_dateEndString =
            DateFormat("yyyy-MM-dd").format(selectedorder_dateEnd);
      });
    }
  }

  Future<void> _selectedfinish_dateStart(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        selectedorder_dateStart = picked.toLocal();
        selectedfinish_dateStartString = selectedorder_dateStart.toString();
        selectedfinish_dateStartString =
            DateFormat("yyyy-MM-dd").format(selectedfinish_dateStart);
      });
    }
  }

  Future<void> _selectedfinish_dateEnd(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        selectedfinish_dateEnd = picked.toLocal();
        selectedfinish_dateEndString = selectedfinish_dateEnd.toString();
        selectedfinish_dateEndString =
            DateFormat("yyyy-MM-dd").format(selectedfinish_dateEnd);
      });
    }
  }
}
