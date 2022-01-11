import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:netstager_task/user_details.dart';
import 'package:netstager_task/user_model.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

Future<List<Data>?> getData() async {
  final result = await http.get(
      Uri.parse("https://dummyapi.io/data/v1/user?limit=10"),
      headers: {"app-id": "61dbf9b1d7efe0f95bc1e1a6"});
  final jsonData = jsonDecode(result.body);

  List<Data>? data = User.fromJson(jsonData).data;
  return data;
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Netstager',style: TextStyle(fontSize: 20,),)),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25)
            )
        ),
        backgroundColor: Color.fromARGB(255, 33, 78, 180),
      ),
      body: FutureBuilder(future: getData(),
        builder: (context, AsyncSnapshot<List<Data>?> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                Data user = snapshot.data!.elementAt(index);

                return ListTile(
                  leading: ClipRRect(child: Container(child: Image.network(user.picture!),width: 40,height: 40,),borderRadius: BorderRadius.circular(40),),
                  title: Text(user.firstName!),
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserDetails(userId: user.id!,)));
                  },
                );

              },
            );
          } else {
            return const Center(
              child: Text("loading"),
            );
          }
        },
      ),
    );
  }
}
