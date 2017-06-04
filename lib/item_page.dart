import 'package:flutter/material.dart';

import 'item_data.dart';

class ItemPage extends StatefulWidget {
  ItemPage({Key key, this.title, this.id}) : super(key: key);

  final String title;
  final int id;

  @override
  _ItemPageState createState() => new _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  Item item = new Item();
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _quantityController = new TextEditingController();

  void _delete() {
    Inventory.delete(widget.id);
    Navigator.of(context).pop();
  }

  void _save() {
    item.name = _nameController.text;
    item.quantity = int.parse(_quantityController.text);
    Inventory.save(item);
    Navigator.of(context).pop();
  }

  void _getItem(int id) {
    Inventory.get(id).then((onValue) => setState(() {
      item = onValue;
      print("$item");
      _nameController.text = item.name;
      _quantityController.text = item.quantity.toString();
    }));
  }

  @override
  void initState() {
    super.initState();
    print("Viewing item with ID: ${widget.id}");
    if (widget.id > -1) {
      _getItem(widget.id);
    } else {
      _quantityController.text = "1";
    }
  }

  Widget _buildNewItemAppBar() {
    return new AppBar(
      title: new Text(widget.title),
      actions: <Widget>[
        new IconButton(
          icon: new Icon(Icons.done),
          tooltip: 'Save',
          onPressed: _save,
        ),
      ],
    );
  }

  Widget _buildOldItemAppBar() {
    return new AppBar(
      title: new Text(widget.title),
      actions: <Widget>[
        new IconButton(
          icon: new Icon(Icons.delete),
          tooltip: 'Delete',
          onPressed: _delete,
        ),
        new IconButton(
          icon: new Icon(Icons.done),
          tooltip: 'Save',
          onPressed: _save,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: (widget.id > -1) ? _buildOldItemAppBar() : _buildNewItemAppBar(),
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
              controller: _quantityController,
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