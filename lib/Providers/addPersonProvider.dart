import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Person {
  String id;
  String name;
  String dept;

  Person(this.id, this.name, this.dept);
}

class PersonProvider extends ChangeNotifier {
  late List<Person> people;

  List<Person> returnPeople() {
    return people;
  }

  Future<void> updatePeople() async {
    final response = await http.get(Uri.parse(
        "https://tarp-33b78-default-rtdb.asia-southeast1.firebasedatabase.app/userprofile.json"));

    print(response.body);

    final extractedData = json.decode(response.body) as Map<String, dynamic>;

    List<Person> temppeople = [];
    extractedData.forEach((id, body) {
      // print(id);
      // print(body);
      // print(body["name"]);
      Person newPerson =
          Person(id.toString(), body['name'], body['department']);
      // print(newPerson.dept);
      temppeople.add(newPerson);
    });

    people = temppeople;

    notifyListeners();
  }
}

class AddPersonProvider {
  bool isFingerPrintAdded = false;

  Future addPersonToDB(String id, String name, String dept) async {
    await http.patch(
      Uri.parse(
          'https://tarp-33b78-default-rtdb.asia-southeast1.firebasedatabase.app/tarp-machine-001.json'),
      body: json.encode({
        "addFingerprint": 1,
        "fingerPrintID": int.parse(id),
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    isFingerPrintAdded = false;

    while (!isFingerPrintAdded) {
      final response = await http.get(
        Uri.parse(
            'https://tarp-33b78-default-rtdb.asia-southeast1.firebasedatabase.app/tarp-machine-001.json?'),
      );

      print(response.body);

      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      extractedData.forEach((ids, temp) {
        if (temp == 0) {
          isFingerPrintAdded = true;
        }
      });

      Future.delayed(const Duration(seconds: 1));
    }

    await http.put(
      Uri.parse(
          'https://tarp-33b78-default-rtdb.asia-southeast1.firebasedatabase.app/userprofile/' +
              id +
              ".json"),
      body: json.encode(
        {
          'name': name,
          'department': dept,
        },
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }
}
