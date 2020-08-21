import 'dart:io' as io;
import 'dart:html';
import 'dart:typed_data';
import 'package:googleapis/drive/v3.dart' as api;
import 'package:googleapis_auth/auth_io.dart';
import 'package:hive/hive.dart';
// import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
// import 'package:url_launcher/url_launcher.dart';
import 'package:googleapis_auth/auth_browser.dart';

// const _clientId =
//     "395322918531-1qitkhfhp0ki8hv4msra3cp5dc8p7o1o.apps.googleusercontent.com";
// const _clientSecret = "XWc4PVuJXEqqqFANRyqNhfvN";
// const _scopes = [api.DriveApi.DriveFileScope];

class GoogleDrive {
  var storage = Hive.box('googleAuthStorage');
  //Get Authenticated Http Client
  /* Future<http.Client> getHttpClient() async {
    //Get Credentials
    var credentials = await storage.getCredentials();
    print(['credentials', credentials]);
    if (credentials == null) {
        //Needs user authentication
        var authClient = await clientViaUserConsent(
            ClientId(_clientId, _clientSecret), _scopes, (url) {
          //Open Url in Browser
          launch(url);
        });
        //Save Credentials
        await storage.saveCredentials(authClient.credentials.accessToken,
            authClient.credentials.refreshToken);
        return authClient;
      } else {
        print(credentials["expiry"]);
        //Already authenticated
        return authenticatedClient(
            http.Client(),
            AccessCredentials(
                AccessToken(credentials["type"], credentials["data"],
                    DateTime.tryParse(credentials["expiry"])),
                credentials["refreshToken"],
                _scopes));
      }
  } */
  final accountCredentials = new ServiceAccountCredentials.fromJson({
    "type": "service_account",
    "project_id": "g-escolar-plus-demo",
    "private_key_id": "b40f450ce6362d6005ec2b283a1738bcc43769ad",
    "private_key":
        "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQC7C3dxuxREPlYL\nEbVMHHbvToTvw4x5+mdkiFruHF7mE/Ffu+Zz5vS4mz7hdqmoZQMqHF/z4S2QCb6/\n/iVr7nA6tq17E9qZq1+V6iFTAGl0YmKryRPWiJIgajqqTBk87gMn+c7wEYWvSz7o\nlz8A9aTfLpc3Qszctkxtin9FRaBOXznJhaoD+iyS6v0zO45mQoIKrJffo+H97Er4\nf/uUe4/YH4OZG8iZJyJ4pYcyxUxoOnEY/CJ6J05oP1Ue+l2RrvblLtKdU7POCl/y\nRMD1m6wtCgsLvdEqD2Ly6TK8z6mu6wxzPzP75upMWQ9ec+S4JA1Svb5ENPpkXlqO\nLyDnpjpjAgMBAAECggEAAM5nWOeoCjVElK6iW+4hex2ZCBmNMPdp266UycL4i8BZ\nQYLjVuuPcX5F0p361D1/On690STO1/iayGQVkDYKaM5hyA6JWjE5a8GDHEL7sWM9\nLqVivwF+s8IRd6t1TmRuQg1bHYDN1TgbUNBaFqx4Zffi8fuJO4hTowM+UjOfIcdY\naeWJ/4z1Bj3acDQ1BORG1/kaW5V7cyQK7R7Gm7NWDUF4QCbp0rOWMK4bTBDokdlF\nXRNVHhlNWhLj9DC86DioYUzyqkuU6iUMde1TiaMVJmg9pmvoiRDsFkHGgyZmmPt4\nrzwHTzamWMnMjQstH8AIPU4cpmx2ONzQj+qit8O/6QKBgQDp8M2P4/3BrveKWEtr\n6FEkkDZbLP2s+VLQe3MH3gE7j0Anx7zUTC4Ti0i1Z06yYFwKlr43yr6U9grTme9j\n6Sd/ftqAUDtKrQP7bLZAXJES68Qzu0Qs5N9HFbfy65bqUBXLF6j/f4Z1DH/w1E6z\nY/j+BuMHatmjuGmvJZPmDjHEKQKBgQDMrp+65KuywLhiCe2qyOOPF7wq25Kxgh1E\n4BiGiavw+RudaBqPJ+aUWWJG/ZIeGiMULyW6RBkGIcmMxh12wAgN3aZc9ISCwBhr\nyxLWuDI2CTAKXgPgGi6cYZ8boxWiemjQWZTOUdKVebZgYZ0cjZHsGiX4EBSF8/cA\n1Z+jmvT7qwKBgCYepfBXb0b7MrzpTEjmDyrNEP5kY2WnLtZn90OF6l+BJSwWQO+7\nBhsLLCrbDZjFWNok3BQNRmbRfMwkHj0ChfwheItGB5NQhACZI01zh/Q0VME1N5O1\nK6jSoinEN9AwgoyYa2JOrmMuST696aETnkQObToNMC+cYiQ3FFV9ZKCZAoGAWWdF\nGctcO/32C8yuZVTOIOiLJmU2VBazVixUSh/EXMNSjpS0VSdmjhHk3YFQ25krDVvy\nrMOl8om7kaPPptkGK5hPXHbpknr5r8vJ9MQMGpI0y7J5GuAUz/XMG7RGdOvm8GrQ\nlrYit2usf7jjeV9VB738K7hKXqBLma+1xS6gJ3UCgYAZv/swF0/4N7B4AfctEs+2\ngv6XB10reQVKVp5fcIunSyzhZK62fCYkjq93B1BLEgjXk6OOBLN6Mjed4NEeZXpZ\nqWBmRGuibQLClKHbwvOuakCLX/17DfE0RXi9YjuzHxmIlTnGNH3eiE8XpnGIr8XN\nUXad04bpBHBsoRVjukn7Hg==\n-----END PRIVATE KEY-----\n",
    "client_email":
        "firebase-adminsdk-yaoq6@g-escolar-plus-demo.iam.gserviceaccount.com",
    "client_id": "112150838264496462359",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url":
        "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-yaoq6%40g-escolar-plus-demo.iam.gserviceaccount.com"
  });
  //Upload File
  Future upload(int size, String path, Uint8List data) async {
    try {
      //0
      AuthClient client = await storage.get('client'); //await getHttpClient();
      if (client == null) {
        AuthClient client = await clientViaServiceAccount(
            accountCredentials, ['https://www.googleapis.com/auth/drive']);
      }
      // print(['client', client]);
      var drive = api.DriveApi(client);
      print(['drive', drive]);
      Stream<List<int>> datos = Stream.fromIterable([data]);
      print(['Data to upload', size, datos]);
      print("Uploading file");
      try {
        //1
        var response = await drive.files.create(
            api.File()..name = 'StanleySIMAT.txt',
            uploadMedia: api.Media(datos, size));
        // uploadMedia: api.Media(file.openRead(), file.lengthSync()));
        // var localFile = api.File();
        // localFile.
        // print([localFile, localFile.openRead(), localFile.lengthSync()]);
        // var media = api.Media(localFile.openRead(), localFile.lengthSync());
        // var driveFile = new api.File()..name = 'StanleySIMAT.txt';
        // drive.files.create(driveFile, uploadMedia: media).then((api.File f) {
        //   try {
        //     print('Uploaded Id: ${f.id}');
        //   } catch (e2) {
        //     print(['Error upload2', e2]);
        //   }
        // });
        print(response.toString());
        // print("Result ${response.toJson()}");
      } catch (e1) {
        print(['Error upload1', e1]);
      }
    } catch (e0) {
      print(['Error upload0', e0]);
    }
  }
}
