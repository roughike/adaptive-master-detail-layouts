import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Future _create(Database db, int version) async {
    await db.execute("""
      CREATE TABLE 'rule' (
        'rule_id' INTEGER NOT NULL,
        'rule' TEXT NOT NULL,
        PRIMARY KEY ('rule_id')
      );
    )""");

    await db.execute("""
      INSERT INTO 'rule' ('rule_id', 'rule') VALUES (1, '1 (weak)');
    )""");

    await db.execute("""
      INSERT INTO 'rule' ('rule_id', 'rule') VALUES (2, '2 (weak)');
    )""");

    await db.execute("""
      INSERT INTO 'rule' ('rule_id', 'rule') VALUES (3, '1 (strong)');
    )""");

    await db.execute("""
      INSERT INTO 'rule' ('rule_id', 'rule') VALUES (4, '2 (strong)');
    )""");

    await db.execute("""
      INSERT INTO 'rule' ('rule_id', 'rule') VALUES (5, '3 (strong)');
    )""");

    await db.execute("""
      CREATE TABLE 'tense' (
        'tense_id' INTEGER NOT NULL,
        'tense' TEXT NOT NULL,
        PRIMARY KEY ('tense_id')
      );
    )""");

    await db.execute("""
      INSERT INTO 'tense' ('tense_id', 'tense') VALUES (1, 'Present');
    )""");

    await db.execute("""
      INSERT INTO 'tense' ('tense_id', 'tense') VALUES (2, 'Past');
    )""");

    await db.execute("""
      CREATE TABLE 'part_of_speech' (
        'part_id' INTEGER NOT NULL,
        'part_of_speech' TEXT NOT NULL,
        PRIMARY KEY ('part_id')
      );
    )""");

    await db.execute("""
      INSERT INTO 'part_of_speech' ('part_id', 'part_of_speech') VALUES (0, 'Noun');
    )""");

    await db.execute("""
      INSERT INTO 'part_of_speech' ('part_id', 'part_of_speech') VALUES (1, 'Pronouns');
    )""");

    await db.execute("""
      INSERT INTO 'part_of_speech' ('part_id', 'part_of_speech') VALUES (2, 'Verbs');
    )""");

    await db.execute("""
      INSERT INTO 'part_of_speech' ('part_id', 'part_of_speech') VALUES (3, 'Adjectives');
    )""");

    await db.execute("""
      INSERT INTO 'part_of_speech' ('part_id', 'part_of_speech') VALUES (4, 'Adverbs');
    )""");

    await db.execute("""
      INSERT INTO 'part_of_speech' ('part_id', 'part_of_speech') VALUES (5, 'Prepositions');
    )""");

    await db.execute("""
      INSERT INTO 'part_of_speech' ('part_id', 'part_of_speech') VALUES (6, 'Conjunctions');
    )""");

    await db.execute("""
      INSERT INTO 'part_of_speech' ('part_id', 'part_of_speech') VALUES (7, 'Interjections');
    )""");

    await db.execute("""
      INSERT INTO 'part_of_speech' ('part_id', 'part_of_speech') VALUES (8, 'Sayings');
    )""");

    await db.execute("""
      INSERT INTO 'part_of_speech' ('part_id', 'part_of_speech') VALUES (9, 'Phrases');
    )""");

    await db.execute("""
      CREATE TABLE 'word' (
        'word_id' INTEGER NOT NULL,
        'part_id' INTEGER NOT NULL,
        'isl' TEXT NOT NULL,
        'eng' TEXT NOT NULL,
        PRIMARY KEY ('word_id'),
        CONSTRAINT 'fk_word_part' FOREIGN KEY ('part_id') REFERENCES 'part_of_speech' ('part_id')
      );
    )""");

    await db.execute("""
      CREATE TABLE 'conjugation' (
        'verb_id' INTEGER NOT NULL,
        'tense_id' INTEGER NOT NULL,
        'rule_id' INTEGER NOT NULL,
        'fp1_isl' TEXT NOT NULL,
        'fp1_eng' TEXT NOT NULL,
        'sp1_isl' TEXT NOT NULL,
        'sp1_eng' TEXT NOT NULL,
        'tp1_isl' TEXT NOT NULL,
        'tp1_eng' TEXT NOT NULL,
        'fp2_isl' TEXT NOT NULL,
        'fp2_eng' TEXT NOT NULL,
        'sp2_isl' TEXT NOT NULL,
        'sp2_eng' TEXT NOT NULL,
        'tp2_isl' TEXT NOT NULL,
        'tp2_eng' TEXT NOT NULL,
        CONSTRAINT 'pk_verb_conjugation' PRIMARY KEY ('verb_id', 'tense_id'),
        CONSTRAINT 'fk_conjugation_word' FOREIGN KEY ('verb_id') REFERENCES 'word' ('word_id') ON DELETE CASCADE,
        CONSTRAINT 'fk_conguation_tense' FOREIGN KEY ('tense_id') REFERENCES 'tense' ('tense_id'),
        CONSTRAINT 'fk_conjugation_rule' FOREIGN KEY ('rule_id') REFERENCES 'rule' ('rule_id')
      );
    )""");

    await db.execute("""
      INSERT INTO "word" ("word_id", "part_id", "isl", "eng") VALUES (1622215123876, 2, 'fara', 'go');
    )""");

    await db.execute("""
      INSERT INTO "word" ("word_id", "part_id", "isl", "eng") VALUES (1622215194468, 2, 'fá', 'get');
    )""");

    await db.execute("""
      INSERT INTO "word" ("word_id", "part_id", "isl", "eng") VALUES (1622218496490, 2, 'vinna', 'win');
    )""");

    await db.execute("""
      INSERT INTO "word" ("word_id", "part_id", "isl", "eng") VALUES (1622218550581, 2, 'læri', 'learn');
    )""");

    await db.execute("""
      INSERT INTO "word" ("word_id", "part_id", "isl", "eng") VALUES (1622219704134, 2, 'tala', 'speak');
    )""");

    await db.execute("""
      INSERT INTO "conjugation" ("verb_id", "tense_id", "rule_id", "fp1_isl", "fp1_eng", "sp1_isl", "sp1_eng", "tp1_isl", "tp1_eng", "fp2_isl", "fp2_eng", "sp2_isl", "sp2_eng", "tp2_isl", "tp2_eng") VALUES (1622219704134, 1, 1, 'tala', 'speak', 'talar', 'speak', 'talar', 'speaks', 'tölum', 'speak', 'talið', 'speak', 'tala', 'speak');
    )""");

    await db.execute("""
      INSERT INTO "conjugation" ("verb_id", "tense_id", "rule_id", "fp1_isl", "fp1_eng", "sp1_isl", "sp1_eng", "tp1_isl", "tp1_eng", "fp2_isl", "fp2_eng", "sp2_isl", "sp2_eng", "tp2_isl", "tp2_eng") VALUES (1622218550581, 1, 2, 'læri', 'learn', 'lærir', 'learn', 'lærir', 'learns', 'lærum', 'learn', 'lærið', 'learn', 'læri', 'learn');
    )""");

    await db.execute("""
      INSERT INTO "conjugation" ("verb_id", "tense_id", "rule_id", "fp1_isl", "fp1_eng", "sp1_isl", "sp1_eng", "tp1_isl", "tp1_eng", "fp2_isl", "fp2_eng", "sp2_isl", "sp2_eng", "tp2_isl", "tp2_eng") VALUES (1622218496490, 1, 3, 'vinn', 'win', 'vinnur', 'win', 'vinnur', 'wins', 'vinnum', 'win', 'vinnið', 'win', 'vinna', 'win');
    )""");

    await db.execute("""
      INSERT INTO "conjugation" ("verb_id", "tense_id", "rule_id", "fp1_isl", "fp1_eng", "sp1_isl", "sp1_eng", "tp1_isl", "tp1_eng", "fp2_isl", "fp2_eng", "sp2_isl", "sp2_eng", "tp2_isl", "tp2_eng") VALUES (1622215194468, 1, 4, 'fæ', 'get', 'færð', 'get', 'fær', 'gets', 'fáum', 'get', 'fáið', 'get', 'fá', 'get');
    )""");

    await db.execute("""
      INSERT INTO "conjugation" ("verb_id", "tense_id", "rule_id", "fp1_isl", "fp1_eng", "sp1_isl", "sp1_eng", "tp1_isl", "tp1_eng", "fp2_isl", "fp2_eng", "sp2_isl", "sp2_eng", "tp2_isl", "tp2_eng") VALUES (1622215123876, 1, 5, 'fer', 'go', 'ferð', 'go', 'fer', 'goes', 'förum', 'go', 'farið', 'go', 'fara', 'go');
    )""");

    await db.execute("""
      INSERT INTO "conjugation" ("verb_id", "tense_id", "rule_id", "fp1_isl", "fp1_eng", "sp1_isl", "sp1_eng", "tp1_isl", "tp1_eng", "fp2_isl", "fp2_eng", "sp2_isl", "sp2_eng", "tp2_isl", "tp2_eng") VALUES (1622219704134, 2, 1, 'talaði', 'spoke', 'talaðir', 'spoke', 'talaði', 'spoke', 'töluðum', 'spoke', 'töluðuð', 'spoke', 'töluðu', 'spoke');
    )""");

    await db.execute("""
      CREATE TABLE 'gender' (
        'gender_id' INTEGER NOT NULL,
        'gender' TEXT NOT NULL,
        PRIMARY KEY ('gender_id')
      );
    )""");

    await db.execute("""
      INSERT INTO 'gender' ('gender_id', 'gender') VALUES (1, 'karlkyn');
    )""");

    await db.execute("""
      INSERT INTO 'gender' ('gender_id', 'gender') VALUES (2, 'kvenkyn');
    )""");

    await db.execute("""
      INSERT INTO 'gender' ('gender_id', 'gender') VALUES (3, 'hvorugkyn');
    )""");


    await db.execute("""
      CREATE TABLE 'declension' (
        'noun_id'     INTEGER NOT NULL,
        'gender_id'   INTEGER NOT NULL,
        'nefnifall'   TEXT NOT NULL,
        'nominative'  TEXT NOT NULL,
        'tholfall'    TEXT NOT NULL,
        'accusative'  TEXT NOT NULL,
        'thaugufall'  TEXT NOT NULL,
        'dative'      TEXT NOT NULL,
        'eignarfall'  TEXT NOT NULL,
        'genitive'    TEXT NOT NULL,
        CONSTRAINT 'pk_verb_conjugation' PRIMARY KEY ('noun_id', 'gender_id'),
        CONSTRAINT 'fk_conjugation_word' FOREIGN KEY ('noun_id') REFERENCES 'word' ('word_id') ON DELETE CASCADE,
        CONSTRAINT 'fk_conguation_gender' FOREIGN KEY ('gender_id') REFERENCES 'gender' ('gender_id')
      );
    )""");

    await db.execute("""
      INSERT INTO "word" ("word_id", "part_id", "isl", "eng") VALUES (1622215123843, 0, 'skólí', 'a school');
    )""");

    await db.execute("""
      INSERT INTO "word" ("word_id", "part_id", "isl", "eng") VALUES (1622215194444, 0, 'vinna', 'a job');
    )""");

    await db.execute("""
      INSERT INTO "word" ("word_id", "part_id", "isl", "eng") VALUES (1622218496445, 0, 'pósthús', 'a post office');
    )""");

    await db.execute("""
      INSERT INTO "declension" ("noun_id", "gender_id", "nefnifall", "nominative", "tholfall", "accusative", "thaugufall", "dative", "eignarfall", "genitive")
       VALUES (1622215123843, 1, 'skóli', 'school', 'skóla', 'school', 'skóla', 'school', 'skóla', 'school');
    )""");

    await db.execute("""
      INSERT INTO "declension" ("noun_id", "gender_id", "nefnifall", "nominative", "tholfall", "accusative", "thaugufall", "dative", "eignarfall", "genitive")
       VALUES (1622215194444, 2, 'vinna', 'job', 'vinnu', 'job', 'vinnu', 'job', 'vinnu', 'job');
    )""");

    await db.execute("""
      INSERT INTO "declension" ("noun_id", "gender_id", "nefnifall", "nominative", "tholfall", "accusative", "thaugufall", "dative", "eignarfall", "genitive")
       VALUES (1622218496445, 3, 'pósthús', 'post office', 'pósthús', 'post office', 'pósthús', 'post office', 'pósthúss', 'post office');
    )""");

  }

  static Future database() async {
    final databasePath = await getDatabasesPath();

    print(databasePath);
    // yields something like ...
    // macOs: /Users/rebecca/Library/Containers/is.redshift.dictionary/Data/Documents
    // windows: C:\Users\rebecca\src\github.com\ccp-codex\dictionary\.dart_tool\sqflite_common_ffi\databases

    return openDatabase(join(databasePath, 'dictionary.db'),
        onConfigure: (database) {
      return database.execute('PRAGMA foreign_keys = ON');
    }, onCreate: _create, version: 1);
  }

  static Future insertDeclension(Map<String, Object?> data) async {
    final database = await DatabaseHelper.database();

    database.insert("declension", data,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>?> getDeclensionsFromDB() async {
    final database = await DatabaseHelper.database();

    return database.query("declension", orderBy: "noun_id DESC");
  }

  static Future deleteDeclension(int? id) async {
    final database = await DatabaseHelper.database();

    return database
        .delete('declension', where: 'noun_id = ?', whereArgs: [id]);
  }

  static Future insertWord(Map<String, Object?> data) async {
    final database = await DatabaseHelper.database();

    database.insert("word", data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future insertConjugation(Map<String, Object?> data) async {
    final database = await DatabaseHelper.database();

    database.insert("conjugation", data,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>?> getWordsFromDB() async {
    final database = await DatabaseHelper.database();

    return database.query("word", orderBy: "word_id DESC");
  }

  static Future<List<Map<String, dynamic>>?> getConjugationsFromDB() async {
    final database = await DatabaseHelper.database();

    return database.query("conjugation", orderBy: "verb_id DESC");
  }

  static Future deleteWord(int? id) async {
    final database = await DatabaseHelper.database();

    return database.delete('word', where: 'word_id = ?', whereArgs: [id]);
  }

  static Future deleteConjugation(int? id) async {
    final database = await DatabaseHelper.database();

    return database
        .delete('conjugation', where: 'verb_id = ?', whereArgs: [id]);
  }
}
