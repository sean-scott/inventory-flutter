import 'package:flutter/material.dart';

import 'item_data.dart';

class ItemPage extends StatefulWidget {
  ItemPage({Key key, this.title, this.item}) : super(key: key);

  final String title;
  final Item item;

  @override
  _ItemPageState createState() => new _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  Item item = new Item();
  final TextEditingController _nameController = new TextEditingController();

  void _save() {
    item.name = _nameController.text;

    Inventory.save(item);
    // if success
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    item.id = widget.item.id;
    _nameController.text = widget.item.name;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.done),
            tooltip: 'Save',
            onPressed: _save,
          ),
        ],
      ),
      body: new Container(
        child: new ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            new TextFormField(
              controller: _nameController,
              decoration: new InputDecoration(
                labelText: 'Name',
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
  }
}