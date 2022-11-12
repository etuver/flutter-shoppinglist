import 'dart:async' show Future;
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shoppinglist/ShoppingList.dart';
import 'package:shoppinglist/main.dart';

import 'Listing.dart';

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
