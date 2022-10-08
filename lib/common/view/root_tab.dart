import 'package:eunbinlib_app/common/const/colors.dart';
import 'package:eunbinlib_app/common/const/data.dart';
import 'package:eunbinlib_app/common/layout/default_layout.dart';
import 'package:eunbinlib_app/feed/view/feed_screen.dart';
import 'package:eunbinlib_app/post/view/post_detail_screen.dart';
import 'package:eunbinlib_app/post/view/post_screen.dart';
import 'package:eunbinlib_app/post/view/post_write_screen.dart';
import 'package:eunbinlib_app/user/view/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RootTab extends StatefulWidget {
  static String get routeName => 'root';

  const RootTab({Key? key}) : super(key: key);

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  late TabController controller;
  int index = 0;
  static const List<int> fabWhiteList = [1];

  @override
  void initState() {
    super.initState();

    controller = TabController(length: 3, vsync: this);

    controller.addListener(tabListener);
  }

  @override
  void dispose() {
    controller.removeListener(tabListener);

    super.dispose();
  }

  void tabListener() {
    setState(() {
      index = controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      floatingActionButton:
          fabWhiteList.contains(index) ? _renderWritePostFab() : null,
      child: TabBarView(
        controller: controller,
        physics: NeverScrollableScrollPhysics(),
        children: [
          FeedScreen(),
          PostScreen(),
          // PostDetailScreen(id: '1'),
          UserScreen(),
        ],
      ),
      title: '바군빈 도서관',
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: BODY_TEXT_COLOR,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          controller.animateTo(index);
        },
        currentIndex: index,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.feed_outlined),
            label: '커뮤니티',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: '프로필',
          ),
        ],
      ),
    );
  }

  Widget _renderWritePostFab() {
    return FloatingActionButton(
      backgroundColor: PRIMARY_COLOR,
      onPressed: () {
        print('게시글 등록');
        context.goNamed(PostWriteScreen.routeName);
      },
      child: Icon(
        Icons.add_rounded,
        size: xl,
      ),
    );
  }
}
