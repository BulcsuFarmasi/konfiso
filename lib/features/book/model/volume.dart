// Represents a book in Google Book API
import 'package:freezed_annotation/freezed_annotation.dart';

part 'volume.g.dart';

@JsonSerializable()
class Volume {
  final String id;
  final VolumeInfo volumeInfo;

  Volume(this.id, this.volumeInfo);

  factory Volume.fromJson(Map<String,dynamic> json) => _$VolumeFromJson(json);
}

@JsonSerializable()
class VolumeInfo {
  final String title;
  final List<String>? authors;
  final ImageLinks? imageLinks;

  VolumeInfo({required this.title, this.authors, this.imageLinks});

  factory VolumeInfo.fromJson(Map<String,dynamic> json) => _$VolumeInfoFromJson(json);

}

@JsonSerializable()
class ImageLinks {
  final String thumbnail;

  ImageLinks(this.thumbnail);

  factory ImageLinks.fromJson(Map<String,dynamic> json) => _$ImageLinksFromJson(json);
}