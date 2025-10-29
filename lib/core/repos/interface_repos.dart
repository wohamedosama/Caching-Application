abstract class InterfaceRepos<T> {
  Future<T?> getAll();
  Future<void> addData(T data);
  Future<bool> isDataAvailable();
}
