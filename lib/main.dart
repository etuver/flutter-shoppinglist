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
  shoppingList.addListing(Listing(name: "Potet"));
  shoppingList.addListing(Listing(name: "Gulrot"));
  shoppingList.addListing(Listing(name: "Kjøtt"));
  shoppingList.addListing(Listing(name: "Epler"));
  shoppingList.addListing(Listing(name: "Buljong"));
  shoppingList.addListing(Listing(name: "Egg"));
  shoppingList.addListing(Listing(name: "Makaroni"));
  shoppingList.addListing(Listing(name: "Brød"));
  shoppingList.addListing(Listing(name: "Vaskemiddel"));
  shoppingList.addListing(Listing(name: "Dopapir"));
  shoppingList.addListing(Listing(name: "Smør"));
  shoppingList.addListing(Listing(name: "Zalo"));
  shoppingList.addListing(Listing(name: "Løk"));
  shoppingList.changeCheckedStatus("Løk");
  shoppingList.changeCheckedStatus("Vaskemiddel");
  shoppingList.changeCheckedStatus("Egg");
  shoppingList.changeCheckedStatus("Buljong");
  shoppingList.sortListByChecked();
}

TextEditingController newItemController = TextEditingController();
//List<String> items = ["Dopapir"];
//List<Listing> shoppingList = [];
ShoppingList shoppingList = ShoppingList(listName: "Handleliste");

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
                Row(children: [
                  Expanded(
                      child: TextField(
                    decoration: const InputDecoration(
                      hintText: "Varenavn",
                      border: OutlineInputBorder(),
                    ),
                    controller: newItemController,
                  )),
                  ElevatedButton(
                      onPressed: () {
                        if (newItemController.text.isNotEmpty) {
                          setState(() {
                            addToList();
                          });
                        }
                      },
                      child: const Text("Legg til"))
                ]),
                Expanded(
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
                        itemCount: shoppingList.getListingsLength(),
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: ListTile(
                              onTap: () {
                                setState(() {
                                  shoppingList.changeCheckedStatus(
                                      shoppingList.listings[index].name);
                                });
                              },
                              // title: Text(items[index]),
                              title: Text(shoppingList.listings[index].name),
                              //trailing: Icon(Icons.done),
                              trailing: Icon(
                                  shoppingList.listings[index].checked
                                      ? Icons.done
                                      : Icons.file_download_done),
                              tileColor: shoppingList.listings[index].checked
                                  ? Color(0xFF9E9E9E) //Color(0xFF84FFFF)
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
  shoppingList.addListing(Listing(name: newItemController.text.toString()));
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
