import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:prueba_tecnica/models/university_response.dart';

class UniversityProvider with DiagnosticableTreeMixin, ChangeNotifier {
  final String _baseUrl = 'tyba-assets.s3.amazonaws.com';

  List<UniversityResponse> universities = [];

  int universitiesPage = 0;
  bool changeGrid = false;

  setChangeGrid() {
    changeGrid = !changeGrid;
    notifyListeners();
  }

  UniversityProvider() {
    getOnDisplayUniversity();
  }

  List<UniversityResponse> _parseUniversities(responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed
        .map<UniversityResponse>(
            (json) => UniversityResponse.fromJson(jsonEncode(json)))
        .toList();
  }

  getOnDisplayUniversity() async {
    universitiesPage++;
    var url = Uri.https(_baseUrl, 'FE-Engineer-test/universities.json');

    var response = await http.get(url);
    List<UniversityResponse> universityResponse =
        _parseUniversities(response.body);

    universities = [
      ...universities,
      ...universityResponse.sublist(
          (20 * universitiesPage), (20 * (universitiesPage + 1)))
    ];

    notifyListeners();
  }

  getOneUniniversity(int index) {
    notifyListeners();
    return universities[index];
  }
}
