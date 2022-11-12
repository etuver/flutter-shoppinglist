import 'dart:async' show Future;
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shoppinglist/ShoppingList.dart';
import 'package:shoppinglist/main.dart';

import 'Listing.dart';

List<ShoppingList> list = [];

void loadJsonData() async {
  var jsonText = await rootBundle.loadString('assets/jsonlists/testList.json');
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

Future<ShoppingList> getJsonData() async {
  List<Listing> listings = <Listing>[];
  var jsonString =
      await rootBundle.loadString('assets/jsonlists/testList.json');
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
