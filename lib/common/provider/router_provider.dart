import 'package:eunbinlib_app/common/view/root_tab.dart';
import 'package:eunbinlib_app/common/view/splash_screen.dart';
import 'package:eunbinlib_app/post/view/post_detail_screen.dart';
import 'package:eunbinlib_app/post/view/post_screen.dart';
import 'package:eunbinlib_app/post/view/post_write_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/splash',
  routes: <GoRoute>[
    GoRoute(
        path: '/',
        name: RootTab.routeName,
        builder: (_, __) => RootTab(),
        routes: [
          GoRoute(
            path: 'post/:pid',
            name: PostDetailScreen.routeName,
            builder: (_, state) => PostDetailScreen(
              id: state.params['pid']!,
            ),
          ),
          GoRoute(
            path: 'postWrite',
            name: PostWriteScreen.routeName,
            builder: (_, __) => PostWriteScreen(),
          ),
        ]),
    GoRoute(
      path: '/splash',
      name: SplashScreen.routeName,
      builder: (_, __) => SplashScreen(),
    ),
  ],
);
