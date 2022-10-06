import 'package:eunbinlib_app/common/model/cursor_pagination_model.dart';
import 'package:eunbinlib_app/common/model/i_model_with_id.dart';
import 'package:eunbinlib_app/common/model/pagination_params.dart';

abstract class IPaginationRepository<T extends IModelWithId> {
  Future<CursorPagination<T>> paginate({
    PaginationParams? paginationParams = const PaginationParams(),
  });
}
