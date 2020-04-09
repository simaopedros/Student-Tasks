import 'package:appuniversitario/src/widget/titulo_widget.dart';
import 'package:flutter/material.dart';

class CardStory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      color: Color.fromRGBO(239, 239, 239, 1),
      height: 170,
      child: Column(
        children: <Widget>[
          Titulo("proximos", "Eventos"),
          SizedBox(
            height: 10.0,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                _cardStory(),
                _cardStory(),
                _cardStory(),
                _cardStory(),
                _cardStory(),
                _cardStory()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardStory() {
    return Container(
      margin: EdgeInsets.only(right: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        height: 109.0,
        width: 74.0,
        child: Center(child: Text("Ola mundo")),
      ),
    );
  }
}
