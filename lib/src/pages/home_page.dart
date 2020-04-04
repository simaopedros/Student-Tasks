import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _barraSuperior(),
            ],
          ),
        ));
  }

  AppBar _appBar(){
    return AppBar(
          title: Row(
            children: <Widget>[
              Text("Students", style: GoogleFonts.roboto(fontWeight: FontWeight.w300)),
              Text("Task", style: GoogleFonts.roboto(fontWeight: FontWeight.bold),),
            ],
          ),
          backgroundColor: Color.fromRGBO(57, 44, 206, 1.0),
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              onPressed: (){},
                icon: Icon(
              Icons.note_add,
              color: Colors.white,
            )),
            IconButton(
              onPressed: (){},
                icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ))
          ],
        );
  }
  
  
  Widget _barraSuperior() {
    return Container(
      height: 150.0,
      width: double.infinity,
      color: Color.fromRGBO(57, 44, 206, 1.0),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(5.0),
              margin: EdgeInsets.symmetric(horizontal: 20.0),
             
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Nova Tarefa",
                  icon: Icon(Icons.add),
                  border: InputBorder.none
                ),
              ),
            ),
            _menuSuperios(),
          ],
        )
      ),
    );
  }

  Widget _menuSuperios(){
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlatButton(
            onPressed: (){}, 
            child: Column(
              children: <Widget>[
                Icon(Icons.event_seat, color: Colors.white,),
                Text("PROVAS", style: TextStyle(color: Colors.white),)
              ],
            )
          ),

          FlatButton(
            onPressed: (){}, 
            child: Column(
              children: <Widget>[
                Icon(Icons.view_module, color: Colors.white,),
                Text("GRADE", style: TextStyle(color: Colors.white),)
              ],
            )
          ),

          FlatButton(
            onPressed: (){}, 
            child: Column(
              children: <Widget>[
                Icon(Icons.insert_invitation, color: Colors.white,),
                Text("ESTUDOS", style: TextStyle(color: Colors.white),)
              ],
            )
          ),

          FlatButton(
            onPressed: (){}, 
            child: Column(
              children: <Widget>[
                Icon(Icons.book, color: Colors.white,),
                Text("MATERIAS", style: TextStyle(color: Colors.white),)
              ],
            )
          ),
        ],
      ),
    );
  }



}
