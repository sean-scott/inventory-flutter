import 'package:flutter/material.dart';

import 'item_data.dart';
import 'item_home.dart';
import 'item_page.dart';

class InventoryApp extends StatefulWidget {
  @override
  InventoryAppState createState() => new InventoryAppState();
}

class InventoryAppState extends State<InventoryApp> {

  @override
  void initState() {
    super.initState();
    Inventory.load();
  }

  Route<Null> _getRoute(RouteSettings settings) {
    final List<String> path = settings.name.split('/');
    if (path[0] != '')
      return null;
    if (path[1] == 'item') {
      if (path.length != 3)
        return null;
      if (path[2] == '-1'){ // new item
        return new MaterialPageRoute<Null>(
          settings: settings,
          builder: (BuildContext context) => new ItemPage(title: 'Add Item', item: Inventory.get(-1))
        );
      } else { // old item
        var id = int.parse(path[2], onError: (source) => null);
        if (id != null) {
          return new MaterialPageRoute<Null>(
            settings: settings,
            builder: (BuildContext context) => new ItemPage(title: 'Edit Item', item: Inventory.get(id))
          );
        }
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Inventory',
      theme: new ThemeData(
        primarySwatch: Colors.brown,
      ),
      routes: <String, WidgetBuilder> {
        '/': (BuildContext context) => new ItemHome()
      },
      onGenerateRoute: _getRoute,
    );
  }
}

void main() {
  runApp(new InventoryApp());
}