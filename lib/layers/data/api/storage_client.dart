import 'dart:convert';
import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:mibook/layers/data/api/custom_errors.dart';
import 'package:mibook/layers/data/models/book_list_data.dart';
import 'package:mibook/layers/data/models/reading_data.dart';
import 'package:path_provider/path_provider.dart';

const _readingList = 'reading_list';
const _favoriteBooks = 'favorite_books';
const _isFavoriteBook = 'is_favorite_book';

abstract class IStorageClient {
  Future<void> saveReading(ReadingData readingData);
  Future<List<ReadingData>> getReadingList();
  Future<void> setFavoriteStatus(BookItem book, bool isFavorite);
  Future<bool> getFavoriteStatus(String bookId);
  Future<List<BookItem>> getFavoriteBooks();
}

@Singleton(as: IStorageClient)
class StorageClient implements IStorageClient {
  Future<File> _getLocalFile(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$fileName.json');
  }

  Future<List<T>> _getListFromFile<T>(
    String fileName,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    final file = await _getLocalFile(fileName);

    if (!await file.exists()) {
      return [];
    }

    final jsonString = await file.readAsString();

    if (jsonString.isEmpty) {
      return [];
    }

    final List<dynamic> decoded = jsonDecode(jsonString);
    return decoded.map((e) => fromJson(e)).toList();
  }

  Future<Map<String, bool>> _parseAsBoolMap(String jsonString) async {
    final decoded = jsonDecode(jsonString);

    if (decoded is! Map) {
      throw Exception("JSON root is not a map");
    }

    return decoded.map<String, bool>((key, value) {
      if (value is! bool) {
        throw Exception("Value for '$key' is not a bool");
      }
      return MapEntry(key.toString(), value);
    });
  }

  @override
  Future<void> saveReading(ReadingData readingData) async {
    final file = await _getLocalFile(_readingList);
    List<ReadingData> currentList = await getReadingList();

    if (currentList.any((item) => item.bookId == readingData.bookId)) {
      throw DuplicatedReadingError();
    }
    currentList.add(readingData);
    final jsonString = jsonEncode(currentList.map((e) => e.toJson()).toList());
    await file.writeAsString(jsonString);
  }

  @override
  Future<List<ReadingData>> getReadingList() async {
    final List<ReadingData> readings = await _getListFromFile<ReadingData>(
      _readingList,
      (json) => ReadingData.fromJson(json),
    );
    return readings;
  }

  @override
  Future<List<BookItem>> getFavoriteBooks() async {
    final List<BookItem> favoriteBooks = await _getListFromFile<BookItem>(
      _favoriteBooks,
      (json) => BookItem.fromJson(json),
    );
    return favoriteBooks;
  }

  @override
  Future<void> setFavoriteStatus(BookItem book, bool isFavorite) async {
    // 1. update favorite book list
    final file = await _getLocalFile(_favoriteBooks);
    List<BookItem> currentList = await getFavoriteBooks();

    currentList.add(book);
    final jsonString = jsonEncode(currentList.map((e) => e.toJson()).toList());
    await file.writeAsString(jsonString);

    // 2. update favorite status map
    final isFavoriteFile = await _getLocalFile(_isFavoriteBook);

    Map<String, bool> isFavoriteBookMap = {};

    // Safely read existing map
    if (await isFavoriteFile.exists()) {
      final jsonStringIsFavorite = await isFavoriteFile.readAsString();

      if (jsonStringIsFavorite.isNotEmpty) {
        isFavoriteBookMap = await _parseAsBoolMap(jsonStringIsFavorite);
      }
    }

    // Update or insert
    isFavoriteBookMap[book.id] = isFavorite;

    // Write back
    final isFavoriteJsonString = jsonEncode(isFavoriteBookMap);
    await isFavoriteFile.writeAsString(isFavoriteJsonString);
  }

  @override
  Future<bool> getFavoriteStatus(String bookId) async {
    final isFavoriteFile = await _getLocalFile(_isFavoriteBook);

    if (!await isFavoriteFile.exists()) {
      return false;
    }

    final jsonString = await isFavoriteFile.readAsString();

    if (jsonString.isEmpty) {
      return false;
    }

    Map<String, bool> isFavoriteBookMap = await _parseAsBoolMap(
      jsonString,
    );

    return isFavoriteBookMap[bookId] ?? false;
  }
}
