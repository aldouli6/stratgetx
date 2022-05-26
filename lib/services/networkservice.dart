import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:stratgetx/models/character.dart';

class RemoteServices {
  static var client = http.Client();
  static int total = 0;
  static Future<List<Character>?> fetchCharacters(
      {int limit = 10, int offset = 0}) async {
    String url =
        // ignore: prefer_adjacent_string_concatenation
        'https://gateway.marvel.com/v1/public/characters?ts=1653527496&apikey=41e01c4953827d900b06b933470fcd9d&hash=8a8d6c94292c6f3d5306317632ad30b5&' +
            'limit=$limit&offset=$offset';
    try {
      var response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var json = jsonDecode(jsonString);
        total = json['data']['total'];
        jsonString = jsonEncode(json['data']['results']);
        return characterFromJson(jsonString);
      } else {
        return null;
      }
    } catch (e) {
      Get.snackbar('Error',
          'Ups!. Something went wrong. Check your connection and try again',
          duration: const Duration(seconds: 5),
          snackPosition: SnackPosition.BOTTOM);

      return null;
    }
  }
}
