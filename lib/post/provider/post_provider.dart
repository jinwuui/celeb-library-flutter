import 'package:eunbinlib_app/common/model/cursor_pagination_model.dart';
import 'package:eunbinlib_app/common/provider/pagination_state_notifier.dart';
import 'package:eunbinlib_app/post/model/post_model.dart';
import 'package:eunbinlib_app/post/repository/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postProvider =
    StateNotifierProvider<PostStateNotifier, CursorPaginationBase>((ref) {
  final repository = ref.watch(postRepositoryProvider);

  return PostStateNotifier(
    repository: repository,
  );
});

class PostStateNotifier
    extends PaginationStateNotifier<PostModel, PostRepository> {
  PostStateNotifier({
    required super.repository,
  });

  void getDetail() {}
}
