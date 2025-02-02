import 'package:wtfc_provider_app/export.dart';

class FileStorageHome extends StatefulWidget {
  const FileStorageHome({super.key});

  @override
  State<FileStorageHome> createState() => _FileStorageHomeState();
}

class _FileStorageHomeState extends State<FileStorageHome> {
  FilePickerResult? _filePickerResult;

//function to open up the file picker
  void _openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'mp4'],
      type: FileType.custom,
    );
    setState(() {
      _filePickerResult = result;
    });

    //once the file has been uploaded, then it will go to the uploaded page
    //to get to the fsupload, we need an argument
    Navigator.pushNamed(context, '/fsupload', arguments: _filePickerResult);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your files'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openFilePicker();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
