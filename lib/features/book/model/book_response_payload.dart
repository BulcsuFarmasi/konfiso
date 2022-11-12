import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:konfiso/features/book/model/volume.dart';

part 'book_response_payload.g.dart';

@JsonSerializable()
class BookResponsePayload {

  final int totalItems;
  final List<Volume>? items;

  BookResponsePayload({required this.totalItems, this.items});

  factory BookResponsePayload.fromJson(Map<String,dynamic> json) => _$BookResponsePayloadFromJson(json);

  Map<String, dynamic> toJson() => _$BookResponsePayloadToJson(this);
}