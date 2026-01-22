import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mibook/layers/domain/models/reading_domain.dart';
part 'reading_list_ui.freezed.dart';

@freezed
class ReadingUI with _$ReadingUI {
  const ReadingUI._();

  const factory ReadingUI({
    @Default('') bookId,
    @Default('') bookName,
    @Default(null) bookThumb,
    @Default(0.0) progress,
    thumbnail,
  }) = _ReadingUI;

  factory ReadingUI.fromDomain(ReadingDomain domain) {
    return ReadingUI(
      bookId: domain.bookId,
      bookName: domain.bookName,
      bookThumb: domain.bookThumb,
      progress: domain.progress,
      thumbnail: domain.bookThumb,
    );
  }
}
