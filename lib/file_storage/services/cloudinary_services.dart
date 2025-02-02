import 'dart:io';

import 'package:wtfc_provider_app/export.dart';
import 'package:http/http.dart' as http;

//https://youtu.be/7P_IC3dviRk?t=593
//https://cloudinary.com/documentation/image_upload_api_reference#banner
Future<bool> uploadToCloudinary(FilePickerResult? filePickerResult) async {
  if (filePickerResult == null || filePickerResult.files.isEmpty) {
    print('No file selected');
    return false;
  }
  File file = File(filePickerResult.files.single.path!);

  String cloudName = dotenv.env['CLOUDINARY_CLOUD_NAME'] ?? '';

//create a multipartRequest
  var uri = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/raw/upload');
  var request = http.MultipartRequest('Post', uri);

//Read the file content as bytes
  var fileBytes = await file.readAsBytes();

  var multipartFile = http.MultipartFile.fromBytes(
    'file', // The form field for the file

    fileBytes,
    filename: file.path.split('/').last, // the file name to send in teh request
  );

  //add the file part to the request
  request.files.add(multipartFile);

//Upload id within cloudinary
  request.fields['upload_preset'] = 'file_storage_app_snehasis';
  request.fields['resource_type'] = 'raw';

  //send the request and await the response
  var response = await request.send();

  //get the resposne as text
  var responseBody = await response.stream.bytesToString();

  //print the response
  print(responseBody);

  if (response.statusCode == 200) {
    print('Upload succesfully');
    return true;
  } else {
    print('Upload failed with status code: ${response.statusCode}');
    return false;
  }
}
