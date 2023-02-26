import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../providers/auth.dart';

class HttpUtils {
  static void jsonToFormData(http.MultipartRequest request, Map<String, dynamic> data) {
    for (var key in data.keys) {
      request.fields[key] = data[key].toString();
    }
  }

  static Future<Map<String, dynamic>> sendRequest(String dataInputType, Map<String, String>? params, Auth auth) async {
    var authority = auth.serverUrlWithoutProtocol;
    var unencodedPath = '/call/onstatistic.php';
    if (!authority.endsWith('de')) {
      // lokaler test
      unencodedPath = '/eagle$unencodedPath';
    }
    // print('fetch $unencodedPath');

    final uri = Uri.http(authority, unencodedPath);
    final request = http.MultipartRequest('POST', uri);
    final data = {
      'inputPassword': auth.pw,
      'dataInputType': dataInputType,
    };
    if (params != null) {
      data.addAll(params);
    }

    HttpUtils.jsonToFormData(request, data);

    final response = await request.send();
    if (response.statusCode != 200) {
      throw HttpException('${response.reasonPhrase} (${response.statusCode})', uri: uri);
    }
    final responseBytes = await response.stream.toBytes();
    final responseString = String.fromCharCodes(responseBytes);
    final decoded = jsonDecode(responseString);
    if (decoded == null) throw Exception('No response json data!');

    final json = decoded as Map<String, dynamic>;
    if (!json.containsKey('returnCode')) {
      throw const FormatException('Invalid json: no returnCode');
    }
    final returnCode = json['returnCode'] as int;
    if (returnCode != 1) {
      throw Exception(json['error']);
    }

    final result = json['result'] as Map<String, dynamic>;
    return result;
  }
}
