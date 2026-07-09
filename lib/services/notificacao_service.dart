import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificacaoService {
  NotificacaoService._();

  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static bool _inicializado = false;

  static Future<void> inicializar() async {
    if (_inicializado) return;

    const settings = InitializationSettings(
      iOS: DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        defaultPresentAlert: true,
        defaultPresentBadge: true,
        defaultPresentSound: true,
      ),
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );

    await _plugin.initialize(settings);

    if (Platform.isIOS) {
      await _plugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);
    }

    _inicializado = true;
  }

  static Future<void> mostrar({
    required String titulo,
    required String mensagem,
  }) async {
    await inicializar();

    await _plugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      titulo,
      mensagem,
      const NotificationDetails(
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
        android: AndroidNotificationDetails(
          'mqtt_notifications',
          'Notificações MQTT',
          channelDescription: 'Notificações recebidas via MQTT',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
  }
}
