import 'package:biocountermobile/core/styles.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AppLoader extends StatelessWidget {
  final String? message;
  const AppLoader({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          // align the column items to the center
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoadingAnimationWidget.staggeredDotsWave(
              color: Styles.primaryColor,
              size: 100,
            ),
            const SizedBox(height: 20),
            Text(
              message ?? '',
              style: Styles.custom16(context),
            ),
          ],
        ),
      ),
    );
  }
}
