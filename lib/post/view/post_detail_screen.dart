import 'package:eunbinlib_app/common/layout/default_layout.dart';
import 'package:flutter/material.dart';

class PostDetailScreen extends StatelessWidget {
  static String get routeName => 'postDetail';
  final String id;

  const PostDetailScreen({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '게시글',
      child: Center(
        child: Text('게시글 상세정보 화면'),
      ),
    );
  }
}
