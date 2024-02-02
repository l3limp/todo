import 'package:flutter/material.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/screens/add.dart';
import 'package:todo/screens/edit.dart';

import '../theme.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

ToDo todo = const ToDo("title", "description", 0, "status");
List<ToDo> lister = [];

class _HomeState extends State<Home> {
  OurTheme theme = OurTheme();
  late double height;
  late double width;

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
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () async {
              // Navigator.pushNamed(context, '/add');=
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
                  index, lister[index].status);
              return buildCard(
                todo,
              );
            },
          ),
        ),
      ),
    );
  }

  buildCard(ToDo todo) {
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
                      Text(
                        todo.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 22.0,
                          color: Colors.white,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        todo.description,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 22.0,
                          color: Colors.white,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        todo.status,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 22.0,
                          color: Colors.white,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                        ),
                      )
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
              index: todo.index,
            ),
          ),
        );
        setState(() {});
      },
    );
  }
}
