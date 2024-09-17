import 'dart:io';

import 'package:biocountermobile/features/auth/presentation/widgets/app_loader.dart';
import 'package:biocountermobile/features/home/bloc/home_bloc.dart';
import 'package:biocountermobile/features/home/presentation/widgets/image_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multiple_image_camera/camera_file.dart';
import 'package:multiple_image_camera/multiple_image_camera.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<MediaModel> images = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.status == HomeStatus.metaData) {
            return ImageData(
              images: state.images,
            );
          } else if (state.status == HomeStatus.error) {
            return const Center(
              child: Text("An error occurred"),
            );
          } else if (state.status == HomeStatus.loading) {
            return const AppLoader(
              message: "Submitting images",
            );
          }

          return Column(
            children: [
              ElevatedButton(
                child: const Text("Capture"),
                onPressed: () async {
                  List<MediaModel> capturedImages =
                      await MultipleImageCamera.capture(context: context);

                  if (capturedImages.isNotEmpty) {
                    setState(() {
                      images = capturedImages;
                    });
                    // ignore: use_build_context_synchronously
                    BlocProvider.of<HomeBloc>(context)
                        .add(CaptureImagesEvent(images: images));
                  }
                },
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return Image.file(File(images[index].file.path));
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
