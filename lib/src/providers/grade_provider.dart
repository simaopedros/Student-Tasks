import 'dart:convert';
import 'package:appuniversitario/src/preferencias_usuarios/preferencias_usuarios.dart';
import 'package:http/http.dart' as http;

import 'package:appuniversitario/src/models/grade_model.dart';

class GradeProvider {

   final String _url = "https://meusapp-931b4.firebaseio.com";
   final _prefs = new PreferenciasUsuario();
   
  
  Future<bool> criarGrade(GradeModel grade) async {
    
    final url = "$_url/${ _prefs.usuario }/grades.json?auth=${_prefs.token}";
    await http.post(url, body: gradeModelToJson(grade));
    return true;
  }

  
  Future<bool> deletarGrade(String id) async {
   

    final url = "$_url/${ _prefs.usuario }/grades/$id.json?auth=${_prefs.token}";
    await http.delete(url);
    return true;
  }


  Future<bool> editarGrade(GradeModel grade) async {
    
    final url = "$_url/${ _prefs.usuario }/grades/${ grade.id }.json?auth=${_prefs.token}";
    print(url);
    await http.put(url, body: gradeModelToJson(grade));
    return true;
  }


  
  
  Future<List<GradeModel>> carregarGrades() async {    
    
    final url = "$_url/${ _prefs.usuario }/grades.json?auth=${_prefs.token}";  
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