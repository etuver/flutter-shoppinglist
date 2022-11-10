import 'package:flutter/cupertino.dart';

import 'Listing.dart';

class ShoppingList {
  String listName;
  List<Listing> listings = <Listing>[];

  ShoppingList({
    required this.listName,
  });

  void addListing(Listing listing) {
    bool exists = false;
    for (int i = 0; i < listings.length; i++) {
      if (listings[i].name == listing.name) {
        exists = true;
      }
    }
    if (!exists) {
      listings.add(listing);
    }
  }

  void removeListingByName(String name) {
    for (int i = 0; i < listings.length; i++) {
      if (listings[i].name == name) {
        listings.removeAt(i);
      }
    }
  }

  void changeCheckedStatus(String name) {
    for (int i = 0; i < listings.length; i++) {
      if (listings[i].name == name) {
        listings[i].checked = !listings[i].checked;
      }
    }
  }
}
