import 'dart:async' show Future;
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shoppinglist/ShoppingList.dart';

import 'Listing.dart';

/// REads a single json-file from given path and returns as a ShoppingList object
/// the json string is decoded by the ShoppingList class
Future<ShoppingList> getShoppingListFromJsonFile(String filepath) async {
  final file = File(filepath);
  final json = await file.readAsString();
  ShoppingList shoppingList = ShoppingList.fromJson(jsonDecode(json));
  return shoppingList;
}

/// Reads all json files in the app documents directory and
/// creates a list of shoppinglists for each of the files
/// should be run on app initialization
/// directory path depends on device type (ios, android...)
Future<List<ShoppingList>> readJsonFiles() async {
  List<ShoppingList> list = [];
  List<String> files = [];

  /// Gets the documents directory on the device. directory path is dependent on device type
  final directory = await getApplicationDocumentsDirectory();

  /// Gets all files in directory where file is .json type
  List<FileSystemEntity> entities = await directory
      .list()
      .where((event) => event.path.endsWith('.json'))
      .toList();

  /// Creates a list of path strings from entities
  for (int i = 0; i < entities.length; i++) {
    files.add(entities[i].path);
  }

  ///Use the above method to read each file and put them in list
  for (int i = 0; i < files.length; i++) {
    Future<ShoppingList> future = getShoppingListFromJsonFile(files[i]);
    future.then((value) => list.add(value));
  }
  return list;
}

/// write a shoppingList as a json file
/// saved in appdata directory
/// path depending on device type
/// Takes the shoppingList object and encodes it to json
void writeListAsJSONFile(ShoppingList shoppingList) async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    String filename = "${shoppingList.listName}.json";
    File file = File("${directory.path}/$filename");
    String jsonShoppingList = jsonEncode(shoppingList);
    file.writeAsString(jsonShoppingList);
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
/// Not in use atm
String convertToJSON(ShoppingList shoppingList) {
  String jsonShoppingList = jsonEncode(shoppingList);
  return jsonShoppingList;
}

///---------------------- OLD -----------------------------------------

/// Creates a list of all jsonfiles in directory assets/jsonlists
/// Then calls method getJsonDataByFilePath to get each file read as a ShoppingList
/// returns a Future List of Shoppinglists
/// Fin plass å bruk lørdagskvelden med influensa
/// Not in use
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
/// Not in use
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
