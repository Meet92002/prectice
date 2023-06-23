// To parse this JSON data, do
//
//     final imagListModel = imagListModelFromJson(jsonString);

import 'dart:convert';

List<ImagListModel> imagListModelFromJson(String str) => List<ImagListModel>.from(json.decode(str).map((x) => ImagListModel.fromJson(x)));

String imagListModelToJson(List<ImagListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ImagListModel {
  String id;
  String author;
  int width;
  int height;
  String url;
  String downloadUrl;

  ImagListModel({
    required this.id,
    required this.author,
    required this.width,
    required this.height,
    required this.url,
    required this.downloadUrl,
  });

  factory ImagListModel.fromJson(Map<String, dynamic> json) => ImagListModel(
    id: json["id"],
    author: json["author"],
    width: json["width"],
    height: json["height"],
    url: json["url"],
    downloadUrl: json["download_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "author": author,
    "width": width,
    "height": height,
    "url": url,
    "download_url": downloadUrl,
  };
}
