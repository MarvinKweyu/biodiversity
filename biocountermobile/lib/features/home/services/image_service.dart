import 'dart:convert';
import 'dart:io';

import 'package:biocountermobile/core/api/api_handler.dart';
import 'package:biocountermobile/features/home/models/ImageUpload.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class ImageService {
  Future<Map<String, dynamic>> submitImages(
      List<ImageUpload> imagesToProcess) async {
    // select the first from the list
    String imageUrl =
        'http://10.0.2.2:8000/api/batch_uploads/create_batch_upload/';
    String imageUrl2 = 'http://10.0.2.2:8000/api/batch_uploads/upload_image/';

    var request = http.MultipartRequest('POST', Uri.parse(imageUrl2));

    // for (int i = 0; i < imagesToProcess.length; i++) {
    //   ImageUpload image = imagesToProcess[i];
    //   print("Image submission");
    //   print(image.image);
    //   if (image.image != null) {
    //     // Add image file
    //     request.files.add(
    //       await http.MultipartFile.fromPath('images[$i][image]', image.image!),
    //     );

    //     request.fields['images[$i][metadata]'] = image.metadata!;
    //   }
    // }
    var res;
    // print the request fields
    print(request.fields);
    for (ImageUpload imageUp in imagesToProcess) {
      request.files
          .add(await http.MultipartFile.fromPath('image', imageUp.image!));
      request.fields['metadata'] = imageUp.metadata!;
      request.send();
    }

    print("show response\n\n\n");
    print(res.reasonPhrase);

    return {"status": "success"};
  }
}
