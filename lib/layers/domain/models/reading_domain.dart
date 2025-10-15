class ReadingDomain {
  final String bookId;
  final String bookName;
  final String? bookThumb;
  final double progress;

  ReadingDomain({
    required this.bookId,
    required this.bookName,
    this.bookThumb,
    required this.progress,
  });
}
