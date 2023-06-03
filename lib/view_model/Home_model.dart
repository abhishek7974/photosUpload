import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:photos_api/api/api.dart';
import 'package:photos_api/data/response/api_response.dart';
import 'package:photos_api/model/file_model.dart';
import 'package:photos_api/res/appurl.dart';
import 'package:photos_api/respository/home_respsitory.dart';
import 'package:photos_api/utils/showToast.dart';
import 'package:photos_api/utils/utils.dart';

class HomeModel with ChangeNotifier {
  final _homeRepo = HomeRepository();

  int selectedIndex = 0;
  bool isVisible = true;
  ApiResponse<List<FileList>> getAllFiles = ApiResponse.loading();
  List allFiles = [];
  ImagePicker picker = ImagePicker();
  Dio dio = Dio();
  List files = [];

  // Future<void> pickImages() async {
  //   List<XFile>? pickedImages = await picker.pickMultiImage(imageQuality: 80);

  //   if (pickedImages != null) {
  //     files.addAll(pickedImages.map((pickedFile) => File(pickedFile.path)));
  //   }

  //   if (files.isNotEmpty) {
  //     try {
  //       FormData formData = FormData();
  //       for (int i = 0; i < files.length; i++) {
  //         String fileName = basename(files[i].path);
  //         formData.files.add(MapEntry(
  //           'files',
  //           await MultipartFile.fromFile(files[i].path, filename: fileName),
  //         ));
  //       }

  //       final response = await dio.post(
  //         '${AppUrl.uploadApi}',
  //         data: formData,
  //       );
  //       print("Status code ${response.statusCode}");
  //       print("response data ${response.data}");
  //       showfinalToast(response.statusCode!, response.data);
  //     } catch (error) {}
  //   }
  // }

  // Future<void> selectVideoAndUpload() async {
  //   final pickedFile = await picker.pickVideo(source: ImageSource.gallery);

  //   if (pickedFile != null) {
  //     File videoFile = File(pickedFile.path);
  //     try {
  //       FormData formData = FormData.fromMap({
  //         'files': await MultipartFile.fromFile(videoFile.path,
  //             filename: videoFile.path.split('/').last),
  //       });

  //       final response = await dio.post(
  //         '${AppUrl.uploadApi}',
  //         data: formData,
  //       );

  //       showfinalToast(response.statusCode!, response.data);
  //     } catch (error) {}
  //   }
  // }

  Future<void> getAllFileData() async {
    try {
      final response = await dio.get(
        '${AppUrl.getApi}',
      );
      allFiles = response.data;

      notifyListeners();
    } catch (error) {}
  }

  Future<void> selectVideoAndUpload(BuildContext context) async {
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      File videoFile = File(pickedFile.path);
      FormData formData = FormData.fromMap({
        'files': await MultipartFile.fromFile(videoFile.path,
            filename: videoFile.path.split('/').last),
      });

      _homeRepo.UploadVideo(formData).then((value) {
        Utils.toastMessage('uploaded Successfully');

        if (kDebugMode) {
          print(value.toString());
        }
      }).onError((error, stackTrace) {
        Utils.flushBarErrorMessage(error.toString(), context);
        if (kDebugMode) {
          print(error.toString());
        }
      });
    } else {
      Utils.flushBarErrorMessage("No videos selected", context);
    }
  }

  Future<void> uploadImage(BuildContext context) async {
    List<XFile>? pickedImages = await picker.pickMultiImage(imageQuality: 80);

    if (pickedImages != null) {
      files.addAll(pickedImages.map((pickedFile) => File(pickedFile.path)));
    }

    if (files.isNotEmpty) {
      FormData formData = FormData();
      for (int i = 0; i < files.length; i++) {
        String fileName = basename(files[i].path);
        formData.files.add(MapEntry(
          'files',
          await MultipartFile.fromFile(files[i].path, filename: fileName),
        ));
      }
      ;

      _homeRepo.UploadPhotos(formData).then((value) {
        Utils.toastMessage('uploaded Successfully');

        if (kDebugMode) {
          print(value.toString());
        }
      }).onError((error, stackTrace) {
        Utils.flushBarErrorMessage(error.toString(), context);
        if (kDebugMode) {
          print(error.toString());
        }
      });
    } else {
      Utils.flushBarErrorMessage("No photos selected", context);
    }
  }

  void setIndex(int id) {
    selectedIndex = id;
    if (id == 0) {
      isVisible = true;
    } else {
      isVisible = false;
    }
    notifyListeners();
  }

  
}
