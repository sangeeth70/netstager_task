import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:netstager_task/single_user.dart';
import 'package:http/http.dart' as http;

class UserDetails extends StatefulWidget {
  String userId;
  UserDetails({Key? key,required this.userId}) : super(key: key);

  @override
  _UserDetailsState createState() => _UserDetailsState();
}


class _UserDetailsState extends State<UserDetails> {
  
Future<SingleUser> getData() async {
  final result = await http.get(
      Uri.parse("https://dummyapi.io/data/v1/user/"+widget.userId),
      headers: {"app-id": "61dbf9b1d7efe0f95bc1e1a6"});
  final jsonData = jsonDecode(result.body);
  final user = SingleUser.fromJson(jsonData);
  return user;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Netstager',style: TextStyle(fontSize: 20,),)),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25)
            )
        ),
        backgroundColor: Color.fromARGB(255, 33, 78, 180),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<SingleUser> snapshot) {
          if (snapshot.hasData) {
            SingleUser singleUser = snapshot.data!;
            return Center(
              child: Container(height: 300,width: 300,
                child: Card(
                  child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [


                      Text('First Name: '+singleUser.firstName!,style: TextStyle(fontWeight: FontWeight.w800),),
                      Text('Email: '+singleUser.email!,style: TextStyle(fontWeight: FontWeight.w800),),
                      Text('Gender: '+singleUser.gender!,style: TextStyle(fontWeight: FontWeight.w800),),
                      Text('City: '+singleUser.location!.city!,style: TextStyle(fontWeight: FontWeight.w800),),
                    ],
                  ),
                ),
              ),
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
