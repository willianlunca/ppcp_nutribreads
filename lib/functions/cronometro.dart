import 'dart:async';

class Cronometro {
  Timer? _timer;
  int _segundos = 0;
  bool _rodando = false;

  final Function(String tempoFormatado) onTick;

  Cronometro({required this.onTick});

  /// ▶ Inicia ou continua a contagem
  void iniciar() {
    if (_rodando) return;

    _rodando = true;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _segundos++;
      onTick(_formatarTempo());
    });
  }

  /// ⏸ Pausa a contagem
  void pausar() {
    _timer?.cancel();
    _rodando = false;
  }

  /// ⏹ Para e zera o cronômetro
  /// ⏹ Para e zera o cronômetro
  void resetar() {
    _timer?.cancel();
    _timer = null;
    _segundos = 0;
    _rodando = false;
    onTick(_formatarTempo());
  }

  /// 🔎 Retorna se está rodando
  bool get estaRodando => _rodando;

  /// 🔢 Retorna tempo atual em segundos
  int get segundos => _segundos;

  /// 🕒 Retorna tempo formatado atual
  String get tempoFormatado => _formatarTempo();

  /// 🔐 Formata HH:mm:ss
  String _formatarTempo() {
    final horas = (_segundos ~/ 3600).toString().padLeft(2, '0');
    final minutos = ((_segundos % 3600) ~/ 60).toString().padLeft(2, '0');
    final segundos = (_segundos % 60).toString().padLeft(2, '0');

    return '$horas:$minutos:$segundos';
  }
}
