import 'package:wtfc_provider_app/export.dart';

class FSPreviewImage extends StatefulWidget {
  final String url;

  const FSPreviewImage({
    super.key,
    required this.url,
  });

  @override
  State<FSPreviewImage> createState() => _FSPreviewImageState();
}

class _FSPreviewImageState extends State<FSPreviewImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview Image'),
      ),
      body: Image.network(
        widget.url,
        // height: double.infinity,
        // width: double.infinity,
        fit: BoxFit.fill,
      ),
    );
  }
}
