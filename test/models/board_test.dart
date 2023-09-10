import 'package:campo_minado/models/board.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Ganhar Jogo', () {
    Board tabuleiro = Board(
      lines: 2,
      columns: 2,
      bombsQty: 0,
    );

    tabuleiro.fields[0].undermine();
    tabuleiro.fields[3].undermine();

    tabuleiro.fields[0].switchMarking();
    tabuleiro.fields[1].open();
    tabuleiro.fields[2].open();
    tabuleiro.fields[3].switchMarking();

    expect(tabuleiro.solved, isTrue);
  });
}
