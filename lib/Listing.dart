/// Simple class representing a listing for a Shoppinglist
/// used for ShoppingList
/// Can be either an item to buy or a task todo if used as todo- app
class Listing {
  String name;
  bool checked = false;

  Listing({required this.name});

  /// Maps the Listing into a Json string
  Map toJson() => {
        "name": name,
        "Checked": checked,
      };

  /// Decode a dynamic json  into a Listing object
  factory Listing.fromJson(dynamic json) {
    Listing listing = Listing(name: json["name"]);
    listing.checked = json['Checked'];
    return listing;
  }
}
