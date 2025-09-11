abstract class IStartReading {
  Future<void> call({
    required String bookId,
    required double progress,
  });
}

class StartReading implements IStartReading {
  @override
  Future<void> call({
    required String bookId,
    required double progress,
  }) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
