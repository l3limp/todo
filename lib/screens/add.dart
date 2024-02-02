import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/model/todo.dart';

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
  // late CollectionReference books;
  List chips = [true, false, false];
  List cols = [Colors.redAccent, Colors.yellowAccent, Colors.greenAccent];
  List opts = ["To Do", "In Progress", "Done"];

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
                  buildTextFormField("Title", 'title', TextInputType.name),
                  buildTextFormField(
                      "Description", 'description', TextInputType.name),
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
      String label, String fillIn, TextInputType inputType) {
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
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
        labelStyle: TextStyle(color: theme.secondaryColor),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: theme.tertiaryColor)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: theme.tertiaryColor, width: 1.3)),
      ),
      cursorColor: theme.secondaryColor,
      style:
          TextStyle(fontWeight: FontWeight.bold, color: theme.secondaryColor),
      keyboardType: inputType,
    );
  }

  // Future<void> addCard(String sellerName, String sellerRoom,
  //     String sellerHostel, String sellerPhone, String contactPreference) {
  //   return books.add({
  //     'title': title,
  //     'author': description,
  //     'department': status,
  //     'seller_name': sellerName,
  //     'seller_room': sellerRoom,
  //     'seller_hostel': sellerHostel,
  //     'seller_phone': sellerPhone,
  //     'contact_preference': contactPreference,
  //   }).then((value) {
  //     const snackBar =
  //         SnackBar(content: Text("Your listing was added successfully"));
  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //   }).catchError((error) {
  //     final snackBar = SnackBar(content: Text("Failed to add book: $error"));
  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //   });
  // }

  Widget buildAddButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          ToDo todo = ToDo(title, description, 0, status);
          widget.lister.add(todo);
          Navigator.pop(context);
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
}
