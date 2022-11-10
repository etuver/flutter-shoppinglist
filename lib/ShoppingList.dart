import 'package:flutter/cupertino.dart';

import 'Listing.dart';

class ShoppingList {
  String listName;
  List<Listing> listings = <Listing>[];

  ShoppingList({
    required this.listName,
  });

  /// Add a listing to listings
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
    sortListByChecked();
  }

  /// Length of listings
  int getListingsLength() {
    return listings.length;
  }

  /// Sort the list so checked becomes last
  /// sorts checked elements lower than false elements
  void sortListByChecked() {
    listings.sort((a, b) {
      if (b.checked) {
        return -1;
      }
      return 1;
    });
  }

  /// Search for a listing by name and remove it
  void removeListingByName(String name) {
    for (int i = 0; i < listings.length; i++) {
      if (listings[i].name == name) {
        listings.removeAt(i);
      }
    }
  }

  /// Search for listing by name and change its checked status
  void changeCheckedStatus(String name) {
    for (int i = 0; i < listings.length; i++) {
      if (listings[i].name == name) {
        listings[i].checked = !listings[i].checked;
      }
    }
    sortListByChecked();
  }
}
