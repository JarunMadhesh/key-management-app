import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarp/Providers/addPersonProvider.dart';
import 'package:tarp/Screens/addPerson.dart';
import 'package:tarp/Screens/logs.dart';
import 'package:tarp/Screens/peopleList.dart';

import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tarp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MultiProvider(providers: [
        ChangeNotifierProvider(create: (context) => PersonProvider()),
      ], child: const MyHomePage(title: 'Tarp')),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final _pages = [const PeopleList(), const Logs()];

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      isLoading = true;
    });

    // () async {
    update();
    // };

    setState(() {
      isLoading = false;
    });
  }

  Future<void> update() async {
    await Provider.of<PersonProvider>(context, listen: false).updatePeople();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Scaffold(
            body: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _selectedIndex,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.add),
                  label: "Add person",
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.track_changes),
                  label: "Logs",
                )
              ],
              onTap: (index) {
                _selectedIndex = index;
                setState(() {});
              },
            ),
            body: RefreshIndicator(
                onRefresh: update,
                child: Center(child: _pages.elementAt(_selectedIndex))),
          );
  }
}
