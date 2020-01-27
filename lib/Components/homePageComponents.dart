import 'package:flutter/material.dart';

Widget ListMaterias() {
  return Container(
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          CardMateria("Portugues", 255, 210, 210, 210),
          CardMateria("Matematica", 255, 210, 210, 0),
          CardMateria("Algoritimo", 255, 210, 0, 210),
          CardMateria("Logica", 255, 0, 210, 210),
          CardMateria("Espanhol", 255, 0, 210, 0),
          CardMateria("Italiano", 255, 210, 0, 0),
        ],
      ),
    ),
  );
}

Widget ListAgenda() {
  return Container(
      child: SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            color: Colors.white,
            child: Row(
              children: <Widget>[
                SizedBox(width: 10.0,),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "INSERIR NOVA TAREFA",
                      labelStyle: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                      hintText: "em \"Geral\"",
                    ),
                  ),
                ),
                RaisedButton(
                  elevation: 0.0,
                  color: Colors.white,
                  child: Icon(Icons.add_circle, size: 35.0,),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
        CardToDoList("Estudar para Ingles"),
        CardToDoList("Comprar Caderdo"),
        CardToDoList("Iniciar Trabalhode Algoritimo"),
        CardToDoList("Comprar Caneta Preta"),
        CardToDoList("Ver a Media de Ingles"),
        CardToDoList("Ver a Media de Fraçes"),
        CardToDoList("COlocar passe no Cartao"),
        CardToDoList("Mais uma tarefa"),
      ],
    ),
  ));
}

Widget ListRepublicas() {
  return Container(
      height: 250.0,
      color: Colors.white,
      child: Text(
        "Lista de Republicas Aqui",
        style: TextStyle(color: Colors.black),
      ));
}

Widget CardMateria(materia, a, r, g, b) {
  return Padding(
    padding: EdgeInsets.all(2.5),
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: Color.fromARGB(a, r, g, b),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              height: 250.0,
              width: 155.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.book),
                      Text(
                        materia,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.library_books),
                      Text("MEDIA: "),
                      Text("6.5"),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(Icons.calendar_today),
                          Text(
                            "Próximo Evento",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text("Prova dia 25/09/2019"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget CardToDoList(String tarefa) {
  return Padding(
    padding: EdgeInsets.all(0.5),
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      color: Colors.white,
      elevation: 2,
      child: Container(
        height: 50.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 10.0,
            ),
            Icon(Icons.check_box_outline_blank),
            SizedBox(
              width: 10.0,
            ),
            Text(tarefa),
          ],
        ),
      ),
    ),
  );
}
