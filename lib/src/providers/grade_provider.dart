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

  Future<bool> deletarGrade(String id, String usuario) async {
    final url = "$_url/$usuario/grades/$id.json";
    await http.delete(url);
    return true;
  }


  Future<bool> editarGrade(GradeModel grade, String usuario) async {
    final url = "$_url/$usuario/grades/${ grade.id }.json";
    await http.put(url);
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


}