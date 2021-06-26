import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:moca_application/api/Authentication.dart';

class Token {

  Future<Map<String, dynamic>> decryptToken () async {
    String yourToken = await Authentication().getToken();
    return  JwtDecoder.decode(yourToken);

  }

  Future<bool> isExpired() async {
    String yourToken = await Authentication().getToken();
    return JwtDecoder.isExpired(yourToken);

  }

 Future<DateTime> getExpirationDate() async {
      String yourToken = await Authentication().getToken();
      return JwtDecoder.getExpirationDate(yourToken);

  }

  Future<String> yourId() async {
    var decryptedToken = await decryptToken();
    print(decryptedToken);
    return decryptedToken["sub"];
  }

}