import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Item {
  int id = -1;
  String name;

  String toString() {
    return 'id: ' + this.id.toString() + '\n' +
           'name: ' + this.name;
  }
}

// collection of all items
class Inventory {
  static Database itemsDB;

  // gets the database path
  static Future<String> getDatabasePath(String filename) async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    return file.path;
  }

  // creates or opens the database and assigns it to `itemsDB`
  static Future load() async {
    print("Loading database...");
    String path = await getDatabasePath("items.db");
    itemsDB = await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
        print("Creating itemsDB...");
        await db.execute(
          "CREATE TABLE Items (id INTEGER PRIMARY KEY, name TEXT)"
        );
      },
    );
  }

  // saves a new item or updates an existing one
  static Future save(Item item) async {
    print("Saving Item '${item.name}' to database...");
    if (item.id == -1) { // insert
      await itemsDB.inTransaction(() async {
        await itemsDB.insert(
          'INSERT INTO Items(name) VALUES(?)', [item.name]
        );
      });
    } else { // update
      await itemsDB.update(
        'UPDATE Items SET name = ? WHERE id = ?', [item.name, item.id]
      );
    }
  }

  // converts map to item object
  static Item _getItemFromMap(Map map) {
    Item item = new Item();
    item.id = map["id"];
    item.name = map["name"];
    return item;
  }

  // gets all items in database
  static Future<List<Item>> getItems() async {
    print("Getting all items from database...");
    List<Item> items = new List<Item>();
    if (itemsDB == null){
      print("Can't find database!");
      await load();
    }
    List<Map> map = await itemsDB.query('SELECT * FROM Items');
    for (int i = 0; i < map.length; i++) {
      items.add(_getItemFromMap(map[i]));
    }

    return items;
  }

  // gets an item by id
  static Future<Item> get(int id) async {
    List<Map> map = await itemsDB.query('SELECT * FROM Items WHERE id = ?', [id]);
    return _getItemFromMap(map[0]);
  }

  // deletes an item by id
  static Future delete(int id) async {
    await itemsDB.delete(
      'DELETE FROM Items WHERE id = ?', [id]
    );
  }
}