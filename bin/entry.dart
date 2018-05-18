import 'dart:async';
import 'dart:io';

String certificateChain = '/etc/letsencrypt/live/entry.legenda.team/fullchain.pem';
String serverKey = '/etc/letsencrypt/live/entry.legenda.team/privkey.pem';

Future main() async {
  var serverContext = new SecurityContext();
  serverContext.useCertificateChain(certificateChain);
  serverContext.usePrivateKey(serverKey);

  var server = await HttpServer.bindSecure(
    new InternetAddress("10.15.13.17"),
    4047,
    serverContext,
  );
  print('Listening on localhost:${server.port}');
  await for (HttpRequest request in server) {
    request.response
      ..write('Hello, world!')
      ..close();
  }
}