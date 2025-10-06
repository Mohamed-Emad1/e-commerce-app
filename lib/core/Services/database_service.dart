abstract class DatabaseService {
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    required String? documentId,
  });

  Future<dynamic> getData({
    required String path,
    String? documentId,
    Map<String, dynamic>? query,
  });

  Future<bool> isUserExist({required String path, required String documentId});
}
