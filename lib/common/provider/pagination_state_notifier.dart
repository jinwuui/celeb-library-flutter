import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:eunbinlib_app/common/model/cursor_pagination_model.dart';
import 'package:eunbinlib_app/common/model/i_model_with_id.dart';
import 'package:eunbinlib_app/common/model/pagination_params.dart';
import 'package:eunbinlib_app/common/repository/i_pagination_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class _PaginationInfo {
  final int fetchCount;
  final bool fetchMore; // true - 추가로 데이터 가져오기, false - 새로고침 (덮어쓰기)
  final bool forceRefetch; // 강제 새로고침

  _PaginationInfo({
    this.fetchCount = 20,
    this.fetchMore = false,
    this.forceRefetch = false,
  });
}

class PaginationStateNotifier<T extends IModelWithId,
        U extends IPaginationRepository<T>>
    extends StateNotifier<CursorPaginationBase> {
  final U repository;
  final paginationThrottle = Throttle(
    Duration(seconds: 2),
    initialValue: _PaginationInfo(),
    checkEquality: false,
  );

  PaginationStateNotifier({
    required this.repository,
  }) : super(CursorPaginationLoading()) {
    // 클래스 인스턴스 생성 -> paginate 요청
    paginate();

    // throttle이 적용된 pagination을 위해 리스너 등록
    paginationThrottle.values.listen((state) {
      _throttlePagination(state);
    });
  }

  Future<void> paginate({
    int fetchCount = 20,
    bool fetchMore = false, // true - 추가로 데이터 가져오기, false - 새로고침 (덮어쓰기)
    bool forceRefetch = false, // true - 강제 새로고침
  }) async {
    paginationThrottle.setValue(
      _PaginationInfo(
        fetchCount: fetchCount,
        fetchMore: fetchMore,
        forceRefetch: forceRefetch,
      ),
    );
  }

  Future<void> _throttlePagination(_PaginationInfo info) async {
    final int fetchCount = info.fetchCount;
    final bool fetchMore = info.fetchMore;
    final bool forceRefetch = info.forceRefetch;

    try {
      if (_isStopPaginateStatus(
        fetchMore: fetchMore,
        forceRefetch: forceRefetch,
      )) {
        return;
      }

      PaginationParams paginationParams = PaginationParams(
        size: fetchCount,
      );

      if (fetchMore) {
        final castedState = state as CursorPagination<T>;

        state = CursorPaginationFetchingMore<T>(
          meta: castedState.meta,
          data: castedState.data,
        );

        paginationParams = paginationParams.copyWith(
          after: castedState.data.last.id,
        );
      } else {
        if (state is CursorPagination && !forceRefetch) {
          // 기존 데이터를 화면에서 유지한 채로 새로운 데이터가 오면 바꿔치기
          final castedState = state as CursorPagination<T>;

          state = CursorPaginationRefetching<T>(
            meta: castedState.meta,
            data: castedState.data,
          );
        } else {
          state = CursorPaginationLoading();
        }
      }

      final res = await repository.paginate(
        paginationParams: paginationParams,
      );

      if (state is CursorPaginationFetchingMore) {
        final castedState = state as CursorPaginationFetchingMore<T>;

        // 기존 데이터에 새로운 데이터 추가
        state = res.copyWith(
          data: [...castedState.data, ...res.data],
        );
      } else {
        state = res;
      }
    } catch (e, trace) {
      print(e);
      print(trace);
      state = CursorPaginationError(message: '데이터를 가져오지 못했습니다.');
    }
  }

  bool _isStopPaginateStatus({
    required bool fetchMore,
    required bool forceRefetch,
  }) {
    // 바로 반환하는 상황
    // 1) hasMore == false (기존 상태에서 이미 다음 데이터가 없다는 값을 가지고 있다면 -> paginate() 실행할 필요 없음, 불러봤자 데이터 없음)

    // 2) 로딩중 - fetchMore == true -> 중복된 요청이 날아가버림
    //    fetchMore 가 아닐 때 - 새로고침의 의도가 있을 수 있다. (ex. 로딩중이었는데 사용자가 위로 올라가서 새로고침)

    if (state is CursorPagination && !forceRefetch) {
      final castedState = state as CursorPagination;

      if (!castedState.meta.hasMore) {
        // 1번 반환 상황
        // 서버에 요청해봤자 더 불러올 데이터 없음
        return true;
      }
    }

    // 로딩증을 의미하는 3가지 상태 확인
    final bool isLoading = state is CursorPaginationLoading;
    final bool isRefetching = state is CursorPaginationRefetching;
    final bool isFetchingMore = state is CursorPaginationFetchingMore;

    if (fetchMore && (isLoading || isRefetching || isFetchingMore)) {
      return true;
    }

    return false;
  }
}
