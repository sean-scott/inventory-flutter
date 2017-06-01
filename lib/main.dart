import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Inventory',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting
        // the app, try changing the primarySwatch below to Colors.green
        // and then invoke "hot reload" (press "r" in the console where
        // you ran "flutter run", or press Run > Hot Reload App in IntelliJ).
        // Notice that the counter didn't reset back to zero -- the application
        // is not restarted.
        primarySwatch: Colors.brown,
      ),
      home: new MyHomePage(title: 'Inventory'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful,
  // meaning that it has a State object (defined below) that contains
  // fields that affect how it looks.

  // This class is the configuration for the state. It holds the
  // values (in this case the title) provided by the parent (in this
  // case the App widget) and used by the build method of the State.
  // Fields in a Widget subclass are always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _openPage() {
    Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext context){
        return new Scaffold(
          appBar: new AppBar(
            title: new Text('Add Item'),
            actions: <Widget>[
              new IconButton(
                icon: new Icon(Icons.done),
                tooltip: 'Save',
                onPressed: null,
              ),
            ],
          ),
          body: new Container(
            child: new ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                new TextFormField(
                  decoration: new InputDecoration(
                    labelText: 'Name'
                  ),
                ),
                new TextFormField(
                  keyboardType: TextInputType.datetime,
                  decoration: new InputDecoration(
                    labelText: 'Date Purchased'
                  ),
                ),
                new TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: new InputDecoration(
                    labelText: 'Quantity'
                  ),
                ),
                new TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: new InputDecoration(
                    labelText: 'Value (\$)'
                  ),
                ),
                new TextFormField(
                  decoration: new InputDecoration(
                    labelText: 'Location'
                  ),
                ),
                new TextFormField(
                  decoration: new InputDecoration(
                    labelText: 'Category'
                  ),
                ),
                new TextFormField(
                  decoration: new InputDecoration(
                    labelText: 'Notes'
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance
    // as done by the _incrementCounter method above.
    // The Flutter framework has been optimized to make rerunning
    // build methods fast, so that you can just rebuild anything that
    // needs updating rather than having to individually change
    // instances of widgets.
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that
        // was created by the App.build method, and use it to set
        // our appbar title.
        title: new Text(widget.title),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _openPage,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
