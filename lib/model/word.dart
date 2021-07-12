import 'package:intl/intl.dart';

class Word {
  int? id;
  String isl;
  String eng;
  int partId;

  Word(this.id, this.partId, this.isl, this.eng);

  String get date {
    final date = DateTime.fromMillisecondsSinceEpoch(id!);
    return DateFormat('EEE h:mm a, dd/MM/yyyy').format(date);
  }
}

class Conjugation {
  int? id;
  int rule;
  int tense;

  String fp1Isl;
  String fp1Eng;
  String sp1Isl;
  String sp1Eng;
  String tp1Isl;
  String tp1Eng;
  String fp2Isl;
  String fp2Eng;
  String sp2Isl;
  String sp2Eng;
  String tp2Isl;
  String tp2Eng;

  Conjugation(
    this.id,
    this.rule,
    this.tense,
    this.fp1Isl,
    this.fp1Eng,
    this.sp1Isl,
    this.sp1Eng,
    this.tp1Isl,
    this.tp1Eng,
    this.fp2Isl,
    this.fp2Eng,
    this.sp2Isl,
    this.sp2Eng,
    this.tp2Isl,
    this.tp2Eng,
  );
}

class Declension {
  int? id;
  int gender;

  String nefnifall;
  String nominative;
  String tholfall;
  String accusative;
  String thaugufall;
  String dative;
  String eignarfall;
  String genitive;

  Declension(
      this.id,
      this.gender,
      this.nefnifall,
      this.nominative,
      this.tholfall,
      this.accusative,
      this.thaugufall,
      this.dative,
      this.eignarfall,
      this.genitive,
      );
}