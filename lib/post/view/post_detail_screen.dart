import 'package:eunbinlib_app/common/const/const_widget.dart';
import 'package:eunbinlib_app/common/const/data.dart';
import 'package:eunbinlib_app/common/layout/default_layout.dart';
import 'package:eunbinlib_app/post/component/comment_card.dart';
import 'package:eunbinlib_app/post/model/comment_model.dart';
import 'package:eunbinlib_app/post/model/post_detail_model.dart';
import 'package:eunbinlib_app/post/model/post_model.dart';
import 'package:eunbinlib_app/post/provider/post_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostDetailScreen extends ConsumerWidget {
  static String get routeName => 'postDetail';

  final int id;

  const PostDetailScreen({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(postDetailProvider(id));

    if (state == null) {
      return DefaultLayout(
        child: Center(
          child: greenIndicator,
        ),
      );
    }

    return DefaultLayout(
      title: '게시글',
      showUnderLine: true,
      child: Padding(
        padding: const EdgeInsets.all(md),
        child: CustomScrollView(
          slivers: [
            renderTitle(post: state),
            if (state is! PostDetailModel) renderLoading(),
            if (state is PostDetailModel) renderDetail(postDetail: state),
            if (state is PostDetailModel)
              renderComments(
                comments: state.comments,
              ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter renderTitle({
    required PostModel post,
  }) {
    return SliverToBoxAdapter(
      child: Text(
        post.title,
        style: TextStyle(
          fontSize: lg,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  SliverToBoxAdapter renderDetail({
    required PostDetailModel postDetail,
  }) {
    return SliverToBoxAdapter(
      child: Text(postDetail.content),
    );
  }

  Widget renderComments({
    required List<CommentModel> comments,
  }) {
    return ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return CommentCard();
        });
  }

  SliverPadding renderLoading() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          List.generate(
            4,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: greenIndicator,
              // child: SkeletonParagraph(
              //   style: SkeletonParagraphStyle(
              //     lines: 5,
              //     padding: EdgeInsets.zero,
              //   ),
              // ),
            ),
          ),
        ),
      ),
    );
  }
}
