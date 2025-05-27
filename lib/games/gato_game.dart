import 'package:flutter/material.dart';

class GatoGameScreen extends StatefulWidget {
  const GatoGameScreen({super.key});

  @override
  State<GatoGameScreen> createState() => _GatoGameScreenState();
}

class _GatoGameScreenState extends State<GatoGameScreen> {
  List<String> _board = List.filled(9, '');
  String _currentPlayer = 'X';
  String? _winner;

  void _playMove(int index) {
    if (_board[index] == '' && _winner == null) {
      setState(() {
        _board[index] = _currentPlayer;
        print('Jugador $_currentPlayer jugó en $index');
        _winner = _checkWinner();

        if (_winner == null) {
          _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';
        }
      });
    }
  }

  String? _checkWinner() {
    const wins = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ];

    for (var pos in wins) {
      if (_board[pos[0]] != '' &&
          _board[pos[0]] == _board[pos[1]] &&
          _board[pos[1]] == _board[pos[2]]) {
        return _board[pos[0]];
      }
    }

    if (!_board.contains('')) return 'Empate';
    return null;
  }

  void _resetGame() {
    setState(() {
      _board = List.filled(9, '');
      _currentPlayer = 'X';
      _winner = null;
    });
  }

  Widget _buildCell(int index) {
    return GestureDetector(
      onTap: () => _playMove(index),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white24),
        ),
        child: Center(
          child: Text(
            _board[index],
            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final status = _winner != null
        ? (_winner == 'Empate' ? '¡Empate!' : 'Ganó $_winner 🎉')
        : 'Turno de $_currentPlayer';

    return Scaffold(
      appBar: AppBar(title: Text('Juego de Gato')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(status, style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                itemCount: 9,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                itemBuilder: (context, index) => _buildCell(index),
              ),
            ),
            ElevatedButton(
              onPressed: _resetGame,
              child: const Text("Reiniciar juego"),
            )
          ],
        ),
      ),
    );
  }
}
