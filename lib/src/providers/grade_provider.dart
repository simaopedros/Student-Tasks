import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:appuniversitario/src/models/grade_model.dart';

class GradeProvider {

  //!URL

  final String _url = "https://meusapp-931b4.firebaseio.com";

  //!Cria Grade

  Future<bool> criarGrade(GradeModel grade, String usuario) async {
    final url = "$_url/$usuario/grades.json";
    await http.post(url, body: gradeModelToJson(grade));
    return true;
  }

  //!Deleta Grade

  Future<bool> deletarGrade(GradeModel grade, String usuario) async {
    final url = "$_url/$usuario/grades/${ grade.id }.json";
    await http.delete(url);
    return true;
  }

  //!Busca As Grades

  Future<List<GradeModel>> carregarGrade(String usuario) async{
    final url = "$_url/$usuario/grades.json";

    final resp = await http.get(url);
    final List<GradeModel> grades = new List();

    final Map<String, dynamic> decodeGrade = json.decode(resp.body);

    if(decodeGrade == null) return [];

    decodeGrade.forEach((id, grade){
      final gradeTemp = GradeModel.fromJson(grade);
      gradeTemp.id = id;
      grades.add(gradeTemp);
    });

    return grades;
  }


  //!Cria Dia de Aula

  Future<bool> criarDiaDeAula(Diasdeaula dia, String usuario, String idMateria) async {
    final url = "$_url/$usuario/grades/$idMateria/diasdeaula.json";
    await http.post(url, body: dia.toJson());
    return true;
  }

  //!Deleta Dia de Aula

   Future<bool> deletarDiaDeAula(Diasdeaula dia, String usuario, String idMateria, String idDia) async {
    final url = "$_url/$usuario/grades/$idMateria/diasdeaula/$idDia.json";
    await http.delete(url);
    return true;
  }

  //!Carregar Dias da Semana

  Future<List<Diasdeaula>> carregarDiasDaSemana(String usuario, String idMateria) async {
    final url = "$_url/$usuario/grades/$idMateria/diasdeaula.json";

    final resp = await http.get(url);
    final List<Diasdeaula> diasDeAula = new List();

    final Map<String, dynamic> decodeDiaDeAula = json.decode(resp.body);

    if (decodeDiaDeAula == null ) return [];

    decodeDiaDeAula.forEach((id, dia){
      final diaTemp = Diasdeaula.fromJson(dia);
      diasDeAula.add(diaTemp);
    });

    return diasDeAula;
  }

  //! Criar Nota


  Future<bool> criarNota(Notas nota, String usuario, String idMateria) async {
    final url = "$_url/$usuario/grades/$idMateria/notas.json";
    await http.post(url, body: nota.toJson());
    return true;
  }


 //! Deletar Nota

Future<bool> deletarNota(Notas nota, String usuario, String idMateria, String idNota) async {
    final url = "$_url/$usuario/grades/$idMateria/notas/$idNota.json";
    await http.delete(url);
    return true;
  }


  //!Listar Notas


  Future<List<Notas>> carregarNotas(String usuario, String idMateria) async {
    final url = "$_url/$usuario/grades/$idMateria/diasdeaula.json";

    final resp = await http.get(url);
    final List<Notas> notas = new List();

    final Map<String, dynamic> decodeNotas = json.decode(resp.body);

    if (decodeNotas == null ) return [];

    decodeNotas.forEach((id, nota){
      final notaTemp = Notas.fromJson(nota);
      notas.add(notaTemp);
    });

    return notas;
  }


}