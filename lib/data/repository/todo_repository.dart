import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import 'package:yet_another_todo_app/models/todo_model.dart';

part 'todo_repository.g.dart';

class TodoItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  BoolColumn get isDone => boolean()();
  DateTimeColumn get plannedDate => dateTime().nullable()();
}

@DriftDatabase(tables: [TodoItems])
class TodoDatabase extends _$TodoDatabase {
  TodoDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<Todo>> getAllTodos() async {
    return select(todoItems).get().then(
          (value) => value
              .map((e) => Todo(
                  id: e.id,
                  title: e.title,
                  isDone: e.isDone,
                  plannedDate: e.plannedDate))
              .toList(),
        );
  }

  Future addTodo(Todo todo) async {
    into(todoItems).insert(
      TodoItemsCompanion.insert(
        title: todo.title,
        isDone: todo.isDone,
        plannedDate: Value.ofNullable(todo.plannedDate),
      ),
    );
  }

  Future updateTodo(Todo todo) async {
    (update(todoItems)..where((tbl) => tbl.id.equals(todo.id))).write(
      TodoItemsCompanion(
        title: Value(todo.title),
        isDone: Value(todo.isDone),
        plannedDate: Value(todo.plannedDate),
      ),
    );
  }
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    // Also work around limitations on old Android versions
    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    // Make sqlite3 pick a more suitable location for temporary files - the
    // one from the system may be inaccessible due to sandboxing.
    final cachebase = (await getTemporaryDirectory()).path;
    // We can't access /tmp on Android, which sqlite3 would try by default.
    // Explicitly tell it about the correct temporary directory.
    sqlite3.tempDirectory = cachebase;

    return NativeDatabase.createInBackground(file);
  });
}
