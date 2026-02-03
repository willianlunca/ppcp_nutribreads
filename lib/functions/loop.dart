import 'dart:async';
import 'package:flutter/foundation.dart';

class DebugLoop {
  static Timer? _timer;
  static int contador = 1;
  static VoidCallback? onTick;

  static void iniciar() {
    _timer ??= Timer.periodic(const Duration(milliseconds: 1500), (_) {
      contador = contador < 3 ? contador + 1 : 1;
      onTick?.call();
    });
  }

  static void parar() {
    _timer?.cancel();
    _timer = null;
    contador = 1;
  }
}
