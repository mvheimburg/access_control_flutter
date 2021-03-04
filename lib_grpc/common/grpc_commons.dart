import 'package:grpc/grpc.dart';

class GrpcClientSingleton {
  ClientChannel channel;
  static final GrpcClientSingleton _singleton =
      new GrpcClientSingleton._internal();

  factory GrpcClientSingleton() => _singleton;

  GrpcClientSingleton._internal() {
    print("Making GRPC singleton");
    channel =
        ClientChannel('127.0.0.1', // Your IP here, localhost might not work.
            port: 5055,
            options: const ChannelOptions(
              credentials: ChannelCredentials.insecure(),
              idleTimeout: Duration(minutes: 1),
            ));
  }
}
