import 'package:get/state_manager.dart';
import 'package:ftg_project_template/tracker/model.dart';
import 'package:ftg_project_template/tracker/table.dart';
import 'package:sqflite/sqlite_api.dart' show Database;

class TrackerRepository extends GetxService {
  final Database db;

  TrackerRepository(this.db);

  Future<Tracker> insert(Tracker tracker) async {
    tracker.id = await db.insert(TrackerTable.tableName, tracker.toSqlMap());
    return tracker;
  }

  Future<int> update(Tracker tracker) async {
    tracker.updated = DateTime.now();
    await db.update(
      TrackerTable.tableName,
      tracker.toSqlMap(),
      where: '${TrackerTable.id} = ?',
      whereArgs: [tracker.id],
    );
  }

  Future<int> delete(int id) async {
    return await db.delete(TrackerTable.tableName, where: '${TrackerTable.id} = ?', whereArgs: [id]);
  }

  Future<Tracker> getById(int id) async {
    List<Map> maps = await db.query(
      TrackerTable.tableName,
      where: '${TrackerTable.id} = ?',
      whereArgs: [id],
    );
    if (maps.length > 0) {
      return Tracker.fromSqlMap(maps.first);
    }
    return null;
  }

  Future<List<Tracker>> getAll() async {
    List<Map> rows = await db.query(TrackerTable.tableName);
    return [for (var row in rows) Tracker.fromSqlMap(row)];
  }
}
