import 'package:flutter/material.dart';

class ItemPage extends StatefulWidget {
  ItemPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ItemPageState createState() => new _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
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
  }

}