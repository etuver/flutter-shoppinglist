import 'package:flutter/material.dart';
import 'Listing.dart';
import 'ShoppingList.dart';

void main() {
  runApp(const MyApp());
  //items.add("Potet");
  //items.add("Gulrot");
  //items.add("Kjøtt");
  //items.add("Epler");
  //items.add("Buljong");
  //items.add("Egg");
  //items.add("Makaroni");
  //items.add("Dopapir");
  //items.add("Vaskemiddel");
  //items.add("Smør");
  //items.add("Zalo");
  //shoppingList.add(Listing(name: "Potet"));
  //shoppingList.add(Listing(name: "Gulrot"));
  //shoppingList.add(Listing(name: "Kjøtt"));
  //shoppingList.add(Listing(name: "Epler"));
  //shoppingList.add(Listing(name: "Buljong"));
  //shoppingList.add(Listing(name: "Egg"));
  //shoppingList.add(Listing(name: "Makaroni"));
  //shoppingList.add(Listing(name: "Brød"));
  //shoppingList.add(Listing(name: "Vaskemiddel"));
  //shoppingList.add(Listing(name: "Dopapir"));
  //shoppingList.add(Listing(name: "Smør"));
  //shoppingList.add(Listing(name: "Zalo"));
  //shoppingList.add(Listing(name: "Løk"));
  //shoppingList[5].checked = true;
  testShoppingList.addListing(Listing(name: "Potet"));
  testShoppingList.addListing(Listing(name: "Gulrot"));
  testShoppingList.addListing(Listing(name: "Kjøtt"));
  testShoppingList.addListing(Listing(name: "Epler"));
  testShoppingList.addListing(Listing(name: "Buljong"));
  testShoppingList.addListing(Listing(name: "Egg"));
  testShoppingList.addListing(Listing(name: "Makaroni"));
  testShoppingList.addListing(Listing(name: "Brød"));
  testShoppingList.addListing(Listing(name: "Vaskemiddel"));
  testShoppingList.addListing(Listing(name: "Dopapir"));
  testShoppingList.addListing(Listing(name: "Smør"));
  testShoppingList.addListing(Listing(name: "Zalo"));
  testShoppingList.addListing(Listing(name: "Løk"));
  testShoppingList.changeCheckedStatus("Løk");
  testShoppingList.changeCheckedStatus("Vaskemiddel");
  testShoppingList.changeCheckedStatus("Egg");
  testShoppingList.changeCheckedStatus("Buljong");
  testShoppingList.sortListByChecked();
  //shoppingLists.add(testShoppingList);
  if (shoppingLists.isNotEmpty) {
    selectedList = shoppingLists[0];
  } else {
    selectedList = emptyList;
  }

  //selectedList = shoppingLists[0];
}

TextEditingController newItemController =
    TextEditingController(); // add new item to list
//List<String> items = ["Dopapir"];
//List<Listing> shoppingList = [];
ShoppingList testShoppingList = ShoppingList(listName: "Handleliste");
List<ShoppingList> shoppingLists = <ShoppingList>[];
//ShoppingList selectedList = shoppingLists[0];
ShoppingList selectedList = shoppingLists[0] ?? emptyList;
//ShoppingList selectedList = ShoppingList(listName: "listName");
ShoppingList emptyList = ShoppingList(listName: "Ingen liste valgt");

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Shopping list',
        home: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              backgroundColor: Color(0xffb74093),
              title: const Text('Shopping List'),
            ),
            body: Container(
              child: Column(children: <Widget>[
                AppBar(
                  title: Text(selectedList.listName),
                ),
                Row(children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: "Varenavn",
                        border: OutlineInputBorder(),
                      ),
                      controller: newItemController,
                    ),
                  )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          if (newItemController.text.isNotEmpty &&
                              selectedList.listName != "Ingen liste valgt") {
                            setState(() {
                              addToList();
                            });
                          }
                        },
                        // child: const Text("Legg til")),
                        child: const Icon(Icons.add)),
                  )
                ]),
                selectedList.getListingsLength() == 0
                    ? const Padding(
                        padding: EdgeInsets.all(30.0),
                        child: Center(
                          child: Text("Ingen varer er lagt til"),
                        ),
                      )
                    : Expanded(
                        child: ListView(
                          //scrollDirection: Axis.vertical,
                          physics: const AlwaysScrollableScrollPhysics(),
                          //scrollDirection: Axis.vertical,
                          children: [
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              // Inner listview must be not scrollable
                              shrinkWrap: true,
                              //itemCount: items.length,
                              //itemCount: shoppingList.length,
                              itemCount: selectedList.getListingsLength(),
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                  child: ListTile(
                                    onTap: () {
                                      setState(() {
                                        selectedList.changeCheckedStatus(
                                            selectedList.listings[index].name);

                                        ///Change checked status on tap
                                      });
                                    },
                                    // title: Text(items[index]),
                                    title:
                                        Text(selectedList.listings[index].name),
                                    //trailing: Icon(Icons.done),
                                    trailing: Icon(
                                        selectedList.listings[index].checked
                                            ? Icons.done
                                            : Icons.file_download_done),
                                    tileColor: selectedList
                                            .listings[index].checked

                                        /// white if not checked, greyed out if checked
                                        ? const Color(
                                            0xFF9E9E9E) //Color(0xFF84FFFF)
                                        : null,
                                    //: Color(0xFF9E9E9E),
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      )
              ]),
            )));
  }
}

/// Scaffold key for snackbar
/// Uses key from Scaffold in _MyAppState
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

/// Add an item to the list
/// Sends a snackbar to the user
/// Clears the TextField
void addToList() {
  //shoppingList.add(Listing(name: newItemController.text.toString()));
  selectedList.addListing(Listing(name: newItemController.text.toString()));
  sendSnackBar("${newItemController.text} lagt til!", Colors.green);
  newItemController.text = "";
}

/// Sends a toast / snackbar with
/// message as a message
/// And the color as background color
void sendSnackBar(String message, Color color) {
  var snackBar = SnackBar(
    content: Text(message),
    behavior: SnackBarBehavior.floating,
    elevation: 6,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))),
    backgroundColor: color,
  );
  ScaffoldMessenger.of(_scaffoldKey.currentState!.context)
      .showSnackBar(snackBar);
  //snackbarKey.currentState?.showSnackBar(snackBar);
}

/**
 *
 *
 *
    body: Column(
    children: <Widget>[
    Row(children: [
    const Expanded(child: TextField()),
    ElevatedButton(onPressed: () {}, child: const Text("Legg til"))
    ]),
    Column(
    children: <Widget>[
    Expanded(
    child: ListView(
    children: [
    ListView.builder(
    itemCount: items.length,
    itemBuilder: (BuildContext context, int index) {
    return Card(
    child: ListTile(
    title: Text(items[index]),
    ),
    );
    },
    )
    ]))
    ],
    )
    ],
    )),
 */
