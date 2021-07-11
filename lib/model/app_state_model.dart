import 'package:collection/collection.dart' show IterableExtension;
import 'package:dictionary/model/database_helper.dart';
import 'package:dictionary/model/word.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;

class AppStateModel extends foundation.ChangeNotifier {
  List<Word> _words = [];
  List<Conjugation> _conjugations = [];
  List<Declension> _declensions = [];

  int? selectedId;

  final formKey = GlobalKey<FormState>();

  List get words {
    return [..._words];
  }

  List get conjugations {
    return [..._conjugations];
  }

  List get declensions {
    return [..._declensions];
  }

  Word? getWord(int? id) {
    return _words.firstWhereOrNull((v) => v.id == id);
  }

  Conjugation? getConjugation(int? id) {
    Conjugation? _conjugation =
        _conjugations.firstWhereOrNull((congugation) => congugation.id == id);
    return _conjugation;
  }

  Declension? getDeclension(int? id) {
    Declension? _declension =
        _declensions.firstWhereOrNull((declension) => declension.id == id);
    return _declension;
  }

  Future deleteWord(int? id) {
    _words.removeWhere((v) => v.id == id);
    if (id == selectedId) {
      selectedId = null;
    }
    notifyListeners();
    return DatabaseHelper.deleteWord(id);
  }

  Future deleteConjugation(int? id) {
    _conjugations.removeWhere((conjugation) => conjugation.id == id);
    if (id == selectedId) {
      selectedId = null;
    }
    notifyListeners();
    return DatabaseHelper.deleteConjugation(id);
  }

  Future deleteDeclension(int? id) {
    _declensions.removeWhere((declension) => declension.id == id);
    if (id == selectedId) {
      selectedId = null;
    }
    notifyListeners();
    return DatabaseHelper.deleteDeclension(id);
  }

  void selectWord(int? id) {
    selectedId = id;
    notifyListeners();
  }

  Future upsertVerb(Word word, Conjugation conjugation) async {
    if (word.id == null) {
      word.id = DateTime.now().millisecondsSinceEpoch;
      conjugation.id = word.id;
      _words.insert(0, word);
    } else {
      _words[_words.indexWhere((v) => v.id == word.id)] = word;
    }

    DatabaseHelper.insertWord({
      'word_id': word.id,
      'part_id': 2,
      'isl': word.isl,
      'eng': word.eng,
    });

    _upsertConjugation(conjugation);

    notifyListeners();
  }

  Future _upsertConjugation(Conjugation conjugation) async {
    int insertIndex = _conjugations.indexWhere((c) => c.id == conjugation.id);
    if (insertIndex == -1) {
      _conjugations.insert(0, conjugation);
    } else {
      _conjugations[insertIndex] = conjugation;
    }

    DatabaseHelper.insertConjugation({
      'verb_id': conjugation.id,
      'rule_id': conjugation.rule,
      'tense_id': conjugation.tense,
      'fp1_isl': conjugation.fp1Isl,
      'fp1_eng': conjugation.fp1Eng,
      'sp1_isl': conjugation.sp1Isl,
      'sp1_eng': conjugation.sp1Eng,
      'tp1_isl': conjugation.tp1Isl,
      'tp1_eng': conjugation.tp1Eng,
      'fp2_isl': conjugation.fp2Isl,
      'fp2_eng': conjugation.fp2Eng,
      'sp2_isl': conjugation.sp2Isl,
      'sp2_eng': conjugation.sp2Eng,
      'tp2_isl': conjugation.tp2Isl,
      'tp2_eng': conjugation.tp2Eng,
    });
  }

  Future upsertNoun(Word word, Declension declension) async {
    if (word.id == null) {
      word.id = DateTime.now().millisecondsSinceEpoch;
      declension.id = word.id;
      _words.insert(0, word);
    } else {
      _words[_words.indexWhere((v) => v.id == word.id)] = word;
    }

    DatabaseHelper.insertWord({
      'word_id': word.id,
      'part_id': 0,
      'isl': word.isl,
      'eng': word.eng,
    });

    _upsertDeclension(declension);

    notifyListeners();
  }

  Future _upsertDeclension(Declension declension) async {
    int insertIndex = _conjugations.indexWhere((c) => c.id == declension.id);
    if (insertIndex == -1) {
      _declensions.insert(0, declension);
    } else {
      _declensions[insertIndex] = declension;
    }

    DatabaseHelper.insertDeclension({
      'noun_id': declension.id,
      'gender_id': declension.gender,
      'nefnifall': declension.nefnifall,
      'nominative': declension.nominative,
      'tholfall': declension.tholfall,
      'accusative': declension.accusative,
      'thaugufall': declension.thaugufall,
      'dative': declension.dative,
      'eignarfall': declension.eignarfall,
      'genitive': declension.genitive,
    });
  }

  List<Word> getWords() {
    return _words;
  }

  List<Conjugation> getConjugations() {
    return _conjugations;
  }

  List<Declension> getDeclensions() {
    return _declensions;
  }

  void loadWords() async {
    final wordList = await (DatabaseHelper.getWordsFromDB());

    _words = wordList!
        .map(
          (v) => Word(v['word_id'], v['part_id'], v['isl'], v['eng']),
        )
        .toList();

    final conjugationList = await (DatabaseHelper.getConjugationsFromDB());

    _conjugations = conjugationList!
        .map(
          (conjugation) => Conjugation(
              conjugation['verb_id'],
              conjugation['rule_id'],
              conjugation['tense_id'],
              conjugation['fp1_isl'],
              conjugation['fp1_eng'],
              conjugation['sp1_isl'],
              conjugation['sp1_eng'],
              conjugation['tp1_isl'],
              conjugation['tp1_eng'],
              conjugation['fp2_isl'],
              conjugation['fp2_eng'],
              conjugation['sp2_isl'],
              conjugation['sp2_eng'],
              conjugation['tp2_isl'],
              conjugation['tp2_eng']),
        )
        .toList();

    final declensionList = await (DatabaseHelper.getDeclensionsFromDB());

    _declensions = declensionList!
        .map(
          (declension) => Declension(
        declension['noun_id'],
        declension['gender_id'],
        declension['nefnifall'],
        declension['nominative'],
        declension['tholfall'],
        declension['accusative'],
        declension['thaugufall'],
        declension['dative'],
        declension['eignarfall'],
        declension['genitive'],
      ),
    )
        .toList();

    notifyListeners();
  }

  List<Word> search(String searchTerms) {
    List<Word> combined = searchIsl(searchTerms)
      ..addAll(searchEng(searchTerms));
    return combined.toSet().toList(); // Deduplicate the combined lists
  }

  List<Word> searchIsl(String searchTerms) {
    return getWords().where((v) {
      return v.isl.toLowerCase().contains(searchTerms.toLowerCase());
    }).toList();
  }

  List<Word> searchEng(String searchTerms) {
    return getWords().where((v) {
      return v.eng.toLowerCase().contains(searchTerms.toLowerCase());
    }).toList();
  }
}
