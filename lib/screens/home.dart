import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/screens/add.dart';
import 'package:todo/screens/edit.dart';
import 'package:todo/screens/splash.dart';

import '../theme.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

List<ToDo> lister = [];

List images = [
  'notes',
  'coffee-cup',
  'plant',
  'pillows',
  'burger',
  'salad',
  'spaceship',
  'plant'
];

class _HomeState extends State<Home> {
  OurTheme theme = OurTheme();
  late double height;
  late double width;
  late CollectionReference todos;

  @override
  void initState() {
    super.initState();
    //festching the todos for the logged in user from firebase
    FirebaseFirestore.instance
        .collection(auth.currentUser!.uid)
        .get()
        .then((value) => {
              value.docs.forEach((item) {
                lister.add(ToDo(
                  item['title'],
                  item['description'],
                  item.id,
                  item['status'],
                ));
              }),
              setState(() {}),
            });
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: theme.primaryColor,
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        title: Text(
          "Todo",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: theme.secondaryColor),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              color: theme.secondaryColor,
              onPressed: () {
                //flow to sign out
                auth.signOut();
                GoogleSignIn().signOut();
                lister.clear();
                Navigator.popAndPushNamed(
                  context,
                  '/',
                );
              },
              icon: const Icon(Icons.logout_rounded))
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            //directing to the add todo page
            await Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => AddCard(
                  lister: lister,
                ),
              ),
            );
            setState(() {});
          }),
      body: SizedBox(
        height: height,
        width: width,
        child: ListView.builder(
          itemCount: lister.length,
          itemBuilder: (context, index) {
            //retrieve data from the fetched list from firebase, and create cards
            ToDo todo = ToDo(lister[index].title, lister[index].description,
                lister[index].id, lister[index].status);
            return buildCard(todo, index);
          },
        ),
      ),
    );
  }

  buildCard(ToDo todo, int index) {
    return GestureDetector(
      child: Center(
        child: Container(
          margin: const EdgeInsets.fromLTRB(20, 15, 20, 5),
          width: width * 0.96,
          decoration: BoxDecoration(
            color: todo.status == 'In Progress'
                ? theme.inProgress
                : todo.status == 'Done'
                    ? theme.done
                    : theme.todo,
            boxShadow: [
              BoxShadow(
                offset: const Offset(1, 3),
                blurRadius: 4,
                spreadRadius: 2,
                color: Colors.black.withOpacity(0.5),
              )
            ],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(
                      width: 1, color: Colors.white.withOpacity(0.4))),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: (width * 0.8) - 108,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              todo.title.length > 40
                                  ? '${todo.title.substring(0, 40)}...'
                                  : todo.title,
                              style: const TextStyle(
                                fontSize: 20.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              todo.description,
                              style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w100),
                            ),
                          ]),
                    ),
                    Image.asset(
                      './assets/icons/${images[(todo.title.length + todo.description.length) % 8]}.png',
                      height: height * 0.088,
                    ),
                  ],
                ),
              )),
        ),
      ),
      onTap: () async {
        //open the edit todo page on tapping a card
        await Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => EditCard(
              lister: lister,
              index: index,
            ),
          ),
        );
        setState(() {});
      },
    );
  }
}
