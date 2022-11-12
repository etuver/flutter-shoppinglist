import 'dart:async' show Future;
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shoppinglist/ShoppingList.dart';
import 'package:shoppinglist/main.dart';

import 'Listing.dart';

//List<ShoppingList> list = [];

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

/// Fin plass å bruk lørdagskvelden med influensa
Future<List<ShoppingList>> readAllJsonFiles() async {
  List<ShoppingList> list = [];
  final files = json
      .decode(await rootBundle.loadString('AssetManifest.json'))
      .keys
      .where((String key) => key.contains('assets/jsonlists/'))
      .toList();
  print("files: ");
  for (String file in files) {
    //print(file);
    Future<ShoppingList> future = getJsonDataByFilePath(file);
    future.then((value) => list.add(value));
  }
  return list;
}

Future<ShoppingList> getJsonDataByFilePath(String filepath) async {
  List<Listing> listings = <Listing>[];
  var jsonString = await rootBundle.loadString(filepath);
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

/// Old attempt
Future<List<ShoppingList>> getAllJsonListsOLD() async {
  List<ShoppingList> shoppinglists = <ShoppingList>[];
  var jsonString =
      await rootBundle.loadString('assets/jsonlists/emilysliste.json');
  var data = json.decode(jsonString);
  var listsRAW = data["lists"];
  if (listsRAW != null) {
    List<Listing> listings = <Listing>[];
    ShoppingList shoppingList;
    Listing listing;
    var unsortedList;
    listsRAW.forEAch((list) => {
          shoppingList = ShoppingList(listName: list["listName"]),
          unsortedList = list["listings"],
          unsortedList.forEach((rawListing) => {
                listing = Listing(name: rawListing["name"]),
                listing.checked = rawListing["checked"],
                shoppingList.addListing(listing)
              }),
          shoppinglists.add(shoppingList)
        });
  }
  return shoppinglists;
}

/// Old attempt
void loadJsonData() async {
  var jsonText =
      await rootBundle.loadString('assets/jsonlists/emilysliste.json');
  var data = json.decode(jsonText);
  String listName = data['listName'];
  print("listenavn: " + listName);
  List<Listing> listings = data['listings'];
  ShoppingList shoppingList = ShoppingList(listName: listName);
  for (int i = 0; i < listings.length; i++) {
    shoppingList.addListing(listings[i]);
  }
  //return shoppingList;
}
