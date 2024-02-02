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
                  buildStatusDropDown(),
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

  Widget buildStatusDropDown() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Status: ",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        const SizedBox(
          width: 5,
        ),
        DropdownButton<String>(
          value: status,
          dropdownColor: theme.primaryColor,
          icon: const Icon(Icons.arrow_downward),
          iconSize: 20,
          elevation: 16,
          underline: Container(
            height: 2,
          ),
          onChanged: (String? newValue) {
            setState(() {
              status = newValue!;
            });
          },
          items: <String>['To Do', 'In Progress', 'Done']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(color: theme.tertiaryColor),
              ),
            );
          }).toList(),
        ),
      ],
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
