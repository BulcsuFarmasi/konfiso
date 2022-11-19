// Represents a book in Google Book API
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:konfiso/features/book/data/industry_identifier.dart';

part 'volume.g.dart';

@JsonSerializable()
class Volume {
  final String id;
  final VolumeInfo volumeInfo;

  const Volume(this.id, this.volumeInfo);

  factory Volume.fromJson(Map<String, dynamic> json) => _$VolumeFromJson(json);
}

@JsonSerializable()
class VolumeInfo {
  final String title;
  final List<String>? authors;
  final ImageLinks? imageLinks;
  final String? publishedDate;
  final List<VolumeIndustryIdentifier>? industryIdentifiers;

  const VolumeInfo({
    required this.title,
    this.authors,
    this.imageLinks,
    this.publishedDate,
    this.industryIdentifiers,
  });

  factory VolumeInfo.fromJson(Map<String, dynamic> json) =>
      _$VolumeInfoFromJson(json);
}

@JsonSerializable()
class ImageLinks {
  final String? thumbnail;
  final String? small;

  const ImageLinks(this.thumbnail, this.small);

  factory ImageLinks.fromJson(Map<String, dynamic> json) =>
      _$ImageLinksFromJson(json);
}




