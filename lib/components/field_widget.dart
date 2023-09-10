import 'package:flutter/material.dart';

import '../models/field.dart';

class FieldWidget extends StatelessWidget {
  final Field field;
  final void Function(Field) onOpened;
  final void Function(Field) onChangedMarking;

  FieldWidget({
    required this.field,
    required this.onOpened,
    required this.onChangedMarking,
  });

  Widget _getImage() {
    int mineQty = field.neighborMinesQty;
    if (field.opened && field.undermined && field.exploded) {
      return Image.asset('assets/images/bomb_0.jpeg');
    } else if (field.opened && field.undermined) {
      return Image.asset('assets/images/bomb_1.jpeg');
    } else if (field.opened) {
      return Image.asset('assets/images/opened_$mineQty.jpeg');
    } else if (field.marked) {
      return Image.asset('assets/images/flag.jpeg');
    } else {
      return Image.asset('assets/images/closed.jpeg');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onOpened(field),
      onLongPress: () => onChangedMarking(field),
      child: _getImage(),
    );
  }
}
