import 'package:freezed_annotation/freezed_annotation.dart';
part 'book_list_domain.freezed.dart';

@freezed
class BookListDomain with _$BookListDomain {
  const factory BookListDomain({
    required int totalItems,
    required List<BookDomain> books,
  }) = _BookListDomain;
}

@freezed
class BookDomain with _$BookDomain {
  const factory BookDomain({
    required String id,
    required String kind,
    required String title,
    @Default([]) List<String> authors,
    String? description,
    String? thumbnail,
    @Default(0) int pageCount,
  }) = _BookDomain;
}
