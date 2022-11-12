import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
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
  //testShoppingList.addListing(Listing(name: "Potet"));
  //testShoppingList.addListing(Listing(name: "Gulrot"));
  //testShoppingList.addListing(Listing(name: "Kjøtt"));
  //testShoppingList.addListing(Listing(name: "Epler"));
  //testShoppingList.addListing(Listing(name: "Buljong"));
  //testShoppingList.addListing(Listing(name: "Egg"));
  //testShoppingList.addListing(Listing(name: "Makaroni"));
  //testShoppingList.addListing(Listing(name: "Brød"));
  //testShoppingList.addListing(Listing(name: "Vaskemiddel"));
  //testShoppingList.addListing(Listing(name: "Dopapir"));
  //testShoppingList.addListing(Listing(name: "Smør"));
  //testShoppingList.addListing(Listing(name: "Zalo"));
  //testShoppingList.addListing(Listing(name: "Løk"));
  //testShoppingList.changeCheckedStatus("Løk");
  //testShoppingList.changeCheckedStatus("Vaskemiddel");
  //testShoppingList.changeCheckedStatus("Egg");
  //testShoppingList.changeCheckedStatus("Buljong");
  //testShoppingList.sortListByChecked();
  //shoppingLists.add(testShoppingList);
  //setEmptyList();
  //addTestList();
  //selectedList = shoppingLists[0];
  //if (shoppingLists.isEmpty) {
  // setEmptyList();
  //} else {
  //  selectedList = shoppingLists[0];
  //}
}

TextEditingController newItemController = TextEditingController();

/// add new item to list

TextEditingController newListController = TextEditingController();

/// Add new list
//List<String> items = ["Dopapir"];
//List<Listing> shoppingList = [];
//ShoppingList testShoppingList = ShoppingList(listName: "Handleliste");
List<ShoppingList> shoppingLists = <ShoppingList>[];
//ShoppingList selectedList = shoppingLists[0] ?? ShoppingList(listName: "Ingen liste valgt");
ShoppingList selectedList = shoppingLists.isNotEmpty
    ? shoppingLists[0]
    : ShoppingList(listName: "Ingen liste valgt");
//ShoppingList selectedList = shoppingLists[0] ?? emptyList;
//ShoppingList selectedList = ShoppingList(listName: "listName");

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
                //AppBar(
                // centerTitle: true,
                // title: Text(selectedList.listName),
                //),
                Builder(
                    builder: (context) => Center(
                          child: shoppingLists.isEmpty
                              ? MaterialButton(
                                  minWidth: 100000,
                                  height: 70,
                                  color: Colors.blue,
                                  onPressed: () {
                                    setState(() {
                                      //openAddListDialog();
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title:
                                                  const Text("Legg til liste"),
                                              content: TextField(
                                                decoration:
                                                    const InputDecoration(
                                                  hintText: "Listenavn",
                                                  border: OutlineInputBorder(),
                                                ),
                                                controller: newListController,
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                    onPressed: () {
                                                      newListController.text =
                                                          "";
                                                      Navigator.pop(context);
                                                    },
                                                    child:
                                                        const Text("Avbryt")),
                                                TextButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        addNewList(
                                                            newListController
                                                                .text);
                                                        newListController.text =
                                                            "";
                                                        Navigator.pop(context);
                                                      });
                                                    },
                                                    child:
                                                        const Text("Legg til"))
                                              ],
                                            );
                                          });
                                    });
                                  },
                                  child: const Text("Legg til ny liste"))
                              : MaterialButton(
                                  minWidth: 100000,
                                  height: 70,
                                  color: Colors.blue,
                                  onPressed: () {
                                    setState(() {
                                      List<String> items =
                                          getScrollpickerItems();
                                      showMaterialScrollPicker<String>(
                                        title: "Velg handleliste",
                                        context: context,
                                        items: items,
                                        selectedItem: items[0],
                                        onChanged: (value) => setState(() => {
                                              value == "Opprett ny liste"
                                                  ? showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          title: const Text(
                                                              "Legg til liste"),
                                                          content: TextField(
                                                            decoration:
                                                                const InputDecoration(
                                                              hintText:
                                                                  "Listenavn",
                                                              border:
                                                                  OutlineInputBorder(),
                                                            ),
                                                            controller:
                                                                newListController,
                                                          ),
                                                          actions: <Widget>[
                                                            TextButton(
                                                                onPressed: () {
                                                                  newListController
                                                                      .text = "";
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: const Text(
                                                                    "Avbryt")),
                                                            TextButton(
                                                                onPressed: () {
                                                                  setState(() {
                                                                    addNewList(
                                                                        newListController
                                                                            .text);
                                                                    newListController
                                                                        .text = "";
                                                                    Navigator.pop(
                                                                        context);
                                                                  });
                                                                },
                                                                child: const Text(
                                                                    "Legg til"))
                                                          ],
                                                        );
                                                      })
                                                  :
                                                  //handleListPicker(value),
                                                  handleListPicker(
                                                      value, context)
                                            }),
                                      );
                                      //openListPicker(context);
                                    });
                                  },
                                  child: Text(selectedList.listName)),
                        )),

                Row(children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),

                    /// Text field for new listing
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

                    /// Button to add new listing
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

                /// Show placeholder if list is empty / no list
                selectedList.getListingsLength() == 0 || shoppingLists.isEmpty
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

/// Creates a empty list with placeholder name,
/// not good solution, only for testing

void setEmptyList() {
  if (shoppingLists.isNotEmpty) {
    selectedList = shoppingLists[0];
  } else {
    ShoppingList emptyList = ShoppingList(listName: "Ingen liste valgt");
    selectedList = emptyList;
  }
}

/// generate tabs for tabbar, not in use
List<Tab> generateTabs() {
  List<Tab> tabs = [];
  for (int i = 0; i < shoppingLists.length; i++) {
    tabs.add(Tab(
      text: shoppingLists[i].listName,
    ));
  }
  return tabs;
}

/// Adds a test list to shoppinglists
void addTestList() {
  ShoppingList testList = ShoppingList(listName: "En list for test");
  shoppingLists.add(testList);
  selectedList = testList;
}

/// Not in use
void openSimpleDialogSelector(BuildContext context) {
  showDialog(
      context: context,
      builder: (_) => const AlertDialog(
            title: Text("yeye"),
            content: Text("yes"),
          ));
}

/// Old version
/// not in use
void openListPicker(BuildContext context) {
  List<String> items = getScrollpickerItems();
  showMaterialScrollPicker<String>(
    title: "Velg handleliste",
    context: context,
    items: items,
    selectedItem: items[0],
    onChanged: (value) => {
      //handleListPicker(value),
      _scaffoldKey.currentState?.setState(() {
        handleListPicker(value, context);
      })
    },
  );
  _scaffoldKey.currentState?.setState(() {});
}

/// Checks if a list by listname already exists
bool checkIfListExists(String listName) {
  for (int i = 0; i < shoppingLists.length; i++) {
    if (shoppingLists[i].listName == listName) {
      return true;
    }
  }
  return false;
}

/// Old version
/// Not in use
void handleListPicker2(String picked) {
  bool found = false;
  for (int i = 0; i < shoppingLists.length; i++) {
    if (shoppingLists[i].listName == picked) {
      selectedList = shoppingLists[i];
      found = true;
    }
  }
  if (!found && picked == "Opprett ny liste") {
    if (!checkIfListExists(picked)) {
      shoppingLists.add(ShoppingList(listName: "listeliste"));
    }
  }
  //_scaffoldKey.currentState?.setState(() {});
}

/// Handles the listPicker dialog
void handleListPicker(String picked, BuildContext context) {
  if (checkIfListExists(picked)) {
    for (int i = 0; i < shoppingLists.length; i++) {
      if (shoppingLists[i].listName == picked) {
        selectedList = shoppingLists[i];
      }
    }
  }
}

/// Open a dialog to add new liste
/// Not in use, having dialog in the body instead
void openAddListDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Legg til liste"),
          content: TextField(
            decoration: const InputDecoration(
              hintText: "Listenavn",
              border: OutlineInputBorder(),
            ),
            controller: newListController,
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Avbryt")),
            TextButton(
                onPressed: () {
                  addNewList(newListController.text);
                  Navigator.pop(context);
                },
                child: const Text("Legg til"))
          ],
        );
      });
}

/// Opens a dialog with input field for a new list
/// not in use
void openAddListDialog_OLD() {
  AlertDialog(
    title: const Text("Legg til liste"),
    content: TextField(
      decoration: const InputDecoration(
        hintText: "Listenavn",
        border: OutlineInputBorder(),
      ),
      controller: newListController,
    ),
    actions: <Widget>[
      TextButton(onPressed: () {}, child: const Text("Avbryt")),
      TextButton(
          onPressed: () {
            addNewList(newListController.text);
          },
          child: const Text("Legg til"))
    ],
  );
}

/// Add new list to shoppingLists
/// And sets it as selectedlist
void addNewList(String listName) {
  if (!checkIfListExists(listName) && listName.isNotEmpty) {
    shoppingLists.add(ShoppingList(listName: listName));
    sendSnackBar("$listName lagt til!", Colors.green);
    for (int i = 0; i < shoppingLists.length; i++) {
      if (shoppingLists[i].listName == listName) {
        selectedList = shoppingLists[i];
      }
    }
  }
}

/// Get a list of listnames for the scrollpicker dialog
List<String> getScrollpickerItems() {
  List<String> list = [];
  list.add("Opprett ny liste");
  for (int i = 0; i < shoppingLists.length; i++) {
    list.add(shoppingLists[i].listName);
  }
  return list;
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
