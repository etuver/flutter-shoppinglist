import 'Listing.dart';

/// Class representing a ShoppingList
/// String listName as
/// and a list of Listing's
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

  /// Removes all listings where checked == true
  void removeCheckedListings() {
    listings.removeWhere((listing) => listing.checked == true);
  }

  Map toJson() => {
        "listname": listName,
        "listings": listings,
      };

  factory ShoppingList.fromJson(dynamic json) {
    ShoppingList shoppingList = ShoppingList(listName: json["listname"]);
    List<Listing> listingsfromJson = <Listing>[];
    List<dynamic> jsonListings = List.from(json['listings']);

    //print(jsonListings);

    for (int i = 0; i < jsonListings.length; i++) {
      listingsfromJson.add(Listing.fromJson(jsonListings[i]));
    }

    //listingsfromJson = json["listings"];
    shoppingList.listings = listingsfromJson;
    return shoppingList;
  }
}
