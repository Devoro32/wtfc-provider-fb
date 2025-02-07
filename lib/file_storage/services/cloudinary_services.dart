import 'dart:convert';
import 'dart:io';

import 'package:wtfc_provider_app/export.dart';
import 'package:http/http.dart' as http;
import 'package:wtfc_provider_app/file_storage/services/fb_services.dart';

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

  //print the response, so you can see what is in the response
  //body to then obtain the json
  print(responseBody);

  if (response.statusCode == 200) {
    //need to convert the data into a json object
    var jsonResponse = jsonDecode(responseBody);

    Map<String, String> fsrequiredData = {
      'name': filePickerResult.files.first.name,
      'id': jsonResponse['public_id'],
      'extension': filePickerResult.files.first.extension!,
      'size': jsonResponse['bytes'].toString(),
      'url': jsonResponse['secure_url'],
      'created_at': jsonResponse['created_at'],
    };

    //adding the required data to firestore

    await FBCServices().fsSaveUploadedFilesData(fsrequiredData);

    print('Upload succesfully');
    return true;
  } else {
    print('Upload failed with status code: ${response.statusCode}');
    return false;
  }
}

//delete specific file from cloudinary
Future<bool> deleteFromCloudinary(String publicId) async {
  //cloudinary details
  String cloudName = dotenv.env['CLOUDINARY_CLOUD_NAME'] ?? '';
  String apiKey = dotenv.env['CLOUDINARY_API_key'] ?? '';
  String apiSecret = dotenv.env['CLOUDINARY_API_Secret'] ?? '';

//Generate the timestamp
  int timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
}


/* OUTPUT of the body
I/flutter (27871): {
"asset_id":"827a35f8b73bc01a3d081dbc6f146da1",
"public_id":"qxyhuo10jhmudn52pmxe.jpg",
"version":1738771428,
"version_id":"ddc4303bb5b0d91f0eba44397c357afa",
"signature":"2ad673da70fae92c9b597211473927794ab58906",
"resource_type":"raw",
"created_at":"2025-02-05T16:03:48Z",
"tags":[],
"bytes":9380,
"type":"upload",
"etag":"88f5da51a62e2655d021cc7e87441eb8",
"placeholder":false,
"url":"http://res.cloudinary.com/dygfufopy/raw/upload/v1738771428/qxyhuo10jhmudn52pmxe.jpg",
"secure_url":"https://res.cloudinary.com/dygfufopy/raw/upload/v1738771428/qxyhuo10jhmudn52pmxe.jpg",
"asset_folder":"file_storage_public",
"display_name":"1000000035",
"original_filename":"1000000035"}
*/