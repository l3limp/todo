import 'package:flutter/material.dart';

import '../components/card.dart';
import '../theme.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

MyCard tempCard = const MyCard(
    title: "title", description: "description", status: "status", index: 0);

class _HomeState extends State<Home> {
  // List<Widget> getList() {
  //   List<Widget> children = [];
  //   for (var i = 0; i < 10; i++) {
  //     children.add( MyCard());
  //   }
  //   return children;
  // }

  List<Widget> lister = [
    tempCard,
    tempCard,
    tempCard,
    tempCard,
  ];

  OurTheme theme = OurTheme();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(229, 29, 13, 70),
        appBar: AppBar(
          title: const Text("Todo"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              // Navigator.pushNamed(context, '/add');
              setState(() {
                lister.add(tempCard);
              });
            }),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            itemCount: lister.length,
            itemBuilder: (context, index) {
              return MyCard(
                title: index.toString(),
                description: "description",
                status: "To Do",
                index: index,
              );
            },
          ),
        ),
      ),
    );
  }
}
