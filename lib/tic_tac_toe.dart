import 'package:flutter/material.dart';
import 'dart:math'; // Para gerar movimentos aleatórios para a IA

class TicTacToePage extends StatefulWidget {
  @override
  _TicTacToePageState createState() => _TicTacToePageState();
}

class _TicTacToePageState extends State<TicTacToePage> {
  List<String> board = List.filled(9, ''); // Representação do tabuleiro
  String currentPlayer = 'X'; // Jogador atual
  bool gameOver = false;
  String winner = ''; // Vencedor

  // Função para verificar se há um vencedor ou empate
  void _checkWinner() {
    // Definindo as combinações vencedoras
    List<List<int>> winningCombinations = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var combination in winningCombinations) {
      if (board[combination[0]] == currentPlayer &&
          board[combination[1]] == currentPlayer &&
          board[combination[2]] == currentPlayer) {
        setState(() {
          winner = currentPlayer;
          gameOver = true;
        });
        return;
      }
    }

    if (!board.contains('')) {
      setState(() {
        winner = 'Empate';
        gameOver = true;
      });
    }
  }

  // Função para reiniciar o jogo
  void _resetGame() {
    setState(() {
      board = List.filled(9, '');
      currentPlayer = 'X';
      gameOver = false;
      winner = '';
    });
  }

  // Função para a IA fazer um movimento aleatório
  void _makeAIMove() {
    List<int> availableSpots = [];
    for (int i = 0; i < board.length; i++) {
      if (board[i] == '') {
        availableSpots.add(i);
      }
    }

    if (availableSpots.isNotEmpty) {
      int randomIndex = Random().nextInt(availableSpots.length);
      int move = availableSpots[randomIndex];

      setState(() {
        board[move] = currentPlayer;
        _checkWinner(); // Verifica se o IA ganhou após o movimento

        if (!gameOver) {
          currentPlayer =
              currentPlayer == 'X' ? 'O' : 'X'; // Alterna para o jogador
        }
      });
    }
  }

  // Função para processar o toque no tabuleiro
  void _handleTap(int index) {
    if (!gameOver && board[index] == '') {
      setState(() {
        board[index] = currentPlayer;
        _checkWinner();

        if (!gameOver) {
          currentPlayer = currentPlayer == 'X' ? 'O' : 'X'; // Alterna para IA
          _makeAIMove();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jogo da Velha com IA'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Exibe o tabuleiro
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: 9,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _handleTap(index),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Center(
                    child: Text(
                      board[index],
                      style: const TextStyle(
                        fontSize: 48.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          // Exibe o vencedor ou se o jogo acabou em empate
          if (gameOver)
            Text(
              winner == 'Empate' ? 'Jogo empatado!' : 'O vencedor é: $winner',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _resetGame,
            child: const Text('Reiniciar Jogo'),
          ),
        ],
      ),
    );
  }
}
