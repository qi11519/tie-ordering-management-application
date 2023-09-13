import 'package:app/add.dart';
import 'package:app/dbHelper/mongodb.dart';
import 'package:app/display.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();

  runApp(MyApp());
}
//void main() => runApp(MyApp());

final Map<int, Color> _lightBlue800Map = {
  50: Color(0xFF03A9F4),
  100: Colors.lightBlue[100]!,
  200: Colors.lightBlue[200]!,
  300: Colors.lightBlue[300]!,
  400: Colors.lightBlue[400]!,
  500: Colors.lightBlue[500]!,
  600: Colors.lightBlue[600]!,
  700: Colors.lightBlue[800]!,
  800: Colors.lightBlue[900]!,
  900: Colors.lightBlue[700]!,
};

final MaterialColor _lightBlue800Swatch =
    MaterialColor(Colors.lightBlue[800]!.value, _lightBlue800Map);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return MediaQuery(
          child: child!,
          data: MediaQuery.of(context).copyWith(textScaleFactor: 2.0),
        );
      },
    );

    return MaterialApp(
      title: '订单管理',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: _lightBlue800Swatch,
      ),
      home: const MyHomePage(title: '订单管理'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        leading: Icon(Icons.menu_book),
      ),
      body: Container(
        width: deviceWidth,
        height: deviceHeight,
        margin: EdgeInsets.symmetric(
            horizontal: 0.05 * deviceWidth, vertical: 0.03 * deviceHeight),

        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.

        child: FractionallySizedBox(
          heightFactor: 1.0,
          child: Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Invoke "debug painting" (press "p" in the console, choose the
            // "Toggle Debug Paint" action from the Flutter Inspector in Android
            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
            // to see the wireframe for each widget.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SecondRoute()),
                      );
                    },
                    label: Text('查看订单记录'),
                    icon: Icon(Icons.menu, size: 30.0),
                    style: ElevatedButton.styleFrom(
                      onPrimary: Colors.white,
                      primary: Color.fromARGB(255, 42, 135, 185),
                      minimumSize: Size(deviceWidth * 0.9, deviceHeight * 0.4),
                      textStyle:
                          const TextStyle(fontSize: 20, color: Colors.teal),
                      elevation: 15,
                      shadowColor: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              Column(
                children: <Widget>[
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MongoDbInsert()),
                      );
                    },
                    label: Text('新增订单'),
                    icon: Icon(Icons.add_box_outlined, size: 30.0),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 42, 135, 185),
                      minimumSize: Size(deviceWidth * 0.9, deviceHeight * 0.17),
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                  ),
                  SizedBox(height: 25),
                  ElevatedButton.icon(
                    onPressed: null,
                    label: Text('待增新功能'),
                    icon: Icon(Icons.error_outline_rounded, size: 30.0),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 42, 135, 185),
                      minimumSize: Size(deviceWidth * 0.9, deviceHeight * 0.17),
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('订单记录'),
      ),
      body: MongoDbDisplay(),
    );
  }
}
