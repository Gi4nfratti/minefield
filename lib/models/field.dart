import 'explosion_exception.dart';

class Field {
  final int line;
  final int column;
  final List<Field> neighbors = [];

  bool _opened = false;
  bool _marked = false;
  bool _undermined = false;
  bool _exploded = false;

  Field({
    required this.line,
    required this.column,
  });

  void addNeighbor(Field neighbor) {
    final deltaLine = (line - neighbor.line).abs();
    final deltaColumn = (column - neighbor.column).abs();

    if (deltaLine == 0 && deltaColumn == 0) {
      return;
    }

    if (deltaLine <= 1 && deltaColumn <= 1) {
      neighbors.add(neighbor);
    }
  }

  void open() {
    if (_opened) {
      return;
    }

    _opened = true;

    if (_undermined) {
      _exploded = true;
      throw ExplosionException();
    }

    if (safeNeighbors) {
      neighbors.forEach((element) => element.open());
    }
  }

  void revelBomb() {
    if (_undermined) _opened = true;
  }

  void undermine() {
    _undermined = true;
  }

  void switchMarking() {
    _marked = !_marked;
  }

  void reset() {
    _opened = false;
    _marked = false;
    _undermined = false;
    _exploded = false;
  }

  bool get undermined {
    return _undermined;
  }

  bool get exploded {
    return _exploded;
  }

  bool get opened {
    return _opened;
  }

  bool get marked {
    return _marked;
  }

  bool get solved {
    bool underminedAndMarked = undermined && marked;
    bool safeAndOpened = !undermined && opened;
    return underminedAndMarked || safeAndOpened;
  }

  bool get safeNeighbors {
    return neighbors.every((element) => !element._undermined);
  }

  int get neighborMinesQty {
    return neighbors.where((element) => element.undermined).length;
  }
}
