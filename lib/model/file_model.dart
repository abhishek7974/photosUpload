// To parse this JSON data, do
//
//     final fileList = fileListFromJson(jsonString);

import 'dart:convert';

// List<FileList> fileListFromJson(String str) =>
//     List<FileList>.from(json.decode(str).map((x) => FileList.fromJson(x)));

// String fileListToJson(List<FileList> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


    List getMapData(List<Map<String, dynamic>> fileDataList){

      return  fileDataList.map((map) => FileList.fromMap(map)).toList();
    }



class FileList {
  var filename;
  String? filePath;
  int? size;
  DateTime? lastModified;

  FileList({
    this.filename,
    this.filePath,
    this.size,
    this.lastModified,
  });

  factory FileList.fromMap(Map<String, dynamic> json) => FileList(
        filename: json["filename"],
        filePath: json["filePath"],
        size: json["size"],
        lastModified: json["lastModified"] == null
            ? null
            : DateTime.parse(json["lastModified"]),
      );

  Map<String, dynamic> toJson() => {
        "filename": filename,
        "filePath": filePath,
        "size": size,
        "lastModified": lastModified?.toIso8601String(),
      };
}
