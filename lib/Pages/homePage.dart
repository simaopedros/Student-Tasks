import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "univers.io",
          style: TextStyle(fontSize: 25.0),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.notifications,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: appBody(),
    );
  }
}

Widget appBody() {
  return SingleChildScrollView(
    child: Column(      
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(          
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Materias",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
            Container(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "nova materia",
                  textAlign: TextAlign.right,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
             child: ListView.builder(
               physics: BouncingScrollPhysics(),
               itemCount: 5,
               itemBuilder: (context, index){
                 return Text("Text", style: TextStyle(color: Colors.white),);
               }
               
             ),
            )
          ],
        ),
        ),
        
      ],
    ),
  );
}
