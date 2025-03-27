import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MaterialApp(
    home: PedraPapelTesoura(),
    debugShowCheckedModeBanner: false,
  ));
}

class PedraPapelTesoura extends StatefulWidget {
  @override
  State<PedraPapelTesoura> createState() => _PedraPapelTesouraState();
}

class _PedraPapelTesouraState extends State<PedraPapelTesoura> {
  String _jogadaUsuario = 'padrao';
  String _jogadaMaquina = 'padrao';

  int _vitorias = 0;
  int _empates = 0;
  int _derrotas = 0;

  String _vencedor = '';

  final Map<String, String> opcoes = {
    'pedra': 'assets/pedra.png',
    'papel': 'assets/papel.png',
    'tesoura': 'assets/tesoura.png',
    'padrao': 'assets/padrao.png',
  };

  void _jogar(String escolhaUsuario) {
    final lista = ['pedra', 'papel', 'tesoura'];
    final escolhaMaquina = lista[Random().nextInt(3)];

    setState(() {
      _jogadaUsuario = escolhaUsuario;
      _jogadaMaquina = escolhaMaquina;

      if (escolhaUsuario == escolhaMaquina) {
        _empates++;
        _vencedor = 'empate';
      } else if ((escolhaUsuario == 'pedra' && escolhaMaquina == 'tesoura') ||
          (escolhaUsuario == 'papel' && escolhaMaquina == 'pedra') ||
          (escolhaUsuario == 'tesoura' && escolhaMaquina == 'papel')) {
        _vitorias++;
        _vencedor = 'usuario';
      } else {
        _derrotas++;
        _vencedor = 'maquina';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade50, Colors.purple.shade50],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Pedra, Papel, Tesoura',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),

            // Disputa
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(opcoes[_jogadaUsuario]!, height: 80),
                const Text('vs', style: TextStyle(fontSize: 20)),
                Image.asset(opcoes[_jogadaMaquina]!, height: 80),
              ],
            ),

            // Placar
            Column(
              children: [
                const Text(
                  'Placar',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _placarBox('Você', _vitorias),
                    _placarBox('Empate', _empates),
                    _placarBox('Máquina', _derrotas),
                  ],
                ),
              ],
            ),

            // Opções
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: opcoes.keys
                  .where((k) => k != 'padrao')
                  .map((opcao) => _botaoOpcao(opcao))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _placarBox(String titulo, int valor) {
    return Column(
      children: [
        Text(titulo),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Text(
            '$valor',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _botaoOpcao(String escolha) {
  return GestureDetector(
    onTap: () => _jogar(escolha),
    child: Image.asset(opcoes[escolha]!, height: 60),
  );
}
}
