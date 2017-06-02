import 'package:flutter/material.dart';

import 'item_data.dart';
import 'item_list.dart';

class ItemHome extends StatefulWidget {
  @override
  ItemHomeState createState() => new ItemHomeState();
}

class ItemHomeState extends State<ItemHome> {
  void _openPage() {
    Navigator.of(context).pushNamed('/item/-1');
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve list of items
    Inventory.load();
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Inventory'),
      ),
      body: new ItemList(
        items: Inventory.toList(),
        onAction: null,
        onOpen: (Item item) {
          Navigator.pushNamed(context, '/item/${item.id}');
        },
        onShow: null,
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _openPage,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
    );
  }
}