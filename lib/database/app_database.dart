import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'dao/contatinhos_dao.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'contatinhosteste.db');
  return openDatabase(
      path,
      onCreate: (db, version){
    db.execute(ContatinhosDao.tableSql);
  },
  version: 1,
  );
}
