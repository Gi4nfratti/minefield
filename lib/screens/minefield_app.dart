import 'package:campo_minado/components/field_widget.dart';
import 'package:campo_minado/components/result_widget.dart';
import 'package:campo_minado/components/board_widget.dart';
import 'package:campo_minado/models/board.dart';
import 'package:flutter/material.dart';

import '../models/field.dart';
import '../models/explosion_exception.dart';

class MinefieldApp extends StatefulWidget {
  const MinefieldApp({super.key});

  @override
  State<MinefieldApp> createState() => _MinefieldAppState();
}

class _MinefieldAppState extends State<MinefieldApp> {
  bool? _won;
  Board? _board;

  void _reset() {
    setState(() {
      _won = null;
      _board!.reset();
    });
  }

  void _open(Field field) {
    if (_won != null) {
      return;
    }
    setState(() {
      try {
        field.open();
        if (_board!.solved) {
          _won = true;
        }
      } on ExplosionException {
        _won = false;
        _board!.revelBombs();
      }
    });
  }

  void _switchMarker(Field field) {
    if (_won != null) {
      return;
    }
    setState(() {
      field.switchMarking();
      if (_board!.solved) {
        _won = true;
      }
    });
  }

  Board _getBoard(double width, double height) {
    if (_board == null) {
      int columnsQty = 15;
      double fieldSize = width / columnsQty;
      int linesQty = (height / fieldSize).floor();

      _board = Board(
        lines: linesQty,
        columns: columnsQty,
        bombsQty: 50,
      );
    }
    return _board!;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: ResultWidget(
          won: _won,
          onReset: _reset,
        ),
        body: Container(
            color: Colors.grey,
            child: LayoutBuilder(builder: (ctx, constraints) {
              return BoardWidget(
                board: _getBoard(
                  constraints.maxWidth,
                  constraints.maxHeight,
                ),
                onOpen: _open,
                onSwitchMarker: _switchMarker,
              );
            })),
      ),
    );
  }
}
