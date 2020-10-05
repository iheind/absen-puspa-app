import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';

import 'package:network/network.dart';
import 'package:flutter/foundation.dart';
import 'package:global_template/global_template.dart';
import 'package:http/http.dart' as http;

class UserApi {
  Future<List<UserModel>> userLogin({
    @required String username,
    @required String password,
    @required String deviceid,
  }) async {
    final result = await reusableRequestServer.requestServer(() async {
      final response = await http.post(
        '${appConfig.baseApiUrl}/${appConfig.userController}/userLogin',
        headers: appConfig.headersApi,
        body: {
          'username': username,
          'password': password,
          'deviceid': deviceid,
        },
      );
      final Map<String, dynamic> responseJson = json.decode(response.body);
      if (responseJson['status'] == 1) {
        final List userList = responseJson['data'];
        final List<UserModel> result =
            userList.map((e) => UserModel.fromJson(e)).toList();
        return result;
      } else {
        throw responseJson['message'];
      }
    });
    return result;
  }

  Future<String> userRegister({
    @required String username,
    @required String password,
    @required String fullName,
  }) async {
    final result = await reusableRequestServer.requestServer(() async {
      final response = await http.post(
          '${appConfig.baseApiUrl}/${appConfig.userController}/userRegister',
          headers: appConfig.headersApi,
          body: {
            'username': username,
            'password': password,
            'full_name': fullName,
          });
      final Map<String, dynamic> responseJson = json.decode(response.body);

      return responseJson['message'];
    });
    return result;
  }

  Future<List<UserModel>> userUpdateImage({
    @required String idUser,
    @required File imageFile,
  }) async {
    List<UserModel> result;
    try {
      result = await reusableRequestServer.requestServer(() async {
        const String _nameFileFromAPI = 'file';
        final stream = http.ByteStream(Stream.castFrom(imageFile.openRead()));
        final length = await imageFile.length();
        final uri = Uri.parse(
          '${appConfig.baseApiUrl}/${appConfig.userController}/userUpdateImage',
        );
        final request = http.MultipartRequest('POST', uri);
        final multipartFile = http.MultipartFile(
          _nameFileFromAPI, //! Nama field yang ada di API
          stream,
          length,
          filename: basename(imageFile.path),
        );
        request.fields['id_user'] = idUser;
        request.files.add(multipartFile);
        final response = await request.send();
        final responseString = await response.stream.bytesToString();
        final Map<String, dynamic> responseJson = json.decode(responseString);

        final int statusCode = response.statusCode;
        if (statusCode == 200) {
          final List userList = responseJson['data'];
          final List<UserModel> result =
              userList.map((e) => UserModel.fromJson(e)).toList();
          return result;
        } else {
          throw responseJson['message'];
        }
      });
    } catch (e) {
      rethrow;
    }
    return result;
  }

  Future<List<UserModel>> userUpdateFullName({
    @required String idUser,
    @required String fullName,
  }) async {
    final result = await reusableRequestServer.requestServer(() async {
      final response = await http.post(
          '${appConfig.baseApiUrl}/${appConfig.userController}/userUpdateFullName',
          headers: appConfig.headersApi,
          body: {
            'id_user': idUser,
            'full_name': fullName,
          });
      final Map<String, dynamic> responseJson = json.decode(response.body);
      if (response.statusCode == 200) {
        final List userList = responseJson['data'];
        final List<UserModel> result =
            userList.map((e) => UserModel.fromJson(e)).toList();
        return result;
      } else {
        throw responseJson['message'];
      }
    });
    return result;
  }

  Future<String> userDelete({@required String idUser}) async {
    String result;
    try {
      result = await reusableRequestServer.requestServer(() async {
        final response = await http.post(
            '${appConfig.baseApiUrl}/${appConfig.userController}/userDelete',
            body: {
              'id_user': idUser,
            });
        final Map<String, dynamic> responseJson = json.decode(response.body);
        if (response.statusCode == 200) {
          return responseJson['message'];
        } else {
          throw responseJson['message'];
        }
      });
    } catch (e) {
      rethrow;
    }
    return result;
  }
}

final userAPI = UserApi();
