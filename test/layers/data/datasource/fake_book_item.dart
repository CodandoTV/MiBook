import 'package:mibook/layers/data/models/book_list_data.dart';

final fakeBookItem = BookData(
  kind: 'fiction',
  id: 'id',
  etag: 'tag',
  selfLink: 'link',
  volumeInfo: VolumeInfo(
    title: 'Harry Potter',
    authors: ['JK Rowling'],
    pageCount: 300,
  ),
);
