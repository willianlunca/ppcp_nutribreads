import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

MqttServerClient? _client;

Future<void> mqttSubscribe({
  required String topico,
  required String usuario,
  required String senha,
  required Function(String retorno) onMensagem,
  Function(String erro)? onErro,
}) async {
  const String broker = 'erp.nutribreads.com.br';
  const int porta = 1883;

  final String clientId = 'flutter_${DateTime.now().millisecondsSinceEpoch}';

  _client = MqttServerClient(broker, clientId);

  _client!.port = porta;
  _client!.keepAlivePeriod = 20;
  _client!.logging(on: false);

  _client!.onConnected = () {
    print('MQTT conectado');
    _client!.subscribe(topico, MqttQos.atMostOnce);
  };

  _client!.onDisconnected = () {
    print('MQTT desconectado');
  };

  _client!.onSubscribed = (String topic) {
    print('Inscrito no tópico: $topic');
  };

  _client!.connectionMessage = MqttConnectMessage()
      .withClientIdentifier(clientId)
      .startClean()
      .withWillQos(MqttQos.atMostOnce);

  try {
    await _client!.connect(usuario, senha);

    if (_client!.connectionStatus?.state != MqttConnectionState.connected) {
      final erro = 'Falha MQTT: ${_client!.connectionStatus?.state}';
      print(erro);
      _client!.disconnect();
      onErro?.call(erro);
      return;
    }

    _client!.updates?.listen((mensagens) {
      final recMess = mensagens.first.payload as MqttPublishMessage;

      final retorno = MqttPublishPayload.bytesToStringAsString(
        recMess.payload.message,
      );

      print('MQTT recebido: $retorno');

      onMensagem(retorno);
    });
  } catch (e) {
    final erro = 'Erro ao conectar MQTT: $e';
    print(erro);
    _client?.disconnect();
    onErro?.call(erro);
  }
}

void mqttDisconnect() {
  _client?.disconnect();
}
