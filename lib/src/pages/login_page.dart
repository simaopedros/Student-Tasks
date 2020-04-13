import 'package:appuniversitario/src/widget/titulo_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _zise = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          color: Color.fromRGBO(56, 44, 206, 1.0),
        ),
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Student",
                  style: GoogleFonts.roboto(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w300,
                      color: Colors.white)),
              Text(
                "Tasks",
                style: GoogleFonts.roboto(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )
            ],
          ),
        ),
        SingleChildScrollView(
          child: Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(top: 150.0),
              width: _zise.width * 0.8,
              // height: _zise.height * 0.6,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 150.0,
                    width: _zise.width*0.8,
                    child: Image(image: AssetImage("assets/181.png"), fit: BoxFit.cover,)),
                  SizedBox(height: 10.0,),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Titulo("fazer", "Login")),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "exempo@email.com.br",
                        labelText: "Email",
                        border: OutlineInputBorder()
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Ex: 125@a148",
                        labelText: "Senha",
                        border: OutlineInputBorder()
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  FlatButton(
                    onPressed: () => Navigator.pushReplacementNamed(context, "home"), 
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(child: Container()),
                          Container(
                            height: 50.0,
                            width: 260.0,
                            child: Center(child: Text("entrar", style: GoogleFonts.roboto(color: Colors.white, fontSize: 25.0),)),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(56, 44, 206, 1.0),
                              borderRadius: BorderRadius.circular(10.0)
                            ),
                          ),
                          Expanded(child: Container())
                        ],
                      ),
                    )
                  ),
                  FlatButton(
                    onPressed: null, 
                    child: Text("Criar Estudante")
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }
}
