import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:appuniversitario/src/models/grade_model.dart';

class GradeProvider {

   final String _url = "https://meusapp-931b4.firebaseio.com";

  
  Future<bool> criarGrade(GradeModel grade, String usuario) async {
    final url = "$_url/$usuario/grades.json";
    await http.post(url, body: gradeModelToJson(grade));
    return true;
  }

  
  Future<bool> deletarGrade(String id, String usuario) async {
    final url = "$_url/$usuario/grades/$id.json";
    await http.delete(url);
    return true;
  }


  Future<bool> editarGrade(GradeModel grade, String usuario) async {
    final url = "$_url/$usuario/grades/${ grade.id }.json";
    print(url);
    await http.put(url, body: gradeModelToJson(grade));
    return true;
  }


  
  
  Future<List<GradeModel>> carregarGrades(String usuario) async {    
    final url = "$_url/$usuario/grades.json";  
    print(url);  
    final resp = await http.get(url);    
    print(resp);  

    final List<GradeModel> grades = new List();

    final Map<String, dynamic> decodeGrade = json.decode(resp.body);
    print(decodeGrade); 

    if(decodeGrade == null) return [];
    
    decodeGrade.forEach((id, grade){
      print(id);
      print(grade);
      final gradTemp = GradeModel.fromJson(grade);
      gradTemp.id = id;
      grades.add(gradTemp);
    });

    
    return grades;
  }


}