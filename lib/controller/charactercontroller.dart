import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:stratgetx/constants.dart';
import 'package:stratgetx/models/character.dart';
import 'package:stratgetx/services/networkservice.dart';

class CharacterController extends GetxController {
  var isLoading = false.obs;
  final characterList = <Character>[].obs;
  final characterListFiltered = <Character>[].obs;
  final scrollController = ScrollController();
  var hasmore = true.obs;
  final total = 0.obs;
  int offset = 0;
  bool loadedCharacters = false;
  @override
  void onInit() {
    fetchCharacters();
    super.onInit();
    total.value = (box.hasData('total')) ? box.read('total') : 0;
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        fetchCharacters();
      }
    });
  }

  void fillList(List<Character> list) {
    characterListFiltered.value =
        characterList.value = List.from(characterList)..addAll(list);
  }

  void fetchCharacters() async {
    try {
      if (isLoading.value) return;
      isLoading(true);
      if (box.hasData('charList') && !loadedCharacters) {
        var charList = box.read('charList');
        fillList(characterFromJson(jsonEncode(charList)));
        offset = characterList.length;
      } else {
        var chars = await RemoteServices.fetchCharacters(
            limit: (offset == 0) ? 20 : 10, offset: offset);
        if (chars != null) {
          if (chars.length % 10 != 0) hasmore(false);
          fillList(chars);
          box.write('charList', characterListFiltered);
          total(RemoteServices.total);
          box.write('total', RemoteServices.total);
          offset += 10;
        }
      }
      loadedCharacters = true;
    } finally {
      isLoading(false);
    }
  }

  void filter(String filter) {
    // ignore: invalid_use_of_protected_member
    characterListFiltered.value = characterList.value.where((char) {
      final charName = char.name.toLowerCase();
      final input = filter.toLowerCase();
      return charName.contains(input);
    }).toList();
  }
}
