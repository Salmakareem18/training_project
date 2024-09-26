import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:image_downloader/image_downloader.dart';

class FullImageScreen extends StatelessWidget {
  final String imageUrl;

  const FullImageScreen({super.key, required this.imageUrl});

  void imageDownloader(String url) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 117, 96, 96),
        title: const Text('Full Image'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              imageDownloader(imageUrl);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 60),
        child: InstaImageViewer(
          child: Image(image: NetworkImage(imageUrl)),
        ),
      ),
    );
  }
}
