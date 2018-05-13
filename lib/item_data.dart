import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Item {
  int id = -1;
  String name;
  int quantity = 1;

  String toString() {
    return 'id: ${this.id}\n' +
           'name: ${this.name}\n' +
           'quantity: ${this.quantity}';
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
          "CREATE TABLE Items (id INTEGER PRIMARY KEY, name TEXT, quantity INTEGER)"
        );
      },
    );
  }

  // saves a new item or updates an existing one
  static Future save(Item item) async {
    print("=====SAVING ITEM=====\n${item.toString()}");
    if (item.id == -1) { // insert
      await itemsDB.inTransaction(() async {
        await itemsDB.rawInsert(
          'INSERT INTO Items(name, quantity) VALUES(?, ?)', [item.name, item.quantity]
        );
      });
    } else { // update
      await itemsDB.rawUpdate(
        'UPDATE Items SET name = ?, quantity = ? WHERE id = ?', [item.name, item.quantity, item.id]
      );
    }
  }

  // converts map to item object
  static Item _getItemFromMap(Map map) {
    Item item = new Item();
    item.id = map["id"];
    item.name = map["name"];
    item.quantity = map["quantity"];
    return item;
  }

  // gets all items in database
  static Future<List<Item>> getItems() async {
    print("Getting all items from database...");
    List<Item> items = new List<Item>();
    if (itemsDB == null){
      await load();
    }
    List<Map> map = await itemsDB.rawQuery('SELECT * FROM Items');
    for (int i = 0; i < map.length; i++) {
      items.add(_getItemFromMap(map[i]));
    }

    return items;
  }

  // gets an item by id
  static Future<Item> get(int id) async {
    List<Map> map = await itemsDB.rawQuery('SELECT * FROM Items WHERE id = ?', [id]);
    return _getItemFromMap(map[0]);
  }

  // deletes an item by id
  static Future delete(int id) async {
    await itemsDB.rawDelete(
      'DELETE FROM Items WHERE id = ?', [id]
    );
  }
}