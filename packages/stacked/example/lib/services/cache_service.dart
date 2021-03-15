import 'package:new_architecture/datamodels/human.dart';

/// A service dedicating the caching data in memory or on disk using a Database
class CacheService {
  List<Human> _inMemoryHumans = [];

  /// A to tiered caching system that saves the values passed in into memory and to the database (not implemented)
  void cacheHumans(List<Human> humans) {
    _inMemoryHumans = humans;
  }

  /// returns the humans in memory , if there's none in memory it should get from the database
  List<Human> getCachedHumans() => _inMemoryHumans;
}
