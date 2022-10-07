import 'package:json_annotation/json_annotation.dart';

part 'post_write_req.g.dart';

@JsonSerializable()
class PostWriteReq {
  final String title;
  final String content;
  // final List<String> images; // TODO : 이미지 넣는 방식으로 변경 (multipart)

  PostWriteReq({
    required this.title,
    required this.content,
    // required this.images,
  });

  Map<String, dynamic> toJson() => _$PostWriteReqToJson(this);
}
