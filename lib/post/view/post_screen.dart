import 'package:eunbinlib_app/common/component/pagination_list_view.dart';
import 'package:eunbinlib_app/post/component/post_card.dart';
import 'package:eunbinlib_app/post/model/post_model.dart';
import 'package:eunbinlib_app/post/provider/post_provider.dart';
import 'package:eunbinlib_app/post/view/post_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PaginationListView<PostModel>(
      backgroundColor: Colors.grey.shade200,
      showPadding: false,
      provider: postProvider,
      itemBuilder: <PostModel>(_, index, model) {
        return GestureDetector(
          onTap: () {
            print('go to detail screen');
            print(model.id);
            context.goNamed(
              PostDetailScreen.routeName,
              params: {
                'pid': model.id,
              },
            );
          },
          child: PostCard.fromModel(
            model: model,
          ),
        );
      },
    );
  }
}
