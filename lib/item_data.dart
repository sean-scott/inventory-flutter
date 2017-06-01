import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
/*
  items.json will look like

  {
    "0": {
      "id": 0,
      "name": "Foo"
    },
    "23": {
      "id": 23,
      "name": "Bar"
    }
  }

 */

class Item {
  int id = -1;
  String name;

  String toString(){
    return 'id: ' + this.id.toString() + '\n' +
           'name: ' + this.name;
  }
}

// collection of all items
class Inventory {
  static Map data;

  // gets map of all items
  static Future<bool> load() async {
    try {
      File file = await _getLocalFile();
      // read the variable as a string from the file.
      String contents = await file.readAsString();
      print("LOADED: " + contents);
      data = JSON.decode(contents);
      return true;
    } on FileSystemException {
      init();
      return false;
    }
  }

  // creates items.json with a max_id value set to -1
  static Future<Null> init() async {
    //print('Initializing items.json...');
    data = new Map();
    data.putIfAbsent('max_id', () => -1);
    String json = JSON.encode(data);
    await (await _getLocalFile()).writeAsString('$json');
  }

  // retrieves an item
  static Item get(int id) {
    Item item = new Item();
    if (id != -1){
      try {
        Map jsonItem = Inventory.data[id.toString()];
        item.id = jsonItem["id"];
        item.name = jsonItem["name"];
      } catch (exception){
        print(exception);
      }
    }

    return item;
  }

  // retrieves all items
  static List<Item> toList() {
    List<Item> list = new List<Item>();

    for (String key in data.keys){
      var id = int.parse(key, onError: (key) => null);
      if (id != null){
        list.add(get(id));
      }
    }

    return list;
  }

  // saves an item to the inventory
  static Future<Null> save(Item item) async {
    // assign ID
    if (item.id == -1){
      item.id = data['max_id'] + 1;
      int maxId = data.putIfAbsent('max_id', () => -1);
      data.remove('max_id');
      maxId++;
      data.putIfAbsent('max_id', () => maxId);
    }

    // convert item into map
    Map itemMap = new Map();
    itemMap.putIfAbsent('id', () => item.id);
    itemMap.putIfAbsent('name', () => item.name);

    // put it in inventory and save
    data.putIfAbsent(item.id.toString(), () => itemMap);
    String json = JSON.encode(data);
    await (await _getLocalFile()).writeAsString('$json');
  }

  // deletes an item from the inventory
  static Future<Null> remove(int id) async {
    data.remove(id.toString());
    String json = JSON.encode(data);
    await (await _getLocalFile()).writeAsString('$json');
  }

  static Future<File> _getLocalFile() async {
    // get the path to the document directory.
    String dir = (await getApplicationDocumentsDirectory()).path;
    return new File('$dir/items.json');
  }
}