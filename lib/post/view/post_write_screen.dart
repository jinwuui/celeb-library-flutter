import 'package:eunbinlib_app/common/component/custom_text_form_field.dart';
import 'package:eunbinlib_app/common/const/data.dart';
import 'package:eunbinlib_app/common/layout/default_layout.dart';
import 'package:eunbinlib_app/common/model/only_id.dart';
import 'package:eunbinlib_app/common/model/status_model.dart';
import 'package:eunbinlib_app/post/provider/post_change_provider.dart';
import 'package:eunbinlib_app/post/view/post_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PostWriteScreen extends ConsumerStatefulWidget {
  static String get routeName => 'postWrite';

  const PostWriteScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<PostWriteScreen> createState() => _PostWriteScreenState();
}

class _PostWriteScreenState extends ConsumerState<PostWriteScreen> {
  String title = '';
  String content = '';
  List<String> images = [];

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(postChangeProvider);

    return DefaultLayout(
      showUnderLine: true,
      title: '글쓰기',
      actions: [
        TextButton(
          onPressed: _validateTitleAndContent() && state is! LoadingStatus
              ? () async {
                  final OnlyId? result =
                      await ref.read(postChangeProvider.notifier).write(
                            title: title,
                            content: content,
                          );

                  if (result != null) {
                    context.goNamed(
                      PostDetailScreen.routeName,
                      params: {
                        'pid': result.id.toString(),
                      },
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('글쓰기 실패!'),
                      ),
                    );
                  }
                }
              : null,
          child: Text('완료'),
          style: TextButton.styleFrom(
            foregroundColor: Colors.black,
            textStyle: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: md,
            ),
          ),
        ),
      ],
      child: Stack(
        children: [
          SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                children: [
                  CustomTextFormField(
                    onChanged: (value) {
                      setState(() {
                        title = value;
                      });
                    },
                    hintText: '제목',
                  ),
                  const Divider(
                    color: Colors.black54,
                    height: 0,
                    thickness: 0.5,
                  ),
                  CustomTextFormField(
                    onChanged: (value) {
                      setState(() {
                        content = value;
                      });
                    },
                    hintText: '내용',
                    multiline: true,
                    maxLines: null,
                  ),

                  // 사진 추가 // 키보드 attach바 // 나중에 유튜브 추가도 넣어서 url 붙여 넣으면 동영상 화면 나오도록 해볼까
                ],
              ),
            ),
          ),
          if (state is LoadingStatus)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }

  bool _validateTitleAndContent() {
    return content.trim().isNotEmpty && title.trim().isNotEmpty;
  }
}
