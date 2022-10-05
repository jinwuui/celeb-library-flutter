import 'package:eunbinlib_app/common/const/colors.dart';
import 'package:eunbinlib_app/common/const/data.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  const PostCard({Key? key}) : super(key: key);

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
