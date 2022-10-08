import 'package:eunbinlib_app/post/model/comment_model.dart';
import 'package:eunbinlib_app/post/model/post_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_detail_model.g.dart';

@JsonSerializable()
class PostDetailModel extends PostModel {
  final List<CommentModel> comments;

  PostDetailModel({
    required super.id,
    required super.title,
    required super.content,
    required this.comments,
  });

  factory PostDetailModel.fromJson(Map<String, dynamic> json) =>
      _$PostDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostDetailModelToJson(this);
}
