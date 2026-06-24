import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

Future<void> mqttPublish({
  required String topico,
  required String mensagem,
  required String usuario,
  required String senha,
  Function()? onSucesso,
  Function(String erro)? onErro,
}) async {
  const String broker = 'erp.nutribreads.com.br';
  const int porta = 1883;

  final String clientId =
      'flutter_pub_${DateTime.now().millisecondsSinceEpoch}';

  final client = MqttServerClient(broker, clientId);

  client.port = porta;
  client.keepAlivePeriod = 20;
  client.logging(on: false);

  client.onConnected = () {
    print('MQTT conectado para publicação');
  };

  client.onDisconnected = () {
    print('MQTT desconectado');
  };

  client.connectionMessage = MqttConnectMessage()
      .withClientIdentifier(clientId)
      .startClean()
      .withWillQos(MqttQos.atMostOnce);

  try {
    await client.connect(usuario, senha);

    if (client.connectionStatus?.state != MqttConnectionState.connected) {
      final erro = 'Falha MQTT: ${client.connectionStatus?.state}';

      print(erro);

      client.disconnect();

      onErro?.call(erro);
      return;
    }

    final builder = MqttClientPayloadBuilder();
    builder.addString(mensagem);

    client.publishMessage(
      topico,
      MqttQos.atMostOnce,
      builder.payload!,
      retain: true,
    );

    print('Mensagem publicada em $topico: $mensagem');

    onSucesso?.call();

    // Aguarda um pouco para garantir envio
    await Future.delayed(const Duration(milliseconds: 300));

    client.disconnect();
  } catch (e) {
    final erro = 'Erro ao publicar MQTT: $e';

    print(erro);

    client.disconnect();

    onErro?.call(erro);
  }
}
