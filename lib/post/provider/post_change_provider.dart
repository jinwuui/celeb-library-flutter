import 'package:eunbinlib_app/common/model/only_id.dart';
import 'package:eunbinlib_app/common/model/status_model.dart';
import 'package:eunbinlib_app/post/model/post_edit_req.dart';
import 'package:eunbinlib_app/post/model/post_write_req.dart';
import 'package:eunbinlib_app/post/repository/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postChangeProvider = StateNotifierProvider.autoDispose((ref) {
  final repository = ref.watch(postRepositoryProvider);

  return PostChangeStateNotifier(
    repository: repository,
  );
});

class PostChangeStateNotifier extends StateNotifier<StatusBase> {
  final PostRepository repository;

  PostChangeStateNotifier({
    required this.repository,
  }) : super(InitStatus());

  Future<OnlyId?> write({
    required String title,
    required String content,
  }) async {
    state = LoadingStatus();

    try {
      PostWriteReq postWriteReq = PostWriteReq(
        title: title,
        content: content,
      );

      final OnlyId res = await repository.writePost(postWriteReq: postWriteReq);

      state = SuccessStatus();
      return res;
    } catch (e) {
      state = ErrorStatus(message: '글 등록 실패!', error: e.toString());
      return null;
    }
  }

  Future<void> edit({
    required int id,
    required String title,
    required String content,
  }) async {
    state = LoadingStatus();

    try {
      PostEditReq postEditReq = PostEditReq(
        title: title,
        content: content,
      );

      await repository.editPost(postId: id, postEditReq: postEditReq);

      state = SuccessStatus();
    } catch (e) {
      state = ErrorStatus(message: '글 수정 실패!', error: e.toString());
    }
  }

  Future<void> delete({
    required int id,
  }) async {
    state = LoadingStatus();

    try {
      await repository.deletePost(postId: id);

      state = SuccessStatus();
    } catch (e) {
      state = ErrorStatus(message: '글 삭제 실패!', error: e.toString());
    }
  }
}
