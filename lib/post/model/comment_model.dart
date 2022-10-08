import 'package:eunbinlib_app/common/model/i_model_with_id.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment_model.g.dart';

@JsonSerializable()
class CommentModel implements IModelWithId {
  @override
  final int id;
  final String content;

  final int writerId;
  final String writerNickname;
  final DateTime createdAt;

  CommentModel({
    required this.id,
    required this.content,
    required this.writerId,
    required this.writerNickname,
    required this.createdAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommentModelToJson(this);
}
