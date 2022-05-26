import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stratgetx/models/character.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CharacterDeails extends StatelessWidget {
  final Character char;
  const CharacterDeails(this.char, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text(
                char.name,
                style: const TextStyle(fontSize: 25),
              ),
              expandedHeight: 500.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  char.thumbnail['path'].toString() +
                      '/portrait_incredible.' +
                      char.thumbnail['extension'].toString(),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            SliverFixedExtentList(
              itemExtent: 700.00,
              delegate: SliverChildListDelegate([
                Card(
                  margin: const EdgeInsets.all(20.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Id:' + char.id.toString()),
                        const SizedBox(height: 20),
                        Text('Modified at:' +
                            DateFormat('yyyy MMM dd, hh:mm a').format(
                                DateTime.parse(char.modified.toString()))),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 550,
                          child: AutoSizeText(
                            char.description,
                            style: const TextStyle(fontSize: 30),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
