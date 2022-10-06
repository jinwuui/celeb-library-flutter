import 'package:dio/dio.dart' hide Headers;
import 'package:eunbinlib_app/common/const/data.dart';
import 'package:eunbinlib_app/common/model/cursor_pagination_model.dart';
import 'package:eunbinlib_app/common/model/pagination_params.dart';
import 'package:eunbinlib_app/common/provider/dio_provider.dart';
import 'package:eunbinlib_app/common/repository/i_pagination_repository.dart';
import 'package:eunbinlib_app/post/model/post_edit_req.dart';
import 'package:eunbinlib_app/post/model/post_model.dart';
import 'package:eunbinlib_app/post/model/post_write_req.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';

part 'post_repository.g.dart';

final postRepositoryProvider = Provider<PostRepository>((ref) {
  final dio = ref.watch(dioProvider);

  return PostRepository(
    dio,
    baseUrl: POST_BASE_URL,
  );
});

@RestApi()
abstract class PostRepository implements IPaginationRepository<PostModel> {
  factory PostRepository(Dio dio, {String baseUrl}) = _PostRepository;

  @override
  @GET('/')
  @Headers({ACCESS_TOKEN: true})
  Future<CursorPagination<PostModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });

  @GET('/{id}')
  @Headers({ACCESS_TOKEN: true})
  Future<PostModel> getPostDetail({
    @Path() required String id,
  });

  @POST('/')
  @Headers({ACCESS_TOKEN: true})
  Future<PostModel> writePost({
    required PostWriteReq postWriteReq,
  });

  @PATCH('/{id}')
  @Headers({ACCESS_TOKEN: true})
  Future<PostModel> editPost({
    @Path() required String id,
    required PostEditReq postEditReq,
  });

  @DELETE('/{id}')
  @Headers({ACCESS_TOKEN: true})
  Future<void> deletePost({
    @Path() required String id,
  });
}
