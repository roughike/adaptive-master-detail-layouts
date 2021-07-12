import 'package:dictionary/model/app_state_model.dart';
import 'package:dictionary/model/word.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WordEdit extends StatefulWidget {
  WordEdit({
    required this.isInTabletLayout,
    required this.word,
  });

  final bool isInTabletLayout;
  Word? word;

  @override
  _WordEditState createState() => _WordEditState();
}

class _WordEditState extends State<WordEdit> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController islController = TextEditingController();
  TextEditingController engController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    if (widget.word == null)
      widget.word = Word(null, 0, '', '');

    islController.text = widget.word!.isl;
    engController.text = widget.word!.eng;

    // final TextTheme textTheme = Theme.of(context).textTheme;

    final Widget content = Form(
        key: _formKey,
        child: Scrollbar(
          child: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        filled: true,
                        hintText: '',
                        labelText: 'Icelandic',
                      ),
                      controller: islController,
                      onFieldSubmitted: (value) {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                        }
                      },
                      autocorrect: false,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        filled: true,
                        hintText: '',
                        labelText: 'English',
                      ),
                      controller: engController,
                      onFieldSubmitted: (value) {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                        }
                      },
                      autocorrect: false,
                    ),
                    MaterialButton(
                      onPressed: () => _onSubmit(),
                      child: Text('Submit'),
                    ),
                  ],
                )
              )
            )
          )

        )
      );

    if (widget.isInTabletLayout) {
      return Center(child: content);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.word!.isl),
      ),
      body: Center(child: content),
    );
  }
  
  @override
  void dispose() {
    islController.dispose();
    engController.dispose();
    super.dispose();
  }

  _onSubmit() {
    var form = _formKey.currentState!;
    Word word = Word(null, 1, islController.text.trim(), engController.text.trim());
    if (form.validate()) {
      Provider.of<AppStateModel>(this.context, listen: false)
          .upsertWord(word);
      _resetForm();
    }
  }

  _resetForm() {
    setState(() {
      _formKey.currentState!.reset();

      islController.clear();
      engController.clear();
    });
  }
}
