import 'package:eunbinlib_app/common/model/i_model_with_id.dart';
import 'package:eunbinlib_app/common/utils/data_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_model.g.dart';

@JsonSerializable()
class PostModel implements IModelWithId {
  @override
  final String id;

  final String content;

  final String writer;

  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  final String? imageUrl;

  final int commentCount;

  final int likeCount;

  @JsonKey(
    fromJson: DataUtils.stringToDatetime,
  )
  final DateTime createdAt;

  PostModel({
    required this.id,
    required this.content,
    required this.writer,
    required this.imageUrl,
    required this.commentCount,
    required this.likeCount,
    required this.createdAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}
