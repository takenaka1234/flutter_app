import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        //visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      //home: FirstPage(),  // homeかinitialRoute & routes どちらかのみ
      initialRoute: '/',
      routes: {
        '/': (context) => FirstPage(),
        '/second': (context) => SecondPage('second'),
      },
    );
  }
}

class FirstPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('First Page')),
      body: Center(
        child: RaisedButton(
          // push先からの戻り時に値を受け取るための非同期処理
          onPressed: () {
            // push(context, Route)で遷移先を指定
            // pushName(context, Route, arguments)で遷移先を指定(NamedRoute)
            Navigator.pushNamed(
                context,
                '/second',
                arguments: 'Hello Second!'
            );
            print('test'); // コンソール出力
          },
          child: Text('Next Page'),
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  final String messageFromFirst;
  // コンストラクタ
  SecondPage(this.messageFromFirst);

  Widget build(BuildContext context) {
    // NamedRoutesから値を受け取る
    final messageFromFirst = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(title: const Text('Second Page')),
      body: Center(
        child:
          RaisedButton(
            onPressed: (){
              // pop(context)でpush元の画面に戻る
              Navigator.pop<String>(context, 'Back To First');
            },
            child: Text(messageFromFirst),
          ),
      )
    );
  }
}