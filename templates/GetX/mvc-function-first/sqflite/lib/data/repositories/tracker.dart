import 'package:get/state_manager.dart';
import 'package:ftg_project_template/data/models/tracker.dart';
import 'package:ftg_project_template/data/tables/tracker.dart';
import 'package:sqflite/sqlite_api.dart';

class TrackerRepository extends GetxService {
  final Database db;

  TrackerRepository(this.db);

  Future<Tracker> insert(Tracker tracker) async {
    tracker.id = await db.insert(TrackerTable.tableName, tracker.toSqlMap());
    return tracker;
  }

  Future<int> update(Tracker tracker) async {
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
