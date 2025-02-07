import 'package:wtfc_provider_app/export.dart';
import 'package:wtfc_provider_app/file_storage/services/fb_services.dart';

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
    if (_filePickerResult != null) {
      Navigator.pushNamed(context, '/fsupload', arguments: _filePickerResult);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your files'),
        actions: [
          IconButton(
            onPressed: () async {
              await AuthServices().SignOut();
              Navigator.pushReplacementNamed(context, '/loginform');
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: StreamBuilder(
        stream: FBCServices().fsReadUploadedFiles(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List userUploadedFiles = snapshot.data!.docs;
            if (userUploadedFiles.isEmpty) {
              return const Center(
                child: Text('No files uploaded'),
              );
            } else {
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, //Number of columns in the grid
                    childAspectRatio: 1, //aspect ratio for each grid item
                    crossAxisSpacing: 8, //Spacing between columns
                    mainAxisSpacing: 8, //Spacign between rows
                  ),
                  itemCount: userUploadedFiles.length,
                  itemBuilder: (context, index) {
                    var fileDetail = userUploadedFiles[index];
                    String name = fileDetail['name'];
                    String ext = fileDetail['extension'];
                    String public_id = fileDetail['id'];
                    String fileUrl = fileDetail['url'];

                    return GestureDetector(
                      onTap: () {
                        ext == 'png' || ext == 'jpg' || ext == 'jpeg'
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        FSPreviewImage(url: fileUrl)))
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        FSPreviewVideo(videoUrl: fileUrl)));
                      },
                      child: Container(
                        color: Colors.grey.shade100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child:
                                  ext == 'png' || ext == 'jpg' || ext == 'jpeg'
                                      ? Image.network(
                                          fileUrl,
                                          //increase the height and width to fit the
                                          //entire container except the bottom section
                                          width: double.infinity,
                                          height: double.infinity,
                                          fit: BoxFit.cover,
                                        )
                                      : const Icon(Icons.movie),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  ext == 'png' || ext == 'jpg' || ext == 'jpeg'
                                      ? const Icon(Icons.image)
                                      : const Icon(Icons.movie),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),

      //floating action button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openFilePicker();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
