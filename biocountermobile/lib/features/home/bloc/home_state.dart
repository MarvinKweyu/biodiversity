part of 'home_bloc.dart';

enum HomeStatus { initial, metaData, capturing, loading, success, error }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<MediaModel> images;

  const HomeState({
    this.status = HomeStatus.initial,
    this.images = const [],
  });

  HomeState copyWith({
    HomeStatus? status,
    List<MediaModel>? images,
  }) {
    return HomeState(
      status: status ?? this.status,
      images: images ?? this.images,
    );
  }

  @override
  List<Object> get props => [images, status];
}

class HomeInitial extends HomeState {}
