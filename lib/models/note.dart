import 'package:isar/isar.dart';

part 'note.g.dart';

@Collection()
class Note {
  Id id = Isar.autoIncrement;
  late String title;
  late String body;
  DateTime? creationDate;
}
