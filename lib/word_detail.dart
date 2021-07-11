import 'package:dictionary/model/word.dart';
import 'package:flutter/material.dart';

class WordDetail extends StatelessWidget {
  WordDetail({
    required this.isInTabletLayout,
    required this.word,
  });

  final bool isInTabletLayout;
  final Word? word;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Widget content = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          word?.isl ?? 'No word selected',
          style: textTheme.headline5,
        ),
        Text(
          word?.eng ?? 'Please select a word',
          style: textTheme.subtitle1,
        ),
      ],
    );

    if (isInTabletLayout) {
      return Center(child: content);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(word!.isl),
      ),
      body: Center(child: content),
    );
  }
}
