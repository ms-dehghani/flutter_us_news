abstract class CacheValidateDataProvider {
  Future<bool> isCacheValid();

  Future<void> updateCacheTime(int time);
}
