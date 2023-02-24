import 'package:http/http.dart' as http;

class HttpUtils {
  static void jsonToFormData(http.MultipartRequest request, Map<String, dynamic> data) {
    for (var key in data.keys) {
      request.fields[key] = data[key].toString();
    }
  }
}
