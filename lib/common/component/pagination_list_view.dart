import 'package:eunbinlib_app/common/const/data.dart';
import 'package:eunbinlib_app/common/model/cursor_pagination_model.dart';
import 'package:eunbinlib_app/common/model/i_model_with_id.dart';
import 'package:eunbinlib_app/common/provider/pagination_state_notifier.dart';
import 'package:eunbinlib_app/common/utils/pagination_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef PaginationWidgetBuilder<T extends IModelWithId> = Widget Function(
  BuildContext context,
  int index,
  T model,
);

class PaginationListView<T extends IModelWithId>
    extends ConsumerStatefulWidget {
  final StateNotifierProvider<PaginationStateNotifier, CursorPaginationBase>
      provider;
  final PaginationWidgetBuilder<T> itemBuilder;

  const PaginationListView({
    required this.provider,
    required this.itemBuilder,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<PaginationListView> createState() =>
      _PaginationListViewState<T>();
}

class _PaginationListViewState<T extends IModelWithId>
    extends ConsumerState<PaginationListView> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();

    controller.addListener(_listener);
  }

  void _listener() {
    PaginationUtils.paginate(
      controller: controller,
      stateNotifier: ref.read(widget.provider.notifier),
    );
  }

  @override
  void dispose() {
    controller.removeListener(_listener);
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(widget.provider);

    // 로딩 중
    if (state is CursorPaginationLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    // 에러
    if (state is CursorPaginationError) {
      return _renderErrorScreen(message: state.message);
    }

    final castedState = state as CursorPagination<T>;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: md),
      child: RefreshIndicator(
        onRefresh: () async {
          ref.read(widget.provider.notifier).paginate(
                forceRefetch: true,
              );
        },
        child: ListView.separated(
          physics: AlwaysScrollableScrollPhysics(),
          controller: controller,
          itemCount: castedState.data.length + 1,
          itemBuilder: (_, index) {
            if (index == castedState.data.length) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: sm),
                child: Center(
                  child: castedState is CursorPaginationFetchingMore
                      ? CircularProgressIndicator()
                      : Text('마지막 데이터입니다 ㅠㅠ'),
                ),
              );
            }

            final item = castedState.data[index];

            return widget.itemBuilder(
              context,
              index,
              item,
            );
          },
          separatorBuilder: (_, index) => const SizedBox(height: md),
        ),
      ),
    );
  }

  Widget _renderErrorScreen({
    required String message,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          message,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            ref.read(widget.provider.notifier).paginate(
                  forceRefetch: true,
                );
          },
          child: Text('다시시도'),
        ),
      ],
    );
  }
}
