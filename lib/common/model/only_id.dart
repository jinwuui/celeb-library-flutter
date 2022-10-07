import 'package:json_annotation/json_annotation.dart';

part 'only_id.g.dart';

@JsonSerializable()
class OnlyId {
  final int id;

  OnlyId({
    required this.id,
  });

  factory OnlyId.fromJson(Map<String, dynamic> json) => _$OnlyIdFromJson(json);
}
