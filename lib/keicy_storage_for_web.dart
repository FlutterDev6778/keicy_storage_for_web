library keicy_storage_for_web;

import 'dart:async';
// import 'dart:io';
import 'package:firebase/firebase.dart';
import 'package:universal_html/html.dart' as html;
import 'dart:math';
import 'dart:typed_data';

import 'package:firebase/firebase.dart' as fb;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class KeicyStorageForWeb {
  static KeicyStorageForWeb _instance = KeicyStorageForWeb();
  static KeicyStorageForWeb get instance => _instance;

  Future<dynamic> uploadHtmlFileObject({@required String path, @required html.File file}) async {
    try {
      String fileName = _getValidatedFileName(file.name);
      fb.StorageReference storageRef = fb.storage().ref("$path$fileName");
      fb.UploadTaskSnapshot uploadTaskSnapshot = await storageRef.put(file).future;
      Uri url = await uploadTaskSnapshot.ref.getDownloadURL();
      return url.toString();
    } catch (e) {
      print(e);
      return "unknown";
    }
  }

  String _getValidatedFileName(String fileName) {
    var listFileName = fileName.split('.');
    String extention = listFileName[listFileName.length - 1];
    String fName = fileName.substring(0, fileName.length - extention.length - 2);
    return "${fName}_${Random().nextInt(10000000).toString()}.$extention";
  }
}
