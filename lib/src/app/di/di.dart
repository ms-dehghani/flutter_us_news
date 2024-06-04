import 'package:flutter_us_news/src/data/di/data_di.dart';
import 'package:flutter_us_news/src/domain/di/domain_di.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

class DI {
  static final DI _singleton = DI._internal();

  static DI instance() {
    return _singleton;
  }

  DI._internal();

  final getIt = GetIt.instance;

  Database? _database;

  Future<bool> provideDependencies() async {
    if (_database == null) {
      _database ??= await openDatabase('my_db.db');
      getIt.registerSingleton<Database>(_database!);

      DataDI();
      DomainDI();
    }
    return Future.value(true);
  }
}
