import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ItemEstudo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.0),
      child: Column(
        children: <Widget>[
          Container(          
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            height: 40.0,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
              color: Colors.black87
              
            ),
            child: Row(
              children: <Widget>[
                Container(padding: EdgeInsetsDirectional.only(start: 10.0), child: Text("Segunda-feira", style: TextStyle(color: Colors.white),)),
                Expanded(child: Container()),
                IconButton(icon: Icon(FontAwesomeIcons.plus, size: 20.0, color: Colors.white,), onPressed: null)
              ],
            ),
            
          ),
          _item(),
          _item(),
          _item(),
          _item(),
          _item(),
        ],
      ),
    );
  }

  Widget _item(){
    return Container(
      height: 40.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: Colors.black87), right: BorderSide(color: Colors.black87), bottom: BorderSide(color: Colors.black87))
      ),
      child: Row(
        children: <Widget>[
          SizedBox(width: 10.0,),
          Text("11:30 -  12:40"),
          SizedBox(width: 25.0,),
          Text("Estudar Alemão"),

        ],
      ),
    );
  }
}
