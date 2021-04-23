import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/services/message_codec.dart';

// import 'dart:ui';

void main() => runApp(MyApp());

const methodChannel = MethodChannel('com.easemob.TestOCJoinFlutter');
const eventChannel = EventChannel('com.easemob.TestOCJoinFlutter');

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in a Flutter IDE). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String msg;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
    methodChannel.invokeMethod('incrementCounter');
  }

  void initState() {
    super.initState();
    //监听接收消息
    eventChannel.receiveBroadcastStream().listen(_getData, onError: _getError);
    //设置消息监听
    methodChannel.setMethodCallHandler((MethodCall call) {
      //接收到消息
      print(call.method);
      print(call.arguments);
      return Future.value(1);
    });
  }

  void _getData(dynamic data) {
    //更新状态
    setState(() {
      msg = data.toString();
      print("================");
      print(msg);
    });
  }

  //获取到错误
  void _getError(Object err) {}

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    //
    //

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        // title: Text(widget.title),
        title: Text('iOS与Flutter交互'),
        //点击返回按钮时，触发消息
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => methodChannel.invokeMethod('backToNative')),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// final Window window = new Window._();

// void main() => runApp(MyApp(route: window.defaultRouteName));

// class MyApp extends StatefulWidget {
//   String route;
//   MyApp({@required this.route});
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   void initState() {
//     super.initState();
//     //收到iOS中传入指令
//     print(widget.route);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: HomePage(),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
// //创建消息通道并初始化消息名 这个名字要与iOS对应
//   static const MethodChannel methodChannel = MethodChannel('MSGChannel');

//   @override
//   void initState() {
//     super.initState();

//     //设置消息监听
//     methodChannel.setMethodCallHandler((MethodCall call) {
//       //接收到消息
//       print(call.method);
//       print(call.arguments);
//       return Future.value(true);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('iOS与Flutter通讯'),
//       ),
//       body: Center(
//         child: GestureDetector(
//           onTap: () {
//             //发送消息通过invokeMethod方法
//             methodChannel.invokeMethod('dismiss');
//           },
//           child: Container(
//             alignment: Alignment.center,
//             color: Colors.red,
//             width: 100,
//             height: 40,
//             child: Text(
//               '点击返回iOS',
//               style: TextStyle(
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
