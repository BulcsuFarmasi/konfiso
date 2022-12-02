import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:konfiso/features/book/data/volume.dart';

part 'volume_category_loading.freezed.dart';

@freezed
class VolumeCategoryLoading with _$VolumeCategoryLoading {
  const factory VolumeCategoryLoading(List<Volume> volumes, int currentVolumeNumber, totalVolumeNumber) =
      _VolumeCategoryLoading;
}
