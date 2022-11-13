import 'dart:async' show Future;
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shoppinglist/ShoppingList.dart';
import 'package:shoppinglist/main.dart';

import 'Listing.dart';

/// REads a single json-file from given path and returns as a ShoppingList object
Future<ShoppingList> getShoppingListFromJsonFile(String filepath) async {
  final file = File(filepath);
  final json = await file.readAsString();
  var data = jsonDecode(json);
  //String listname = data['listname'];
  //print("json: " + data);
  ShoppingList shoppingList = ShoppingList.fromJson(jsonDecode(json));
  print("shoppinglist: " + shoppingList.listName);
  return shoppingList;
}

/// Reads all json files in the app documents directory and
/// creates a list of shoppinglists for each of the files
/// should be run on app initialization
/// directory path depends on device type (ios, android...)
Future<List<ShoppingList>> readJsonFiles() async {
  List<ShoppingList> list = [];
  List<String> files = [];
  final directory = await getApplicationDocumentsDirectory();
  List<FileSystemEntity> entities = await directory
      .list()
      .where((event) => event.path.endsWith('.json'))
      .toList();
  //final Iterable<File> files = entities.whereType<File>();

  for (int i = 0; i < entities.length; i++) {
    files.add(entities[i].path);
  }
  for (int i = 0; i < files.length; i++) {
    Future<ShoppingList> future = getShoppingListFromJsonFile(files[i]);
    future.then((value) => list.add(value));
  }
  //files.forEach(print);
  return list;
}

/// write a shoppingList as a json file
/// saved in appdata directory
/// path depending on device type
void writeListAsJSONFile(ShoppingList shoppingList) async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    String filename = "${shoppingList.listName}.json";
    File file = File("${directory.path}/$filename");
    String jsonShoppingList = jsonEncode(shoppingList);
    file.writeAsString(jsonShoppingList);
    print("List write to file");
  } catch (e) {
    print(e);
  }
}

/// Deletes a json file found by listname
///for when a list is deleted by user
void deleteJsonfile(String listName) async {
  final directory = await getApplicationDocumentsDirectory();
  String filename = "$listName.json";
  File file = File("${directory.path}/$filename");
  try {
    file.delete();
  } catch (e) {
    print(e);
  }
}

/// encode a shoppinglist to Json object
String convertToJSON(ShoppingList shoppingList) {
  String jsonShoppingList = jsonEncode(shoppingList);
  return jsonShoppingList;
}

/// Creates a list of all jsonfiles in directory assets/jsonlists
/// Then calls method getJsonDataByFilePath to get each file read as a ShoppingList
/// returns a Future List of Shoppinglists
/// Fin plass å bruk lørdagskvelden med influensa
Future<List<ShoppingList>> readAllJsonFiles() async {
  List<ShoppingList> list = [];
  final files = json
      .decode(await rootBundle.loadString('AssetManifest.json'))
      .keys
      .where((String key) => key.contains('assets/jsonlists/'))
      .toList();
  //print("files: ");
  for (String file in files) {
    //print(file);
    Future<ShoppingList> future = getJsonDataByFilePath(file);
    future.then((value) => list.add(value));
  }
  return list;
}

/// reads a single jsonfile and returns as Shoppinglist
Future<ShoppingList> getJsonDataByFilePath(String filepath) async {
  List<Listing> listings = <Listing>[];
  var jsonString = await rootBundle.loadString(filepath);
  //print(jsonString);
  var data = json.decode(jsonString);
  String listName = data['listName'];
  //print("listname: $listName");
  var listingsRaw = data["listings"];
  if (listingsRaw != null) {
    //listings = <Listing>[];
    Listing listing;
    listingsRaw.forEach((item) => {
          listing = Listing(name: item["name"]),
          listing.checked = item["checked"],
          listings.add(listing),
        });
  }
  ShoppingList shoppingList = ShoppingList(listName: listName);
  for (int i = 0; i < listings.length; i++) {
    shoppingList.addListing(listings[i]);
  }
  return shoppingList;
}

/////////////////////////////////////////////// OLD ////////////////////////////////////

///reads a single json file and returnds as future shoppinglist
///Not in use
Future<ShoppingList> getJsonData() async {
  List<Listing> listings = <Listing>[];
  var jsonString =
      await rootBundle.loadString('assets/jsonlists/emilysliste.json');
  //print(jsonString);
  var data = json.decode(jsonString);
  String listName = data['listName'];
  print("listname: $listName");
  var listingsRaw = data["listings"];
  if (listingsRaw != null) {
    //listings = <Listing>[];
    Listing listing;
    listingsRaw.forEach((item) => {
          listing = Listing(name: item["name"]),
          listing.checked = item["checked"],
          listings.add(listing),
        });
  }
  ShoppingList shoppingList = ShoppingList(listName: listName);
  for (int i = 0; i < listings.length; i++) {
    shoppingList.addListing(listings[i]);
  }
  return shoppingList;
}
