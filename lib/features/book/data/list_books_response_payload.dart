import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:konfiso/features/book/data/volume.dart';

part 'list_books_response_payload.g.dart';

@JsonSerializable()
class ListBooksResponsePayload {
  final int totalItems;
  final List<Volume>? items;

  ListBooksResponsePayload({required this.totalItems, this.items});

  factory ListBooksResponsePayload.fromJson(Map<String, dynamic> json) =>
      _$ListBooksResponsePayloadFromJson(json);

  Map<String, dynamic> toJson() => _$ListBooksResponsePayloadToJson(this);
}
