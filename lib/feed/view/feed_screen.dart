import 'package:flutter/material.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      // child: AssetImage('asset/img/토끼대장.gif'),
      child: Image.asset(
        'asset/img/토끼대장.gif',
      ),
    );
  }
}
