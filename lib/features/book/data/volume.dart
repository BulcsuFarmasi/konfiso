// Represents a book in Google Book API
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:konfiso/features/book/data/model_book.dart';
import 'package:konfiso/features/book/data/industry_identifier.dart';

part 'volume.freezed.dart';

part 'volume.g.dart';

@freezed
class Volume with _$Volume implements ModelBook {
  const factory Volume(String id, VolumeInfo volumeInfo, {int? volumeIndex}) = _Volume;

  factory Volume.fromJson(Map<String, Object?> json) => _$VolumeFromJson(json);
}

@freezed
class VolumeInfo with _$VolumeInfo {
  const factory VolumeInfo({
    required String title,
    List<String>? authors,
    ImageLinks? imageLinks,
    String? publishedDate,
    List<VolumeIndustryIdentifier>? industryIdentifiers,
  }) = _VolumeInfo;

  factory VolumeInfo.fromJson(Map<String, Object?> json) => _$VolumeInfoFromJson(json);
}

@freezed
class ImageLinks with _$ImageLinks {
  const factory ImageLinks({
    String? smallThumbnail,
    String? thumbnail,
    String? small,
    String? medium,
    String? large,
    String? extraLarge,
  }) = _ImageLinks;

  factory ImageLinks.fromJson(Map<String, Object?> json) => _$ImageLinksFromJson(json);
}
