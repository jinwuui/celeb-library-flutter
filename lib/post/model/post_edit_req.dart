import 'package:json_annotation/json_annotation.dart';

part 'post_edit_req.g.dart';

@JsonSerializable()
class PostEditReq {
  final String content;
  final List<String> images; // TODO : 이미지 넣는 방식으로 변경 (multipart)

  PostEditReq({
    required this.content,
    required this.images,
  });

  Map<String, dynamic> toJson() => _$PostEditReqToJson(this);
}
