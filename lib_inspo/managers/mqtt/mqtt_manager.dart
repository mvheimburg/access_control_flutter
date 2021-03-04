import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';

import 'config.dart' as Config;
import 'models.dart';

class MQTTManager {
  MqttClient client;

  MqttCurrentConnectionState connectionState = MqttCurrentConnectionState.IDLE;
  MqttSubscriptionState subscriptionState = MqttSubscriptionState.IDLE;

  final VoidCallback onConnectedCallback;

  static final defaultManager = MQTTManager(this.onConnectedCallback);

  void prepareMqttClient() async {
    _setupMqttClient();
    await _connectClient();
    _subscribeToTopic(Config.topicName);
  }

  // void publishLocation(LocationData locationData) {
  //   String locationJson = locationToJsonConverter.convert(locationData);
  //   _publishMessage(locationJson);
  // }

  Future<void> _connectClient() async {
    try {
      print('MQTTManager::Mosquitto client connecting....');
      connectionState = MqttCurrentConnectionState.CONNECTING;
      await client.connect();
    } on Exception catch (e) {
      print('MQTTManager::client exception - $e');
      connectionState = MqttCurrentConnectionState.ERROR_WHEN_CONNECTING;
      client.disconnect();
    }

    if (client.connectionStatus.state == MqttConnectionState.connected) {
      connectionState = MqttCurrentConnectionState.CONNECTED;
      print('MQTTManager::Mosquitto client connected');
    } else {
      print(
          'MQTTManager::ERROR Mosquitto client connection failed - disconnecting, status is ${client.connectionStatus}');
      connectionState = MqttCurrentConnectionState.ERROR_WHEN_CONNECTING;
      client.disconnect();
    }
  }

  void _setupMqttClient() {
    client = MqttClient.withPort(Config.serverUri, '#', Config.port);
    client.logging(on: false);
    client.keepAlivePeriod = 20;
    client.onDisconnected = _onDisconnected;
    client.onConnected = _onConnected;
    client.onSubscribed = _onSubscribed;
  }

  void _subscribeToTopic(String topicName) {
    print('MQTTManager::Subscribing to the $topicName topic');
    client.subscribe(topicName, MqttQos.atMostOnce);

    client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage recMess = c[0].payload;
      // final String newLocationJson =
      //     MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

      // print("MQTTManager::GOT A NEW MESSAGE $newLocationJson");
      // LocationData newLocationData = _convertJsonToLocation(newLocationJson);
      // if (newLocationData != null) onLocationReceivedCallback(newLocationData);
    });
  }

  // LocationData _convertJsonToLocation(String newLocationJson) {
  //   try {
  //     return jsonToLocationConverter.convert(newLocationJson);
  //   } catch (exception) {
  //     print("Json can't be formatted ${exception.toString()}");
  //   }
  //   return null;
  // }

  void _publishMessage(String message) {
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    builder.addString(message);

    print(
        'MQTTManager::Publishing message $message to topic ${Config.topicName}');
    client.publishMessage(
        Config.topicName, MqttQos.exactlyOnce, builder.payload);
  }

  void _onSubscribed(String topic) {
    print('MQTTManager::Subscription confirmed for topic $topic');
    subscriptionState = MqttSubscriptionState.SUBSCRIBED;
  }

  void _onDisconnected() {
    print('MQTTManager::OnDisconnected client callback - Client disconnection');
    // if (client.connectionStatus.returnCode == MqttConnectReturnCode.solicited) {
    //   print(
    //       'MQTTManager::OnDisconnected callback is solicited, this is correct');
    // }
    connectionState = MqttCurrentConnectionState.DISCONNECTED;
  }

  void _onConnected() {
    connectionState = MqttCurrentConnectionState.CONNECTED;
    print(
        'MQTTManager::OnConnected client callback - Client connection was sucessful');
    onConnectedCallback();
  }
}
