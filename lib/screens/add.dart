import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class AddCard extends StatefulWidget {
  const AddCard({Key? key}) : super(key: key);

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
                  buildTextFormField(
                      "Title", "title", 'title', TextInputType.name),
                  buildTextFormField("Description", "description",
                      'description', TextInputType.name),
                  buildStatusDropDown(),
                  buildSellButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextFormField(
      String label, String hint, String fillIn, TextInputType inputType) {
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
        hintText: hint,
        labelStyle: TextStyle(color: theme.secondaryColor),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: theme.tertiaryColor)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: theme.secondaryColor, width: 1.3)),
      ),
      cursorColor: theme.secondaryColor,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
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

  Widget buildSellButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            primary: theme.secondaryColor.withOpacity(0.8),
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
              "Sell",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
