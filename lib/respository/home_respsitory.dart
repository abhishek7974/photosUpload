import 'package:photos_api/data/network/BaseApiServices.dart';
import 'package:photos_api/data/network/NetworkApiService.dart';
import 'package:photos_api/model/file_model.dart';
import 'package:photos_api/res/appurl.dart';

class HomeRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> UploadPhotos(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.uploadApi, data);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> UploadVideo(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.uploadApi, data);
      return response;
    } catch (e) {
      throw e;
    }
  }

}
