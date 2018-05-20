import 'dart:async';
import 'dart:io';

String certificateChain = '/etc/letsencrypt/live/entry.legenda.team/fullchain.pem';
String serverKey = '/etc/letsencrypt/live/entry.legenda.team/privkey.pem';

Future main() async {
  var serverContext = new SecurityContext();
  serverContext.useCertificateChain(certificateChain);
  serverContext.usePrivateKey(serverKey);

  var server = await HttpServer.bindSecure(
    InternetAddress.ANY_IP_V4,
    4047,
    serverContext,
  );
  print("Listening on localhost:${server.port}");
  await for (HttpRequest req in server) {

    final HttpResponse resp = req.response;

    final String last_name = req.uri.queryParameters['last'];
    final String first_name = req.uri.queryParameters['first'];
    final String year = req.uri.queryParameters['year'];
    final String team = req.uri.queryParameters['team'];
    final String si = req.uri.queryParameters['si'];
    final String course = req.uri.queryParameters['course'].substring(0,3);

    final String r = """
            <tr>
              <td>$last_name</td>
              <td>$first_name</td>
              <td>$year</td>
              <td>$team</td>
              <td>$si</td>
              <td>$course</td>
              <td></td>
            </tr>
        """;
      resp
      ..write(r)
      ..close();
  }
}