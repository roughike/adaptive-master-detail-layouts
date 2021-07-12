import 'package:dictionary/model/app_state_model.dart';
import 'package:dictionary/model/word.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WordList extends StatefulWidget {
  WordList({
    required this.wordSelectedCallback,
    this.selectedWord,
  });

  final ValueChanged<Word> wordSelectedCallback;
  final Word? selectedWord;

  @override
  _WordListState createState() => _WordListState();
}

class _WordListState extends State<WordList> {

  @override
  Widget build(BuildContext context) {
    String _terms = '';

    final model = Provider.of<AppStateModel>(context);
    final results = model.search(_terms);

    return ListView(
      children: results.map((word) {
        return ListTile(
          title: Text(word.isl),
          subtitle: Text(word.eng),
          onTap: () => widget.wordSelectedCallback(word),
          selected: widget.selectedWord == word,
        );
      }).toList(),
    );
  }
}
