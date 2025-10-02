import 'package:json_annotation/json_annotation.dart';
import 'package:mibook/layers/domain/models/book_list_domain.dart';

part 'book_list_data.g.dart';

@JsonSerializable()
class BookListData {
  final String kind;
  final int? totalItems;
  @JsonKey(defaultValue: [])
  final List<BookItem> items;

  BookListData({
    required this.kind,
    required this.totalItems,
    required this.items,
  });

  factory BookListData.fromJson(Map<String, dynamic> json) =>
      _$BookListDataFromJson(json);

  Map<String, dynamic> toJson() => _$BookListDataToJson(this);

  BookListDomain toDomain() {
    return BookListDomain(
      totalItems: totalItems ?? 0,
      books: items
          .where((item) => item.volumeInfo.pageCount != null)
          .map((item) => item.toDomain())
          .toList(),
    );
  }
}

@JsonSerializable()
class BookItem {
  final String kind;
  final String id;
  final String etag;
  final String selfLink;
  final VolumeInfo volumeInfo;
  final SaleInfo saleInfo;
  final AccessInfo accessInfo;
  final SearchInfo? searchInfo;

  BookItem({
    required this.kind,
    required this.id,
    required this.etag,
    required this.selfLink,
    required this.volumeInfo,
    required this.saleInfo,
    required this.accessInfo,
    this.searchInfo,
  });

  factory BookItem.fromJson(Map<String, dynamic> json) =>
      _$BookItemFromJson(json);

  Map<String, dynamic> toJson() => _$BookItemToJson(this);

  BookDomain toDomain() {
    return BookDomain(
      id: id,
      kind: kind,
      title: volumeInfo.title,
      authors: volumeInfo.authors,
      description: volumeInfo.description,
      thumbnail: volumeInfo.imageLinks?.thumbnail,
      pageCount: volumeInfo.pageCount ?? 100,
    );
  }
}

@JsonSerializable()
class VolumeInfo {
  final String title;
  final List<String>? authors;
  final String? subtitle;
  final String? publisher;
  final String? publishedDate;
  final String? description;
  final List<IndustryIdentifier>? industryIdentifiers;
  final ReadingModes? readingModes;
  final int? pageCount;
  final String? printType;
  final List<String>? categories;
  final double? averageRating;
  final int? ratingsCount;
  final String? maturityRating;
  final bool? allowAnonLogging;
  final String? contentVersion;
  final PanelizationSummary? panelizationSummary;
  final ImageLinks? imageLinks;
  final String? language;
  final String? previewLink;
  final String? infoLink;
  final String? canonicalVolumeLink;

  VolumeInfo({
    required this.title,
    this.authors,
    this.subtitle,
    this.publisher,
    this.publishedDate,
    this.description,
    this.industryIdentifiers,
    this.readingModes,
    required this.pageCount,
    this.printType,
    this.categories,
    this.averageRating,
    this.ratingsCount,
    this.maturityRating,
    this.allowAnonLogging,
    this.contentVersion,
    this.panelizationSummary,
    this.imageLinks,
    this.language,
    this.previewLink,
    this.infoLink,
    this.canonicalVolumeLink,
  });

  factory VolumeInfo.fromJson(Map<String, dynamic> json) =>
      _$VolumeInfoFromJson(json);

  Map<String, dynamic> toJson() => _$VolumeInfoToJson(this);
}

@JsonSerializable()
class IndustryIdentifier {
  final String type;
  final String identifier;

  IndustryIdentifier({
    required this.type,
    required this.identifier,
  });

  factory IndustryIdentifier.fromJson(Map<String, dynamic> json) =>
      _$IndustryIdentifierFromJson(json);

  Map<String, dynamic> toJson() => _$IndustryIdentifierToJson(this);
}

@JsonSerializable()
class ReadingModes {
  final bool text;
  final bool image;

  ReadingModes({
    required this.text,
    required this.image,
  });

  factory ReadingModes.fromJson(Map<String, dynamic> json) =>
      _$ReadingModesFromJson(json);

  Map<String, dynamic> toJson() => _$ReadingModesToJson(this);
}

@JsonSerializable()
class PanelizationSummary {
  final bool containsEpubBubbles;
  final bool containsImageBubbles;

  PanelizationSummary({
    required this.containsEpubBubbles,
    required this.containsImageBubbles,
  });

  factory PanelizationSummary.fromJson(Map<String, dynamic> json) =>
      _$PanelizationSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$PanelizationSummaryToJson(this);
}

@JsonSerializable()
class ImageLinks {
  final String? smallThumbnail;
  final String? thumbnail;

  ImageLinks({
    this.smallThumbnail,
    this.thumbnail,
  });

  factory ImageLinks.fromJson(Map<String, dynamic> json) =>
      _$ImageLinksFromJson(json);

  Map<String, dynamic> toJson() => _$ImageLinksToJson(this);
}

@JsonSerializable()
class SaleInfo {
  final String country;
  final String saleability;
  final bool isEbook;
  final Price? listPrice;
  final Price? retailPrice;
  final String? buyLink;
  final List<Offer>? offers;

  SaleInfo({
    required this.country,
    required this.saleability,
    required this.isEbook,
    this.listPrice,
    this.retailPrice,
    this.buyLink,
    this.offers,
  });

  factory SaleInfo.fromJson(Map<String, dynamic> json) =>
      _$SaleInfoFromJson(json);

  Map<String, dynamic> toJson() => _$SaleInfoToJson(this);
}

@JsonSerializable()
class Price {
  final double? amount;
  final String? currencyCode;
  final int? amountInMicros;

  Price({
    this.amount,
    this.currencyCode,
    this.amountInMicros,
  });

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);

  Map<String, dynamic> toJson() => _$PriceToJson(this);
}

@JsonSerializable()
class Offer {
  final int? finskyOfferType;
  final Price? listPrice;
  final Price? retailPrice;
  final bool? giftable;

  Offer({
    required this.finskyOfferType,
    this.listPrice,
    this.retailPrice,
    this.giftable,
  });

  factory Offer.fromJson(Map<String, dynamic> json) => _$OfferFromJson(json);

  Map<String, dynamic> toJson() => _$OfferToJson(this);
}

@JsonSerializable()
class AccessInfo {
  final String country;
  final String viewability;
  final bool embeddable;
  final bool publicDomain;
  final String textToSpeechPermission;
  final EpubInfo? epub;
  final PdfInfo? pdf;
  final String? webReaderLink;
  final String? accessViewStatus;
  final bool? quoteSharingAllowed;

  AccessInfo({
    required this.country,
    required this.viewability,
    required this.embeddable,
    required this.publicDomain,
    required this.textToSpeechPermission,
    this.epub,
    this.pdf,
    this.webReaderLink,
    this.accessViewStatus,
    this.quoteSharingAllowed,
  });

  factory AccessInfo.fromJson(Map<String, dynamic> json) =>
      _$AccessInfoFromJson(json);

  Map<String, dynamic> toJson() => _$AccessInfoToJson(this);
}

@JsonSerializable()
class EpubInfo {
  final bool isAvailable;
  final String? acsTokenLink;

  EpubInfo({
    required this.isAvailable,
    this.acsTokenLink,
  });

  factory EpubInfo.fromJson(Map<String, dynamic> json) =>
      _$EpubInfoFromJson(json);

  Map<String, dynamic> toJson() => _$EpubInfoToJson(this);
}

@JsonSerializable()
class PdfInfo {
  final bool isAvailable;
  final String? acsTokenLink;

  PdfInfo({
    required this.isAvailable,
    this.acsTokenLink,
  });

  factory PdfInfo.fromJson(Map<String, dynamic> json) =>
      _$PdfInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PdfInfoToJson(this);
}

@JsonSerializable()
class SearchInfo {
  final String? textSnippet;

  SearchInfo({
    this.textSnippet,
  });

  factory SearchInfo.fromJson(Map<String, dynamic> json) =>
      _$SearchInfoFromJson(json);

  Map<String, dynamic> toJson() => _$SearchInfoToJson(this);
}
