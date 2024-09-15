import 'dart:io';

import 'package:biocountermobile/features/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multiple_image_camera/camera_file.dart';

class ImageData extends StatefulWidget {
  final List<MediaModel> images;
  const ImageData({super.key, required this.images});

  @override
  State<ImageData> createState() => _ImageDataState();
}

class _ImageDataState extends State<ImageData> {
  final _formKey = GlobalKey<FormState>();
  List<String> metadataList = [];

  @override
  void initState() {
    super.initState();

    metadataList = List.generate(widget.images.length, (index) => "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Image Metadata")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: widget.images.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      elevation: 3.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.file(
                                File(widget.images[index].file.path),
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please provide some information about the image';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                labelText: "Enter metadata",
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (value) {
                                metadataList[index] = value;
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Saving metadata...')),
                      );

                      List<Map<String, dynamic>> imageData = [];
                      for (var i = 0; i < widget.images.length; i++) {
                        imageData.add({
                          "file": File(widget.images[i].file.path),
                          "metadata": metadataList[i],
                        });
                      }

                      BlocProvider.of<HomeBloc>(context).add(SubmitImagesEvent(
                        images: imageData,
                      ));
                    }
                  },
                  child: const Text("Save"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
