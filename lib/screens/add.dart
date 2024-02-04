import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/screens/splash.dart';

import '../theme.dart';

class AddCard extends StatefulWidget {
  List<ToDo> lister;

  AddCard({
    Key? key,
    required this.lister,
  }) : super(key: key);

  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  OurTheme theme = OurTheme();
  String status = "To Do";

  String title = "";
  String description = "";
  List chips = [true, false, false];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: theme.primaryColor,
        appBar: AppBar(
          foregroundColor: theme.secondaryColor,
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
                  buildTextFormField("Title", 'title', TextInputType.name),
                  buildTextFormField(
                      "Description", 'description', TextInputType.name),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            chips = [true, false, false];
                            status = "To Do";
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: chips[0] ? theme.todo : null,
                              border: Border.all(
                                  color: chips[0] ? Colors.white : theme.todo),
                              borderRadius: BorderRadius.circular(16)),
                          child: const Text(
                            "To Do",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            chips = [false, true, false];
                            status = "In Progress";
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: chips[1] ? theme.inProgress : null,
                              border: Border.all(
                                  color: chips[1]
                                      ? Colors.white
                                      : theme.inProgress),
                              borderRadius: BorderRadius.circular(16)),
                          child: const Text(
                            "In Progress",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            chips = [false, false, true];
                            status = "Done";
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: chips[2] ? theme.done : null,
                              border: Border.all(
                                  color: chips[2] ? Colors.white : theme.done),
                              borderRadius: BorderRadius.circular(16)),
                          child: const Text(
                            "Done",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  buildAddButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextFormField(
      final String label, String fillIn, TextInputType inputType) {
    return TextFormField(
      onChanged: (text) {
        switch (fillIn) {
          case 'title':
            title = text;
            break;
          case 'description':
            description = text;
            break;
          default:
            print("idk");
            break;
        }
      },
      maxLines: fillIn == 'description' ? 10 : null,
      cursorColor: Colors.white,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        border: const OutlineInputBorder(),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        labelText: label,
        labelStyle: TextStyle(color: theme.secondaryColor),
      ),
      style:
          TextStyle(fontWeight: FontWeight.bold, color: theme.secondaryColor),
      keyboardType: inputType,
    );
  }

  Future<void> addTodo() {
    // push changes to firebase on adding a todo
    return FirebaseFirestore.instance.collection(auth.currentUser!.uid).add({
      'title': title,
      'description': description,
      'status': status,
    }).then((value) {
      const snackBar = SnackBar(
        content: Text("Your Todo was added successfully"),
        duration: Duration(seconds: 1),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      ToDo todo = ToDo(title, description, value.id, status);
      widget.lister.add(todo);
      Navigator.pop(context);
    }).catchError((error) {
      final snackBar = SnackBar(content: Text("Failed to add Todo: $error"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  Widget buildAddButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          title = title.trim();
          description = description.trim();
          if (title.isNotEmpty) {
            addTodo();
          } else {
            const snackBar = SnackBar(content: Text("Title cannot be empty"));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: theme.secondaryColor.withOpacity(0.8),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            )),
        child: const Wrap(
          children: [
            Icon(Icons.sell, color: Colors.white),
            SizedBox(
              width: 10.0,
            ),
            Text(
              "Add",
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
