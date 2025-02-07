import 'package:wtfc_provider_app/export.dart';
import 'package:wtfc_provider_app/file_storage/services/cloudinary_services.dart';

//show the result once you have selected a file to be uploaded
class FSUploadArea extends StatefulWidget {
  const FSUploadArea({super.key});

  @override
  State<FSUploadArea> createState() => _FSUploadAreaState();
}

class _FSUploadAreaState extends State<FSUploadArea> {
  @override
  Widget build(BuildContext context) {
    //accepting the file picker as an argument
    final selectedFile =
        ModalRoute.of(context)!.settings.arguments as FilePickerResult;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Area'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            //name of the file
            TextFormField(
              readOnly: true,
              initialValue: selectedFile.files.first.name,
              decoration: const InputDecoration(
                label: Text('Name'),
              ),
            ),
            //show the file extension
            TextFormField(
              readOnly: true,
              initialValue: selectedFile.files.first.extension,
              decoration: const InputDecoration(
                label: Text('File Type'),
              ),
            ),
            //show the size of the file
            TextFormField(
              readOnly: true,
              initialValue: "${selectedFile.files.first.size} bytes",
              decoration: const InputDecoration(
                label: Text('Size'),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 25),
                Expanded(
                    child: ElevatedButton(
                        //upload to cloudinary
                        onPressed: () async {
                          final result = await uploadToCloudinary(selectedFile);

                          if (result) {
                            showSnackBar(
                                context, 'File uploaded successfully.');
                          } else {
                            showSnackBar(context, 'File failed to upload.');
                          }
                        },
                        child: const Text('Upload'))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
