import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
  //var items = [];
  items.add("Potet");
  items.add("Gulrot");
  items.add("Kjøtt");
  items.add("Epler");
  items.add("Buljong");
  items.add("Egg");
  items.add("Makaroni");
  items.add("Dopapir");
  items.add("Vaskemiddel");
  items.add("Smør");
  items.add("Zalo");
}

TextEditingController newItemController = TextEditingController();
List<String> items = ["Dopapir"];

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
                    controller: newItemController,
                  )),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          addToList();
                        });
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
                        itemCount: items.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: ListTile(
                              title: Text(items[index]),
                              trailing: Icon(Icons.done),
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
  items.add(newItemController.text);
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
