import 'dart:math';

import 'field.dart';

class Board {
  final int lines;
  final int columns;
  final int bombsQty;

  final List<Field> _fields = [];

  Board({
    required this.lines,
    required this.columns,
    required this.bombsQty,
  }) {
    _createFields();
    _listNeighbors();
    _raffleMines();
  }

  void reset() {
    _fields.forEach((element) => element.reset());
    _raffleMines();
  }

  void revelBombs() {
    _fields.forEach((element) => element.revelBomb());
  }

  void _createFields() {
    for (var l = 0; l < lines; l++) {
      for (var c = 0; c < columns; c++) {
        _fields.add(Field(line: l, column: c));
      }
    }
  }

  void _listNeighbors() {
    for (var field in _fields) {
      for (var neighbor in _fields) {
        field.addNeighbor(neighbor);
      }
    }
  }

  void _raffleMines() {
    int raffled = 0;

    if (bombsQty > lines * columns) {
      return;
    }

    while (raffled < bombsQty) {
      int i = Random().nextInt(_fields.length);
      if (!_fields[i].undermined) {
        raffled++;
        _fields[i].undermine();
      }
    }
  }

  List<Field> get fields {
    return _fields;
  }

  bool get solved {
    return _fields.every((element) => element.solved);
  }
}
