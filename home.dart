import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List users=[];
  bool isloading=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.fetchusers();
  }
  fetchusers()async{
   var url="https://randomuser.me/api/?results=10";
   var respone= await http.get(Uri.parse(url));
   if(respone.statusCode==200){
     var item=json.decode(respone.body)['results'];
     setState(() {
       users=item;
     });
   }
   else{
     setState(() {
       users=[];
     });
   }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List'),
      ),
      body: getBody()
    );
  }
  Widget getBody(){
    List item=
        [
          "1",

          "2"
        ];
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context,index){

      return getCard(users[index]);
    });
  }
  Widget getCard(item ){
  var fullname=item['name']['title']+" "+item['name']['first']+" "+item['name']['last'] ;
  var email=item['email'];
  var profile=item['picture']['large'];
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(

        child: ListTile(
          title: Row(
            children: [
              Container(
                width: 60,
                  height: 60,
                decoration: BoxDecoration(
                  color: Colors.red,
                 image: DecorationImage(
                   fit: BoxFit.cover ,
                   image: NetworkImage(
                    profile.toString()
                   )
                 )
                ),
              ),
              SizedBox(width: 10,),
              Column(
                children: [
                  Text(fullname.toString()),
                  Text(email.toString())
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
