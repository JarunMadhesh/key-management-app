import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarp/Providers/addPersonProvider.dart';
import 'package:tarp/Screens/addPerson.dart';

class PeopleList extends StatelessWidget {
  const PeopleList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      child: Column(
        children: [
          SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddPerson()));
              },
              child: Text("add")),
          SizedBox(height: 20),
          Container(
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: ((context, index) => Container(
                    decoration: BoxDecoration(border: Border.all()),
                    height: 50,
                    margin: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width * 0.6,
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Text(Provider.of<PersonProvider>(context)
                            .people[index]
                            .id),
                        Text("----"),
                        Text(Provider.of<PersonProvider>(context)
                            .people[index]
                            .name),
                        Text("----"),
                        Text(Provider.of<PersonProvider>(context)
                            .people[index]
                            .dept),
                      ],
                    ),
                  )),
              itemCount: Provider.of<PersonProvider>(context).people.length,
            ),
          ),
        ],
      ),
    );
  }
}
