import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'memo.g.dart';

class Memos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get content => text().withLength(min: 1)();
}

final dbProvider = Provider((ref) => AppDatabase());

@UseMoor(tables: [Memos])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
          path: 'memo.sqlite',
          logStatements: true,
        ));

  @override
  int get schemaVersion => 1;

  Stream<List<Memo>> watchMemos() => select(memos).watch();

  Future<void> insertMemo(MemosCompanion memo) => into(memos).insert(memo);

  Future<void> updateMemo(int id, MemosCompanion memo) =>
      (update(memos)..where((it) => it.id.equals(id))).write(memo);

  Future<void> deleteMemo(int id) =>
      (delete(memos)..where((it) => it.id.equals(id))).go();
}
