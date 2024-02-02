import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/temp.dart';

import '../theme.dart';

class EditCard extends StatefulWidget {
  List<ToDo> lister;
  int index;

  EditCard({
    Key? key,
    required this.lister,
    required this.index,
  }) : super(key: key);

  @override
  _EditCardState createState() => _EditCardState();
}

class _EditCardState extends State<EditCard> {
  OurTheme theme = OurTheme();
  late String status;
  late String id;
  late String title;
  late String description;
  late List chips;

  // late CollectionReference books;

  @override
  void initState() {
    super.initState();
    title = widget.lister[widget.index].title;
    description = widget.lister[widget.index].description;
    status = widget.lister[widget.index].status;
    id = widget.lister[widget.index].id;
    chips = [status == 'To Do', status == 'In Progress', status == 'Done'];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: theme.primaryColor,
        appBar: AppBar(
          backgroundColor: theme.primaryColor,
          centerTitle: true,
          title: Text(
            "Add a Card",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: theme.secondaryColor),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 80.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    onChanged: (text) {
                      title = text;
                    },
                    initialValue: widget.lister[widget.index].title,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: "Title",
                      labelStyle: TextStyle(color: theme.secondaryColor),
                    ),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: theme.secondaryColor),
                  ),
                  TextFormField(
                    onChanged: (text) {
                      description = text;
                    },
                    initialValue: widget.lister[widget.index].description,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: "Description",
                      labelStyle: TextStyle(color: theme.secondaryColor),
                    ),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: theme.secondaryColor),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            chips = [true, false, false];
                            status = "To Do";
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: chips[0] ? Colors.redAccent : null,
                              border: Border.all(
                                  color: chips[0]
                                      ? Colors.white
                                      : Colors.redAccent),
                              borderRadius: BorderRadius.circular(16)),
                          child: const Text(
                            "To Do",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            chips = [false, true, false];
                            status = "In Progress";
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: chips[1] ? Colors.orange : null,
                              border: Border.all(
                                  color:
                                      chips[1] ? Colors.white : Colors.orange),
                              borderRadius: BorderRadius.circular(16)),
                          child: const Text(
                            "In Progress",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            chips = [false, false, true];
                            status = "Done";
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: chips[2] ? Colors.green : null,
                              border: Border.all(
                                  color:
                                      chips[2] ? Colors.white : Colors.green),
                              borderRadius: BorderRadius.circular(16)),
                          child: const Text(
                            "Done",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      buildAddButton(),
                      buildDeleteButton(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> editTodo() {
    return FirebaseFirestore.instance
        .collection(auth.currentUser!.uid)
        .doc(id)
        .set({
      'title': title,
      'description': description,
      'status': status,
    }).then((value) {
      const snackBar =
          SnackBar(content: Text("Your Todo was edited successfully"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      widget.lister[widget.index] = ToDo(title, description, id, status);
      Navigator.pop(context);
    }).catchError((error) {
      final snackBar = SnackBar(content: Text("Failed to edit Todo: $error"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  Widget buildAddButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          editTodo();
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: theme.secondaryColor.withOpacity(0.8),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            )),
        child: const Wrap(
          children: [
            Icon(Icons.sell),
            SizedBox(
              width: 10.0,
            ),
            Text(
              "Add",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

  Future<void> deleteTodo() {
    return FirebaseFirestore.instance
        .collection(auth.currentUser!.uid)
        .doc(id)
        .delete()
        .then((value) {
      const snackBar =
          SnackBar(content: Text("Your Todo was deleted successfully"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      widget.lister.removeAt(widget.index);
      Navigator.pop(context);
    }).catchError((error) {
      final snackBar = SnackBar(content: Text("Failed to delete Todo: $error"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  Widget buildDeleteButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          deleteTodo();
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent.withOpacity(0.8),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            )),
        child: const Wrap(
          children: [
            Icon(Icons.sell),
            SizedBox(
              width: 10.0,
            ),
            Text(
              "Delete",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
