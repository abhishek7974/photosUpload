import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:photos_api/data/app_excaptions.dart';
import 'package:photos_api/data/network/BaseApiServices.dart';

class NetworkApiService extends BaseApiServices {
  Dio dio = Dio();

  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response = await dio.get(url).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {
      Response response =
          await dio.post(url, data: data).timeout(Duration(seconds: 10));
      print("response data == ${response.data}");
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  dynamic returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = response.data.toString();
        return responseJson;
      case 400:
        throw BadRequestException(response.data.toString());
      case 500:
      case 404:
        throw UnauthorisedException(response.data.toString());
      default:
        throw FetchDataException(
            'Error accured while communicating with server' +
                'with status code' +
                response.statusCode.toString());
    }
  }
}
