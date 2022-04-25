import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tarp/Providers/addPersonProvider.dart';

class AddPerson extends StatefulWidget {
  const AddPerson({Key? key}) : super(key: key);

  @override
  State<AddPerson> createState() => _AddPersonState();
}

class _AddPersonState extends State<AddPerson> {
  String id = "";
  String name = "";
  String dept = "";

  bool _isLoading = false;

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const CircularProgressIndicator()
        : Scaffold(
            appBar: AppBar(title: Text("Add Person")),
            body: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  TextField(
                    onChanged: (value) {
                      id = value;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter id number',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    onChanged: (value) {
                      name = value;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter person name',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    onChanged: (value) {
                      dept = value;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Department',
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                      onPressed: () async {
                        if (id.isNotEmpty &&
                            name.isNotEmpty &&
                            dept.isNotEmpty &&
                            isNumeric(id)) {
                          _isLoading = true;
                          await AddPersonProvider()
                              .addPersonToDB(id, name, dept);
                          _isLoading = false;
                        } else {
                          print("THappu panraa");
                        }
                      },
                      child: const Text("Submit")),
                ],
              ),
            ),
          );
  }
}
