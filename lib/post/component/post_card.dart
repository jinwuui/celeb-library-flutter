import 'package:eunbinlib_app/common/const/colors.dart';
import 'package:eunbinlib_app/common/const/data.dart';
import 'package:eunbinlib_app/post/model/post_model.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final String content;
  final Image? image;
  final String writer;
  final int likeCount;
  final int commentCount;
  final DateTime createdAt;

  const PostCard({
    required this.content,
    this.image,
    required this.writer,
    required this.likeCount,
    required this.commentCount,
    required this.createdAt,
    Key? key,
  }) : super(key: key);

  factory PostCard.fromModel({
    required PostModel model,
  }) {
    return PostCard(
      content: model.content,
      writer: model.writer,
      likeCount: model.likeCount,
      commentCount: model.commentCount,
      image: model.imageUrl != null
          ? Image.network(
              model.imageUrl!,
              fit: BoxFit.cover,
            )
          : null,
      createdAt: model.createdAt,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: BORDER_GREY_COLOR,
          ),
        ),
      ),
      padding: const EdgeInsets.all(md),
      child: Column(
        children: [
          Text(
            '제목입니다. 내용입니다. 제목입니다. 내용입니다. 제목입니다. 내용입니다. 제목입니다. 내용입니다. 제목입니다. 내용입니다. 제목입니다. 내용입니다.',
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(
              fontSize: md,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: md),
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.asset(
              'asset/img/인사.jpeg',
            ),
          ),
          const SizedBox(height: md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '닉네임 • 추천수 • 댓글수',
                style: TextStyle(
                  color: BODY_TEXT_COLOR,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '등록시간',
                style: TextStyle(
                  color: BODY_TEXT_COLOR,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
