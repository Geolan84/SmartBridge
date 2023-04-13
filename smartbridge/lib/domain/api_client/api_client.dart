import 'dart:async';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:smartbridge/domain/models/template.dart';
import 'package:smartbridge/domain/models/resume.dart';
import 'dart:convert';
import 'package:path/path.dart';
import 'package:async/async.dart';


enum ApiClientExceptionType { noAnswer, network, auth, other, sessionExpired }

class ApiClientException implements Exception {
  final ApiClientExceptionType type;

  ApiClientException(this.type);
}

class ApiClient {
  Future<List<Resume>> getResumes(String token) async {
    var url = Uri.http('10.0.2.2:8080', 'work/resumes');
    try {
      var response = await http.get(url, headers: {
        "Authorization": "Bearer $token"
      }).timeout(const Duration(seconds: 5));
      if (response.statusCode == 200) {
        var data = json.decode(utf8.decode(response.bodyBytes));
        return Resume.getListFromJson(data);
      } else if (response.statusCode == 400) {
        throw ApiClientException(ApiClientExceptionType.auth);
      }
    } on TimeoutException {
      throw ApiClientException(ApiClientExceptionType.noAnswer);
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw ApiClientException(ApiClientExceptionType.other);
    }
    return List<Resume>.empty();
  }

  Future<List<Resume>> getFavorites(String token) async {
    var url = Uri.http('10.0.2.2:8080', 'work/favorite');
    try {
      var response = await http.get(url, headers: {
        "Authorization": "Bearer $token"
      }).timeout(const Duration(seconds: 5));
      if (response.statusCode == 200) {
        var data = json.decode(utf8.decode(response.bodyBytes));
        return Resume.getListFromJson(data);
      } else if (response.statusCode == 400) {
        throw ApiClientException(ApiClientExceptionType.auth);
      }
    } on TimeoutException {
      throw ApiClientException(ApiClientExceptionType.noAnswer);
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw ApiClientException(ApiClientExceptionType.other);
    }
    return List<Resume>.empty();
  }

  Future<List<Resume>> searchResumes(String token) async {
    var url = Uri.http('10.0.2.2:8080', 'work/search');
    try {
      var response = await http.get(url, headers: {
        "Authorization": "Bearer $token"
      }).timeout(const Duration(seconds: 5));
      if (response.statusCode == 200) {
        var data = json.decode(utf8.decode(response.bodyBytes));
        return Resume.getListFromJson(data);
      } else if (response.statusCode == 400) {
        throw ApiClientException(ApiClientExceptionType.auth);
      }
    } on TimeoutException {
      throw ApiClientException(ApiClientExceptionType.noAnswer);
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw ApiClientException(ApiClientExceptionType.other);
    }
    return List<Resume>.empty();
  }

  Future<Map<String, dynamic>> auth({
    required String email,
    required String password,
  }) async {
    var result = <String, dynamic>{};
    var url = Uri.http('10.0.2.2:8080', 'auth/login');
    Map credantials = {
      'email': email,
      'password': (sha224.convert(utf8.encode(password))).toString()
    };
    var body = json.encode(credantials);
    try {
      var response = await http
          .post(url, headers: {"Content-Type": "application/json"}, body: body)
          .timeout(
            const Duration(seconds: 5),
          );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        result["token"] = data["token"];
        result["is_hr"] = data["is_hr"].toString();
        result["user_id"] = data["user_id"].toString();
      } else if (response.statusCode == 400) {
        throw ApiClientException(ApiClientExceptionType.auth);
      }
    } on TimeoutException {
      throw ApiClientException(ApiClientExceptionType.noAnswer);
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw ApiClientException(ApiClientExceptionType.other);
    }
    return result;
  }

  Future<void> resetPassword(String email) async {
    final Map<String, dynamic> credantials = {'email': email};
    var url = Uri.http('10.0.2.2:8080', 'auth/forgot', credantials);

    try {
      var response = await http.post(url).timeout(
            const Duration(seconds: 5),
          );
      if (response.statusCode != 200) {
        throw ApiClientException(ApiClientExceptionType.auth);
      }
    } on TimeoutException {
      throw ApiClientException(ApiClientExceptionType.noAnswer);
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }

  Future<void> register(
      String email,
      String password,
      String firstName,
      String secondName,
      String? patronymic,
      DateTime birthday,
      bool isHR) async {
    var url = Uri.http('10.0.2.2:8080', 'auth/register');
    Map credantials = {
      'email': email,
      'hashed_password': (sha224.convert(utf8.encode(password))).toString(),
      'first_name': firstName,
      'second_name': secondName,
      "patronymic": "string",
      "birthday": birthday.toUtc().toString(),
      "is_hr": isHR
    };
    if (patronymic != null) {
      credantials['patronymic'] = patronymic;
    }
    var body = json.encode(credantials);
    try {
      var response = await http
          .post(url, headers: {"Content-Type": "application/json"}, body: body)
          .timeout(
            const Duration(seconds: 5),
          );
      if (response.statusCode != 201) {
        throw ApiClientException(ApiClientExceptionType.auth);
      }
    } on TimeoutException {
      throw ApiClientException(ApiClientExceptionType.noAnswer);
    } on SocketException {
      body = "";
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }

  Future<void> deleteProfile(String token, int userId) async{
    var headers = {
      'authorization': 'Bearer $token'
    };
    var url = Uri.http('10.0.2.2:8080', 'profile/$userId');
    try {
      var response = await http
          .delete(url, headers: headers)
          .timeout(const Duration(seconds: 5));
      if (response.statusCode != 200) {
        throw ApiClientException(ApiClientExceptionType.auth);
      }
    } on TimeoutException {
      throw ApiClientException(ApiClientExceptionType.noAnswer);
    } on ApiClientException {
      rethrow;
    } catch (e) {
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }

  Future<void> uploadImage(File file, String token, int userId) async{
    var stream  = http.ByteStream(file.openRead());
    stream.cast();
    var length = await file.length();
    Map<String, String> headers = {
      "Accept": "application/json",
      "authorization": "Bearer $token"
    };
    var uri = Uri.http('10.0.2.2:8080', 'profile/photo/$userId');

    var request = http.MultipartRequest("POST", uri);
    var nameFile = basename(file.path);
    var multipartFileSign = http.MultipartFile('file', stream, length, filename: "photo$userId${nameFile.substring(nameFile.lastIndexOf("."), nameFile.length)}");
    request.files.add(multipartFileSign);
    request.headers.addAll(headers);
    try{
    var response = await request.send();
    } catch(_){
    }
  }

  Future<Resume> getResumeById(int resumeId, String token) async{
    var url = Uri.http('10.0.2.2:8080', 'work/resume/$resumeId');
    try {
      var response = await http.get(url, headers: {
        "Authorization": "Bearer $token"
      }).timeout(const Duration(seconds: 5));
      if (response.statusCode == 200) {
        var data = json.decode(utf8.decode(response.bodyBytes));
        return Resume.fromJson(data["resume"]);
      } else if (response.statusCode == 400) {
        throw ApiClientException(ApiClientExceptionType.auth);
      }
    } on TimeoutException {
      throw ApiClientException(ApiClientExceptionType.noAnswer);
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw ApiClientException(ApiClientExceptionType.other);
    }
    throw ApiClientException(ApiClientExceptionType.other);
  }

  Future<void> addNewResume(String token, Map newResumeDict) async {
    var headers = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer $token'
    };
    var url = Uri.http('10.0.2.2:8080', 'work/resume');
    try {
      var response = await http
          .post(url, headers: headers, body: jsonEncode(newResumeDict))
          .timeout(const Duration(seconds: 5));
      if (response.statusCode != 201) {
        throw ApiClientException(ApiClientExceptionType.auth);
      }
    } on TimeoutException {
      throw ApiClientException(ApiClientExceptionType.noAnswer);
    } on ApiClientException {
      rethrow;
    } catch (_) {
      //print(e);
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }

  Future<void> deleteTemplate(String token, int templateId) async{
    var headers = {
      'authorization': 'Bearer $token'
    };
    var url = Uri.http('10.0.2.2:8080', 'chat/template/$templateId');
    try {
      var response = await http
          .delete(url, headers: headers)
          .timeout(const Duration(seconds: 5));
      if (response.statusCode != 200) {
        throw ApiClientException(ApiClientExceptionType.auth);
      }
    } on TimeoutException {
      throw ApiClientException(ApiClientExceptionType.noAnswer);
    } on ApiClientException {
      rethrow;
    } catch (e) {
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }

  Future<void> addNewTemplate(String token, String title, String message) async {
    var headers = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer $token'
    };
    var url = Uri.http('10.0.2.2:8080', 'chat/template');
    try {
      Map credantials = {"title": title, "body": message};
      var body = json.encode(credantials);
      var response = await http
          .post(url, headers: headers, body: body)
          .timeout(const Duration(seconds: 5));
      if (response.statusCode != 201) {
        throw ApiClientException(ApiClientExceptionType.auth);
      }
    } on TimeoutException {
      throw ApiClientException(ApiClientExceptionType.noAnswer);
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }

  Future<List<Template>> getTemplates(String token) async {
    var url = Uri.http('10.0.2.2:8080', 'chat/template');
    try {
      var response = await http.get(url, headers: {
        "Authorization": "Bearer $token"
      }).timeout(const Duration(seconds: 5));
      if (response.statusCode == 200) {
        var data = json.decode(utf8.decode(response.bodyBytes));
        return Template.getListFromJson(data);
      } else if (response.statusCode == 400) {
        throw ApiClientException(ApiClientExceptionType.auth);
      }
    } on TimeoutException {
      throw ApiClientException(ApiClientExceptionType.noAnswer);
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw ApiClientException(ApiClientExceptionType.other);
    }
    return List<Template>.empty();
  }
}
