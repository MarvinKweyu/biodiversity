// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

class ImageUpload {
  String? image;
  String? metadata;
  ImageUpload({
    this.image,
    this.metadata,
  });

  ImageUpload copyWith({
    String? image,
    String? metadata,
  }) {
    return ImageUpload(
      image: image ?? this.image,
      metadata: metadata ?? this.metadata,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
      'metadata': metadata,
    };
  }

  factory ImageUpload.fromMap(Map<String, dynamic> map) {
    return ImageUpload(
      image: map['image'] != null ? map['image'] as String : null,
      metadata: map['metadata'] != null ? map['metadata'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageUpload.fromJson(String source) =>
      ImageUpload.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ImageUpload(image: $image, metadata: $metadata)';

  @override
  bool operator ==(covariant ImageUpload other) {
    if (identical(this, other)) return true;

    return other.image == image && other.metadata == metadata;
  }

  @override
  int get hashCode => image.hashCode ^ metadata.hashCode;
}
