part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class CaptureImagesEvent extends HomeEvent {
  final List<MediaModel> images;
  const CaptureImagesEvent({
    required this.images,
  });
}

class SubmitImagesEvent extends HomeEvent {
  final List<Map<String, dynamic>> images;

  const SubmitImagesEvent({
    required this.images,
  });

  @override
  List<Object> get props => [images];
}
