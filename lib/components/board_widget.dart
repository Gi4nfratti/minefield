import 'package:campo_minado/components/field_widget.dart';
import 'package:flutter/material.dart';

import '../models/field.dart';
import '../models/board.dart';

class BoardWidget extends StatelessWidget {
  final Board board;
  final void Function(Field) onOpen;
  final void Function(Field) onSwitchMarker;

  BoardWidget({
    required this.board,
    required this.onOpen,
    required this.onSwitchMarker,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: board.columns,
        children: board.fields.map((c) {
          return FieldWidget(
            field: c,
            onOpened: onOpen,
            onChangedMarking: onSwitchMarker,
          );
        }).toList(),
      ),
    );
  }
}
