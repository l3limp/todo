import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/screens/add.dart';
import 'package:todo/screens/edit.dart';
import 'package:todo/temp.dart';

import '../theme.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

List<ToDo> lister = [];

class _HomeState extends State<Home> {
  OurTheme theme = OurTheme();
  late double height;
  late double width;
  late CollectionReference todos;

  @override
  void initState() {
    super.initState();
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(229, 29, 13, 70),
        appBar: AppBar(
          title: const Text("Todo"),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  auth.signOut();
                  GoogleSignIn().signOut();
                  lister.clear();
                  Navigator.popAndPushNamed(
                    context,
                    '/login',
                  );
                },
                icon: const Icon(Icons.logout_rounded))
          ],
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () async {
              // print(auth.currentUser!.uid);
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
              ToDo todo = ToDo(lister[index].title, lister[index].description,
                  lister[index].id, lister[index].status);
              return buildCard(todo, index);
            },
          ),
        ),
      ),
    );
  }

  buildCard(ToDo todo, int index) {
    return InkWell(
      child: Center(
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 10, 0, 5),
          width: width * 0.96,
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
              const Color(0xAAFFFFFF).withOpacity(0.3),
              const Color(0xAAFFFFFF).withOpacity(0.25),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(
                        width: 1, color: Colors.white.withOpacity(0.4))),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        // alignment: Alignment.centerRight,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: todo.status == 'In Progress'
                                ? Colors.orange
                                : todo.status == 'Done'
                                    ? Colors.green
                                    : Colors.redAccent,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(6),
                                bottomRight: Radius.circular(6))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              todo.title.length > 20
                                  ? '${todo.title.substring(0, 28)}...'
                                  : todo.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              todo.status,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        todo.description,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 22.0,
                          color: Colors.white,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ),
      onTap: () async {
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
