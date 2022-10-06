import 'package:eunbinlib_app/common/model/cursor_pagination_meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cursor_pagination_model.g.dart';

class CursorPaginationBase {}

// 1) CursorPagination - 정상적으로 데이터가 있는 상태

// 2) CursorPaginationLoading - 데이터가 로딩중인 상태 (현재 캐시 없음)

// 3) CursorPaginationError - 에러가 있는 상태

// 4) CursorPaginationRefetching - 첫번째 페이지부터 다시 데이터 가져올 때

// 5) CursorPaginationFetchingMore - 추가 데이터를 paginate 하라는 요청을 받았을 때

class CursorPaginationError extends CursorPaginationBase {
  final String message;

  CursorPaginationError({
    required this.message,
  });
}

class CursorPaginationLoading extends CursorPaginationBase {}

@JsonSerializable(
  genericArgumentFactories: true,
)
class CursorPagination<T> extends CursorPaginationBase {
  final CursorPaginationMeta meta;
  final List<T> data;

  CursorPagination({
    required this.meta,
    required this.data,
  });

  CursorPagination copyWith({
    CursorPaginationMeta? meta,
    List<T>? data,
  }) {
    return CursorPagination<T>(
      meta: meta ?? this.meta,
      data: data ?? this.data,
    );
  }

  factory CursorPagination.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$CursorPaginationFromJson(json, fromJsonT);
}

// 새로고침 진행중
class CursorPaginationRefetching<T> extends CursorPagination<T> {
  CursorPaginationRefetching({
    required CursorPaginationMeta meta,
    required List<T> data,
  }) : super(meta: meta, data: data);
}

// 더 불러오기 진행중
class CursorPaginationFetchingMore<T> extends CursorPagination<T> {
  CursorPaginationFetchingMore({
    required CursorPaginationMeta meta,
    required List<T> data,
  }) : super(meta: meta, data: data);
}
