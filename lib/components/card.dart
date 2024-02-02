import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

// class MyCard extends StatelessWidget {
//   const MyCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.all(20),
//       height: 200,
//       // width: MediaQuery.of(context).size.width - 20,
//       color: Colors.black,
//     );
//   }
// }

class MyCard extends StatefulWidget {
  final String title;
  final String description;
  final String status;
  final int index;

  const MyCard(
      {Key? key,
      required this.title,
      required this.description,
      required this.status,
      required this.index})
      : super(key: key);

  @override
  _MyCardState createState() => _MyCardState();
}

OurTheme theme = OurTheme();
late double _width;

class _MyCardState extends State<MyCard> {
  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    return InkWell(
      child: Center(
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 10, 0, 5),
          width: _width * 0.96,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 16,
                spreadRadius: 16,
                color: Colors.black.withOpacity(0.1),
              )
            ],
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(colors: [
              const Color(0xAAFFFFFF).withOpacity(0.25),
              Color(0xAAFFFFFF).withOpacity(0.3),
              const Color(0xAAFFFFFF).withOpacity(0.25),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                        width: 1, color: Colors.white.withOpacity(0.4))),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      buildBookTitle(widget.title),
                      buildRichText("Note: ", widget.description, 12),
                    ],
                  ),
                )),
          ),
        ),
      ),
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext) =>
                buildPopupDialogue(context, widget.title));
      },
    );
  }

  Widget buildBookTitle(String bookTitle) {
    return Text(
      bookTitle,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 22.0,
        color: Colors.white,
        letterSpacing: 1,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget buildRichText(String text1, String text2, double fontSize) {
    return RichText(
      text: TextSpan(
          text: text1,
          style: TextStyle(
            color: theme.secondaryColor,
            fontWeight: FontWeight.w600,
            fontSize: fontSize,
          ),
          children: <TextSpan>[
            TextSpan(
                text: text2,
                style: TextStyle(
                    color: theme.tertiaryColor, fontWeight: FontWeight.w400)),
          ]),
    );
  }

  Widget buildPopupDialogue(BuildContext context, String title) {
    IconData contactIcon = Icons.call;

    return AlertDialog(
        backgroundColor: Colors.grey,
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: theme.secondaryColor,
                      letterSpacing: 0.7,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.fromLTRB(7, 3, 7, 3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.black45.withOpacity(0.1),
              ),
              child: Column(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      contactIcon,
                      size: 36,
                      color: theme.secondaryColor,
                    ),
                  ),
                  Text(
                    "Contact",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: theme.secondaryColor),
                  ),
                ],
              ),
            ),
          ],
        ),
        content: const Text("meow"));
  }
}
