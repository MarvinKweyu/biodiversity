import 'package:biocountermobile/features/home/services/image_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:multiple_image_camera/camera_file.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  ImageService imageService = ImageService();
  HomeBloc() : super(HomeInitial()) {
    on<CaptureImagesEvent>(_onCaptureImages);
    on<SubmitImagesEvent>(_onSubmitImages);
  }

  void _onCaptureImages(CaptureImagesEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(status: HomeStatus.metaData, images: event.images));
  }

  void _onSubmitImages(SubmitImagesEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStatus.loading));
    final result = await imageService.submitImages(event.images);
    if (result['status'] == "success") {
      emit(state.copyWith(status: HomeStatus.success));
    } else {
      emit(state.copyWith(status: HomeStatus.error));
    }
  }
}
