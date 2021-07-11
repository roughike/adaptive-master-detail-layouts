import 'package:dictionary/model/app_state_model.dart';
import 'package:dictionary/model/word.dart';
// import 'package:dictionary/word_detail.dart';
import 'package:dictionary/word_edit.dart';
import 'package:dictionary/word_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppContainer extends StatefulWidget {
  @override
  _AppContainerState createState() =>
      _AppContainerState();
}

class _AppContainerState extends State<AppContainer> {
  static const int kTabletBreakpoint = 600;

  Word? _selectedWord;

  Widget _buildMobileLayout() {
    return WordList(
      wordSelectedCallback: (word) {
        Provider.of<AppStateModel>(context, listen: false)
            .selectWord(word.id);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return WordEdit(
                isInTabletLayout: false,
                word: word,
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildTabletLayout() {
    return Row(
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Material(
            elevation: 4.0,
            child: WordList(
              wordSelectedCallback: (word) {
                setState(() {
                  _selectedWord = word;
                });
              },
              selectedWord: _selectedWord,
            ),
          ),
        ),
        Flexible(
          flex: 3,
          child: WordEdit(
            isInTabletLayout: true,
            word: _selectedWord,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;

    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobileLayout();
    } else {
      content = _buildTabletLayout();
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.search),
          onPressed: () { }
        ),
        title: Text('Icelandic Vocabulary Database'),
      ),
      body: content,
    );
  }
}
