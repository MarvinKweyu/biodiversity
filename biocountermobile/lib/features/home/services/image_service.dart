import 'package:biocountermobile/features/home/models/ImageUpload.dart';
import 'package:http/http.dart' as http;

class ImageService {
  Future<Map<String, dynamic>> submitImages(
      List<ImageUpload> imagesToProcess) async {
    String imageUrl =
        'http://10.0.2.2:8000/api/batch_uploads/create_batch_upload/';

    var request = http.MultipartRequest('POST', Uri.parse(imageUrl));

    var res;

    for (ImageUpload imageUp in imagesToProcess) {
      request.files
          .add(await http.MultipartFile.fromPath('image', imageUp.image!));
      request.fields['metadata'] = imageUp.metadata!;
      request.send();
    }

    return {"status": "success"};
  }
}
