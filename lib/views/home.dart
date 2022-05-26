import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stratgetx/controller/charactercontroller.dart';
import 'package:stratgetx/views/character.dart';

class Home extends GetView<CharacterController> {
  Home({Key? key}) : super(key: key);
  @override
  final CharacterController controller = Get.put(CharacterController());
  TextEditingController txtController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Marvelous"),
          actions: [
            SizedBox(
              width: 150,
              child: Center(
                  child: Obx(
                () => Text(
                  controller.characterListFiltered.length.toString() +
                      ' / ' +
                      controller.total.value.toString(),
                  style: const TextStyle(fontSize: 20),
                ),
              )),
            ),
          ],
        ),
        body: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 16,
              margin: const EdgeInsets.all(8),
              child: TextField(
                controller: txtController,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Search',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
                onChanged: controller.filter,
              ),
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                    controller: controller.scrollController,
                    itemCount: controller.characterListFiltered.length + 1,
                    itemBuilder: (context, index) {
                      if (index < controller.characterListFiltered.length) {
                        final char = controller.characterListFiltered[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 8,
                            child: ListTile(
                              title: Text(char.name),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                              ),
                              leading: ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(10), // Image border
                                  child: Image.network(
                                    char.thumbnail['path'].toString() +
                                        '/standard_small.' +
                                        char.thumbnail['extension'].toString(),
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset('assets/error.png',
                                          fit: BoxFit.cover);
                                    },
                                  )),
                              subtitle: Text(char.description),
                              onTap: () => Get.to(() => CharacterDeails(
                                    char,
                                  )),
                            ),
                          ),
                        );
                      } else {
                        return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 32),
                            child: Center(
                                child: controller.hasmore.value &&
                                        controller.characterList.length ==
                                            controller
                                                .characterListFiltered.length
                                    ? const CircularProgressIndicator()
                                    : const Text('No more characters')));
                      }
                    }),
              ),
            ),
          ],
        ));
  }
}
