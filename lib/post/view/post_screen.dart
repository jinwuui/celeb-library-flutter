import 'package:eunbinlib_app/post/component/post_card.dart';
import 'package:eunbinlib_app/post/view/post_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: RefreshIndicator(
          onRefresh: () async {
            print('리프레시');
          },
          child: ListView.separated(
            physics: AlwaysScrollableScrollPhysics(),
            // controller: controller,
            itemCount: 20,
            itemBuilder: (_, index) {
              if (index == 19) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                  // child: Center(
                  //   child: cp is CursorPaginationFetchingMore
                  //       ? CircularProgressIndicator()
                  //       : Text('마지막 데이터입니다ㅠㅠ'),
                  // ),
                );
              }

              return GestureDetector(
                onTap: () {
                  context.goNamed(
                    PostDetailScreen.routeName,
                    params: {
                      'pid': 'test pid',
                    },
                  );
                },
                child: PostCard(),
              );
            },
            separatorBuilder: (_, index) => const SizedBox(height: 16),
          ),
        ),
      ),
    );
  }
}
