import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

final storageProviderFamily = Provider.family<Storage, String>((Ref ref, String storageName) => Storage(storageName));

class Storage {
  late String storageName;
  late Box _box;
  final Completer boxCompleter = Completer();

  Storage(this.storageName) {
    _openBox(storageName);
  }

  Future<void> write(dynamic key, dynamic value) async {
    await boxCompleter.future;
    await _box.put(key, value);
  }

  Future<dynamic> read(dynamic key) async {
    await boxCompleter.future;
    return _box.get(key);
  }

  Future<List?> readAll() async {
    await boxCompleter.future;
    return _box.values.toList();
  }

  Future<void> delete(dynamic key) async {
    await boxCompleter.future;
    await _box.delete(key);
  }

  Future<void> deleteAll() async {
    await boxCompleter.future;
    await _box.clear();
  }

  Future<void> _openBox(String storageName) async {
    _box = await Hive.openBox(storageName);
    boxCompleter.complete();
  }
}
