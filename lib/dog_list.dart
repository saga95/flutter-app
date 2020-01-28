import 'package:flutter/material.dart';
import 'package:gridview_test/dog_card.dart';
import 'package:gridview_test/dog_model.dart';

class DogList extends StatelessWidget {
  final List<Dog> doggos;

  DogList(this.doggos);

  ListView _buildList(context) {
    return new ListView.builder(
      itemCount: doggos.length,
      itemBuilder: (context, int) {
        return new DogCard(doggos[int]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }
}
