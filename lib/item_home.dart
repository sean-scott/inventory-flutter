import 'package:flutter/material.dart';

import 'item_data.dart';
import 'item_list.dart';

class ItemHome extends StatefulWidget {
  @override
  ItemHomeState createState() => new ItemHomeState();
}

class ItemHomeState extends State<ItemHome> {

  bool _isSearching = false;
  final TextEditingController _searchQuery = new TextEditingController();

  void _openPage() {
    Navigator.of(context).pushNamed('/item/-1');
  }

  void _handleSearchBegin() {
    ModalRoute.of(context).addLocalHistoryEntry(new LocalHistoryEntry(
      onRemove: () {
        setState(() {
          _isSearching = false;
          _searchQuery.clear();
        });
      },
    ));
    setState(() {
      _isSearching = true;
    });
  }

  void _handleSearchEnd() {
    Navigator.pop(context);
  }

  Widget buildAppBar() {
    return new AppBar(
      title: new Text('Inventory'),
      actions: <Widget> [
        new IconButton(
          icon: const Icon(Icons.view_array),
          onPressed: null,
          tooltip: 'Barcode',
        ),
        new IconButton(
          icon: const Icon(Icons.search),
          onPressed: _handleSearchBegin,
          tooltip: 'Search',
        ),
      ],
      bottom: new TabBar(
        tabs: <Widget> [
          new Tab(icon: new Icon(Icons.home)),
          new Tab(icon: new Icon(Icons.shopping_cart)),
          new Tab(icon: new Icon(Icons.settings)),
        ],
      ),
    );
  }

  Widget buildSearchBar() {
    return new AppBar(
      leading: new IconButton(
        icon: const Icon(Icons.arrow_back),
        color: Theme.of(context).accentColor,
        onPressed: _handleSearchEnd,
        tooltip: 'Back',
      ),
      title: new TextField(
        controller: _searchQuery,
        autofocus: true,
        decoration: const InputDecoration(
          hintText: 'Search items',
        ),
      ),
      backgroundColor: Theme.of(context).canvasColor,
    );
  }

  Widget buildFloatingActionButton() {
    return new FloatingActionButton(
      tooltip: 'Add item',
      child: const Icon(Icons.add),
      onPressed: _openPage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 3,
      child: new Scaffold(
        appBar: _isSearching ? buildSearchBar() : buildAppBar(),
        floatingActionButton: buildFloatingActionButton(),
        body: new TabBarView(
          children: <Widget> [
            new ItemList(
              items: Inventory.toList(),
              onAction: null,
              onOpen: (Item item) {
                Navigator.pushNamed(context, '/item/${item.id}');
              },
              onShow: null
            ),
            // TODO: replace with Shopping List
            new ItemList(
              items: Inventory.toList(),
              onAction: null,
              onOpen: (Item item) {
                Navigator.pushNamed(context, '/item/${item.id}');
              },
              onShow: null
            ),
            // TODO: replace with Settings
            new ItemList(
              items: Inventory.toList(),
              onAction: null,
              onOpen: (Item item) {
                Navigator.pushNamed(context, '/item/${item.id}');
              },
              onShow: null
            )
          ],
        ),
      ),
    );
  }
}