
import 'package:mibook/layers/domain/models/book_list_domain.dart';

import 'fake_book_domain.dart';

final fakeBookListDomain = BookListDomain(
  totalItems: 1,
  books: [fakeBookDomain],
);
