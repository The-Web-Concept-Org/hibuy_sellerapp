import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveHelper {
  /// Initialize Hive
  /// [adapters] is a Map of typeId to HiveAdapter
  static Future<void> init({Map<int, TypeAdapter>? adapters}) async {
    await Hive.initFlutter();

    // Register adapters if not already registered
    if (adapters != null) {
      adapters.forEach((typeId, adapter) {
        if (!Hive.isAdapterRegistered(typeId)) {
          Hive.registerAdapter(adapter);
        }
      });
    }
  }

  /// Open a box (generic)
  static Future<Box<T>> openBox<T>(String boxName) async {
    if (!Hive.isBoxOpen(boxName)) {
      return await Hive.openBox<T>(boxName);
    } else {
      return Hive.box<T>(boxName);
    }
  }

  /// Save or update data in a box
  static Future<void> saveData<T>(String boxName, String key, T value) async {
    var box = await openBox<T>(boxName);
    await box.put(key, value);
  }

  /// Get data from a box
  static Future<T?> getData<T>(String boxName, String key) async {
    var box = await openBox<T>(boxName);
    return box.get(key);
  }

  /// Delete data from a box
  static Future<void> deleteData<T>(String boxName, String key) async {
    var box = await openBox<T>(boxName);
    await box.delete(key);
  }

  /// Check if a key exists
  static Future<bool> hasData<T>(String boxName, String key) async {
    var box = await openBox<T>(boxName);
    return box.containsKey(key);
  }
}
