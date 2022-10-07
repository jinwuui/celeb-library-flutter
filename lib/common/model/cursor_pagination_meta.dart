import 'package:json_annotation/json_annotation.dart';

part 'cursor_pagination_meta.g.dart';

@JsonSerializable()
class CursorPaginationMeta {
  final int size;
  final bool hasMore;

  CursorPaginationMeta({
    required this.size,
    required this.hasMore,
  });

  CursorPaginationMeta copyWith({
    int? size,
    bool? hasMore,
  }) {
    return CursorPaginationMeta(
      size: size ?? this.size,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  factory CursorPaginationMeta.fromJson(Map<String, dynamic> json) =>
      _$CursorPaginationMetaFromJson(json);
}
