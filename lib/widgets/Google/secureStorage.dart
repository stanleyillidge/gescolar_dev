// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:hive/hive.dart';

class SecureStorage {
  // final storage = FlutterSecureStorage();
  var storage = Hive.box('googleAuthStorage');
  //Save Credentials
  Future saveCredentials(AccessToken token, String refreshToken) async {
    print(token.expiry.toIso8601String());
    var credentials = {
      "type": token.type,
      "data": token.data,
      "expiry": token.expiry.toString(),
      "refreshToken": refreshToken,
    };
    await storage.put("type", token.type);
    await storage.put("data", token.data);
    await storage.put("expiry", token.expiry.toString());
    await storage.put("refreshToken", refreshToken);
    await storage.put('credentials', credentials);
  }

  //Get Saved Credentials
  Future<Map<String, dynamic>> getCredentials() async {
    try {
      var result = await storage.get('credentials');
      print(['result', result]);
      if ((result != null) && (result.length == 0)) {
        return null;
      }
      return result;
    } catch (e) {
      print(['Error getCredentials', e]);
    }
  }

  //Clear Saved Credentials
  Future clear() {
    return storage.clear();
  }
}
