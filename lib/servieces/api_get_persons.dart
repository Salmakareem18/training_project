import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:training_project/models/info_person_model.dart';
import 'package:training_project/models/person_model.dart';

class ApiGetPersons {
  Future<PopularModel> famousPerson() async {
    http.Response response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/person/popular?api_key=2dfe23358236069710a379edd4c65a6b'));
    if (response.statusCode == 200) {
      Map<String, dynamic> decoded = {};
      decoded = json.decode(response.body);
      PopularModel popularModel = PopularModel.fromJson(decoded);
      return popularModel;
    } else {
      throw Exception(
          'There Is Problem With Status Code${response.statusCode}');
    }
  }

  static Future<InfoPersonModel> infoperson({required int personId}) async {
    http.Response response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/person/$personId?api_key=2dfe23358236069710a379edd4c65a6b'));

    if (response.statusCode == 200) {
      Map<String, dynamic> decoded = json.decode(response.body);

      InfoPersonModel infoPersonModel = InfoPersonModel.fromJson(decoded);
      return infoPersonModel;
    } else {
      throw Exception(
          'There is a problem with the status code: ${response.statusCode}');
    }
  }
}
