import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'Listing.dart';
import 'ShoppingList.dart';
import 'FileManager.dart';

void main() {
  runApp(const MyApp());
}

/// add new item/Listing to list controller
TextEditingController newItemController = TextEditingController();

/// Add new list controller
TextEditingController newListController = TextEditingController();

/// a list containing all the shoppingLists
List<ShoppingList> shoppingLists = <ShoppingList>[];

/// The selected shoppinglist
/// If shoppingLists is empty, create a placeholder list
ShoppingList selectedList = shoppingLists.isNotEmpty
    ? shoppingLists[0]
    : ShoppingList(listName: "Velg liste");
//ShoppingList selectedList = shoppingLists[0] ?? ShoppingList(listName: "Ingen liste valgt");
//ShoppingList selectedList = shoppingLists[0] ?? emptyList;

/// Scaffold key for snackbar
/// Uses key from Scaffold in _MyAppState
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

/// Load json files on initstate and into shoppinglists
class _MyAppState extends State<MyApp> {
  @override
  initState() {
    getJasonData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Shopping list',
        home: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              backgroundColor: const Color(0xffb74093),
              title: const Text('Shopping List'),
              actions: [
                /// Menu butten in the appbar, has two options: delete list and
                /// clear checked listings in selected list
                PopupMenuButton(
                    icon: const Icon(Icons.menu),
                    itemBuilder: (context) {
                      return [
                        const PopupMenuItem<int>(
                            value: 0, child: Text("Slett denne listen")),
                        const PopupMenuItem<int>(
                            value: 1, child: Text("Fjern markerte varer")),
                      ];
                    },
                    onSelected: (value) {
                      if (value == 0) {
                        setState(() {
                          removeShoppingList(selectedList.listName);
                        });
                      } else if (value == 1) {
                        setState(() {
                          selectedList.removeCheckedListings();
                          writeListAsJSONFile(selectedList);
                        });
                      }
                    })
              ],
            ),
            body: Container(
              child: Column(children: <Widget>[
                /// Shows a header which works as a button
                /// if there are no shoppinglists shows a button to create a new list
                /// if there are shoppinglists but none are selected show a button to select a list
                /// otherwise shows name of current list
                Builder(
                    builder: (context) => Center(
                          child: shoppingLists.isEmpty
                              ? MaterialButton(
                                  minWidth: 100000,
                                  height: 70,
                                  color: Colors.blue,
                                  onPressed: () {
                                    setState(() {
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
                                                        /// Alert dialog with inputfield for name to create new list
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
                                                  : handleListPicker(
                                                      value, context)
                                            }),
                                      );
                                    });
                                  },
                                  child: Text(selectedList.listName)),
                        )),

                Row(children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),

                    /// Text field for adding a new listing
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
                              selectedList.listName != "Velg liste") {
                            setState(() {
                              addToList();
                            });
                          }
                        },
                        child: const Icon(Icons.add)),
                  )
                ]),

                /// Show placeholder if there is no selectedList or if
                /// shoppingLists is empty or null
                selectedList.getListingsLength() == 0 || shoppingLists.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.all(30.0),
                        child: Center(
                          child: Text("Ingen varer er lagt til"),
                        ),
                      )
                    :

                    /// If there is a list selected shows a ListView with listings
                    Expanded(
                        child: ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: [
                            ListView.builder(
                              /// Inner listview must be not scrollable
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: selectedList.getListingsLength(),
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                  child: ListTile(
                                    onTap: () {
                                      setState(() {
                                        ///Change checked status on tap
                                        ///And re-write the list to json  to save
                                        selectedList.changeCheckedStatus(
                                            selectedList.listings[index].name);
                                        writeListAsJSONFile(selectedList);
                                      });
                                    },
                                    title:
                                        Text(selectedList.listings[index].name),
                                    trailing: Icon(

                                        /// Changes icon based on item is checked or not
                                        selectedList.listings[index].checked
                                            ? Icons.done
                                            : Icons.file_download_done),
                                    tileColor: selectedList
                                            .listings[index].checked

                                        /// white if not checked, greyed out if checked
                                        ? const Color(
                                            0xFF9E9E9E) //Color(0xFF84FFFF)
                                        : null,
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

/// Loads data from json files into shoppingLists
/// run at start - initstate
void getJasonData() {
  Future<List<ShoppingList>> future = readJsonFiles();
  future.then((value) => shoppingLists = value);
  setFirstListOrEmptyList();
}

/// Add an item to the list
/// Sends a snackbar to the user
/// Clears the TextField
void addToList() {
  selectedList.addListing(Listing(name: newItemController.text.toString()));
  sendSnackBar("${newItemController.text} lagt til!", Colors.green);
  newItemController.text = "";
  writeListAsJSONFile(selectedList);
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
}

/// Tries to set first list of shoppinglists as selectedList
/// Creates a empty list with placeholder name if shoppinglists is empty
/// used for when a shoppinglist is deleted and on start
void setFirstListOrEmptyList() {
  if (shoppingLists.isNotEmpty) {
    selectedList = shoppingLists[0];
  } else {
    ShoppingList emptyList = ShoppingList(listName: "Velg liste");
    selectedList = emptyList;
  }
}

/// Checks if a list by listname already exists
/// returns true if exists, false if not
bool checkIfListExists(String listName) {
  for (int i = 0; i < shoppingLists.length; i++) {
    if (shoppingLists[i].listName == listName) {
      return true;
    }
  }
  return false;
}

/// Handles the listPicker dialog
/// Gets a string with selected listName
/// and sets it as selectedList if it exists
void handleListPicker(String picked, BuildContext context) {
  if (checkIfListExists(picked)) {
    for (int i = 0; i < shoppingLists.length; i++) {
      if (shoppingLists[i].listName == picked) {
        selectedList = shoppingLists[i];
      }
    }
  }
}

/// Add new list to shoppingLists
/// And sets it as selectedlist
/// Also saves the new file as a json file
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
  writeListAsJSONFile(selectedList);
}

/// Removes a shoppingList by string listName and deletes the json file
void removeShoppingList(String listName) {
  shoppingLists
      .removeWhere((shoppinglist) => shoppinglist.listName == listName);
  setFirstListOrEmptyList();
  deleteJsonfile(listName);
}

/// Get a list of listnames for the scrollpicker dialog
/// Also adds the option to create new shoppingList
List<String> getScrollpickerItems() {
  List<String> list = [];
  list.add("Opprett ny liste");
  for (int i = 0; i < shoppingLists.length; i++) {
    list.add(shoppingLists[i].listName);
  }
  return list;
}

///------------------- OLD NOT IN USE ---------------------------------

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
}

/// Open a AlertDialog
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

/// Adds a test list to shoppinglists
void addTestList() {
  ShoppingList testList = ShoppingList(listName: "En list for test");
  shoppingLists.add(testList);
  selectedList = testList;
}

/// generate tabs for tabbar
/// Old, not in use
List<Tab> generateTabs() {
  List<Tab> tabs = [];
  for (int i = 0; i < shoppingLists.length; i++) {
    tabs.add(Tab(
      text: shoppingLists[i].listName,
    ));
  }
  return tabs;
}
