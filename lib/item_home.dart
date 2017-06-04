import 'dart:async';
import 'package:flutter/material.dart';

import 'item_data.dart';
import 'item_list.dart';

enum ItemHomeTab { inventory, shoppingList, settings }

class ItemHome extends StatefulWidget {
  @override
  ItemHomeState createState() => new ItemHomeState();
}

class ItemHomeState extends State<ItemHome> {
  List<Item> items = new List<Item>();
  bool _isSearching = false;
  final TextEditingController _searchQuery = new TextEditingController();

  void _openPage() {
    Navigator.of(context).pushNamed('/item/-1');
  }

  void _increaseQuantity(Item item) {
    setState(() {
      item.quantity++;
    });
    Inventory.save(item);
  }

  void _decreaseQuantity(Item item) {
    setState(() {
      if (item.quantity > 0) {
        item.quantity--;
      }
    });
    Inventory.save(item);
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

  Future<Iterable<Item>> _getItemList() async {
    return await Inventory.getItems();
  }

  Iterable<Item> _filterBySearchQuery(Iterable<Item> items) {
    if (_searchQuery.text.isEmpty)
      return items;
    final RegExp regexp = new RegExp(_searchQuery.text, caseSensitive: false);
    return items.where((Item item) => item.name.contains(regexp));
  }

  Widget _buildItemList(BuildContext context, Iterable<Item> items, ItemHomeTab tab) {
    return new ItemList(
      items: items.toList(),
      onAction: null,
      onOpen: (Item item) {
        Navigator.pushNamed(context, '/item/${item.id}');
      },
      onShow: null,
      onQuantityUp: (Item item) {
        _increaseQuantity(item);
      },
      onQuantityDown: (Item item) {
        _decreaseQuantity(item);
      }
    );
  }

  Widget _buildItemTab(BuildContext context, ItemHomeTab tab) {
    return new Container(
      key: new ValueKey<ItemHomeTab>(tab),
      child: _buildItemList(context, _filterBySearchQuery(items), tab)
    );
  }

  void _updateItemList() {
    _getItemList().then((onValue) => setState(() {
      items = onValue;
    }));
  }

  @override
  void initState() {
    super.initState();
    _updateItemList();
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
            _buildItemTab(context, ItemHomeTab.inventory),
            null,
            null
          ],
        ),
      ),
    );
  }
}