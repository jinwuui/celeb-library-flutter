import 'package:eunbinlib_app/common/provider/pagination_state_notifier.dart';
import 'package:flutter/material.dart';

class PaginationUtils {
  static void paginate({
    required ScrollController controller,
    required PaginationStateNotifier stateNotifier,
  }) {
    // 현재 위치가 최대 길이보다 조금 덜 되는 위치까지 왔다면
    // -> 새 데이터 추가 요청
    if (controller.offset > controller.position.maxScrollExtent - 300) {
      stateNotifier.paginate(
        fetchMore: true,
      );
    }
  }
}
