import 'package:json_annotation/json_annotation.dart';

part 'pagination_params.g.dart';

@JsonSerializable()
class PaginationParams {
  final int? after;
  final int? size;

  const PaginationParams({
    this.after,
    this.size,
  });

  PaginationParams copyWith({
    int? after,
    int? size,
  }) {
    return PaginationParams(
      after: after ?? this.after,
      size: size ?? this.size,
    );
  }

  factory PaginationParams.fromJson(Map<String, dynamic> json) =>
      _$PaginationParamsFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationParamsToJson(this);
}
