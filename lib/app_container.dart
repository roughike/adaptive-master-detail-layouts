import 'package:dictionary/model/word.dart';
import 'package:dictionary/item_details.dart';
import 'package:dictionary/word_listing.dart';
import 'package:flutter/material.dart';

class AppContainer extends StatefulWidget {
  @override
  _AppContainerState createState() =>
      _AppContainerState();
}

class _AppContainerState extends State<AppContainer> {
  static const int kTabletBreakpoint = 600;

  Word? _selectedWord;

  Widget _buildMobileLayout() {
    return WordListing(
      wordSelectedCallback: (word) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return WordDetails(
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
            child: WordListing(
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
          child: WordDetails(
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
        title: Text('Icelandic Vocabulary Database'),
      ),
      body: content,
    );
  }
}
