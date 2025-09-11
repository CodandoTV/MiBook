// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_list_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookListData _$BookListDataFromJson(Map<String, dynamic> json) => BookListData(
  kind: json['kind'] as String,
  totalItems: (json['totalItems'] as num).toInt(),
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => BookItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$BookListDataToJson(BookListData instance) =>
    <String, dynamic>{
      'kind': instance.kind,
      'totalItems': instance.totalItems,
      'items': instance.items,
    };

BookItem _$BookItemFromJson(Map<String, dynamic> json) => BookItem(
  kind: json['kind'] as String,
  id: json['id'] as String,
  etag: json['etag'] as String,
  selfLink: json['selfLink'] as String,
  volumeInfo: VolumeInfo.fromJson(json['volumeInfo'] as Map<String, dynamic>),
  saleInfo: SaleInfo.fromJson(json['saleInfo'] as Map<String, dynamic>),
  accessInfo: AccessInfo.fromJson(json['accessInfo'] as Map<String, dynamic>),
  searchInfo: json['searchInfo'] == null
      ? null
      : SearchInfo.fromJson(json['searchInfo'] as Map<String, dynamic>),
);

Map<String, dynamic> _$BookItemToJson(BookItem instance) => <String, dynamic>{
  'kind': instance.kind,
  'id': instance.id,
  'etag': instance.etag,
  'selfLink': instance.selfLink,
  'volumeInfo': instance.volumeInfo,
  'saleInfo': instance.saleInfo,
  'accessInfo': instance.accessInfo,
  'searchInfo': instance.searchInfo,
};

VolumeInfo _$VolumeInfoFromJson(Map<String, dynamic> json) => VolumeInfo(
  title: json['title'] as String,
  authors: (json['authors'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  subtitle: json['subtitle'] as String?,
  publisher: json['publisher'] as String?,
  publishedDate: json['publishedDate'] as String?,
  description: json['description'] as String?,
  industryIdentifiers: (json['industryIdentifiers'] as List<dynamic>?)
      ?.map((e) => IndustryIdentifier.fromJson(e as Map<String, dynamic>))
      .toList(),
  readingModes: json['readingModes'] == null
      ? null
      : ReadingModes.fromJson(json['readingModes'] as Map<String, dynamic>),
  pageCount: (json['pageCount'] as num).toInt(),
  printType: json['printType'] as String?,
  categories: (json['categories'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  averageRating: (json['averageRating'] as num?)?.toDouble(),
  ratingsCount: (json['ratingsCount'] as num?)?.toInt(),
  maturityRating: json['maturityRating'] as String?,
  allowAnonLogging: json['allowAnonLogging'] as bool?,
  contentVersion: json['contentVersion'] as String?,
  panelizationSummary: json['panelizationSummary'] == null
      ? null
      : PanelizationSummary.fromJson(
          json['panelizationSummary'] as Map<String, dynamic>,
        ),
  imageLinks: json['imageLinks'] == null
      ? null
      : ImageLinks.fromJson(json['imageLinks'] as Map<String, dynamic>),
  language: json['language'] as String?,
  previewLink: json['previewLink'] as String?,
  infoLink: json['infoLink'] as String?,
  canonicalVolumeLink: json['canonicalVolumeLink'] as String?,
);

Map<String, dynamic> _$VolumeInfoToJson(VolumeInfo instance) =>
    <String, dynamic>{
      'title': instance.title,
      'authors': instance.authors,
      'subtitle': instance.subtitle,
      'publisher': instance.publisher,
      'publishedDate': instance.publishedDate,
      'description': instance.description,
      'industryIdentifiers': instance.industryIdentifiers,
      'readingModes': instance.readingModes,
      'pageCount': instance.pageCount,
      'printType': instance.printType,
      'categories': instance.categories,
      'averageRating': instance.averageRating,
      'ratingsCount': instance.ratingsCount,
      'maturityRating': instance.maturityRating,
      'allowAnonLogging': instance.allowAnonLogging,
      'contentVersion': instance.contentVersion,
      'panelizationSummary': instance.panelizationSummary,
      'imageLinks': instance.imageLinks,
      'language': instance.language,
      'previewLink': instance.previewLink,
      'infoLink': instance.infoLink,
      'canonicalVolumeLink': instance.canonicalVolumeLink,
    };

IndustryIdentifier _$IndustryIdentifierFromJson(Map<String, dynamic> json) =>
    IndustryIdentifier(
      type: json['type'] as String,
      identifier: json['identifier'] as String,
    );

Map<String, dynamic> _$IndustryIdentifierToJson(IndustryIdentifier instance) =>
    <String, dynamic>{'type': instance.type, 'identifier': instance.identifier};

ReadingModes _$ReadingModesFromJson(Map<String, dynamic> json) =>
    ReadingModes(text: json['text'] as bool, image: json['image'] as bool);

Map<String, dynamic> _$ReadingModesToJson(ReadingModes instance) =>
    <String, dynamic>{'text': instance.text, 'image': instance.image};

PanelizationSummary _$PanelizationSummaryFromJson(Map<String, dynamic> json) =>
    PanelizationSummary(
      containsEpubBubbles: json['containsEpubBubbles'] as bool,
      containsImageBubbles: json['containsImageBubbles'] as bool,
    );

Map<String, dynamic> _$PanelizationSummaryToJson(
  PanelizationSummary instance,
) => <String, dynamic>{
  'containsEpubBubbles': instance.containsEpubBubbles,
  'containsImageBubbles': instance.containsImageBubbles,
};

ImageLinks _$ImageLinksFromJson(Map<String, dynamic> json) => ImageLinks(
  smallThumbnail: json['smallThumbnail'] as String?,
  thumbnail: json['thumbnail'] as String?,
);

Map<String, dynamic> _$ImageLinksToJson(ImageLinks instance) =>
    <String, dynamic>{
      'smallThumbnail': instance.smallThumbnail,
      'thumbnail': instance.thumbnail,
    };

SaleInfo _$SaleInfoFromJson(Map<String, dynamic> json) => SaleInfo(
  country: json['country'] as String,
  saleability: json['saleability'] as String,
  isEbook: json['isEbook'] as bool,
  listPrice: json['listPrice'] == null
      ? null
      : Price.fromJson(json['listPrice'] as Map<String, dynamic>),
  retailPrice: json['retailPrice'] == null
      ? null
      : Price.fromJson(json['retailPrice'] as Map<String, dynamic>),
  buyLink: json['buyLink'] as String?,
  offers: (json['offers'] as List<dynamic>?)
      ?.map((e) => Offer.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$SaleInfoToJson(SaleInfo instance) => <String, dynamic>{
  'country': instance.country,
  'saleability': instance.saleability,
  'isEbook': instance.isEbook,
  'listPrice': instance.listPrice,
  'retailPrice': instance.retailPrice,
  'buyLink': instance.buyLink,
  'offers': instance.offers,
};

Price _$PriceFromJson(Map<String, dynamic> json) => Price(
  amount: (json['amount'] as num?)?.toDouble(),
  currencyCode: json['currencyCode'] as String?,
  amountInMicros: (json['amountInMicros'] as num?)?.toInt(),
);

Map<String, dynamic> _$PriceToJson(Price instance) => <String, dynamic>{
  'amount': instance.amount,
  'currencyCode': instance.currencyCode,
  'amountInMicros': instance.amountInMicros,
};

Offer _$OfferFromJson(Map<String, dynamic> json) => Offer(
  finskyOfferType: (json['finskyOfferType'] as num).toInt(),
  listPrice: json['listPrice'] == null
      ? null
      : Price.fromJson(json['listPrice'] as Map<String, dynamic>),
  retailPrice: json['retailPrice'] == null
      ? null
      : Price.fromJson(json['retailPrice'] as Map<String, dynamic>),
  giftable: json['giftable'] as bool?,
);

Map<String, dynamic> _$OfferToJson(Offer instance) => <String, dynamic>{
  'finskyOfferType': instance.finskyOfferType,
  'listPrice': instance.listPrice,
  'retailPrice': instance.retailPrice,
  'giftable': instance.giftable,
};

AccessInfo _$AccessInfoFromJson(Map<String, dynamic> json) => AccessInfo(
  country: json['country'] as String,
  viewability: json['viewability'] as String,
  embeddable: json['embeddable'] as bool,
  publicDomain: json['publicDomain'] as bool,
  textToSpeechPermission: json['textToSpeechPermission'] as String,
  epub: json['epub'] == null
      ? null
      : EpubInfo.fromJson(json['epub'] as Map<String, dynamic>),
  pdf: json['pdf'] == null
      ? null
      : PdfInfo.fromJson(json['pdf'] as Map<String, dynamic>),
  webReaderLink: json['webReaderLink'] as String?,
  accessViewStatus: json['accessViewStatus'] as String?,
  quoteSharingAllowed: json['quoteSharingAllowed'] as bool?,
);

Map<String, dynamic> _$AccessInfoToJson(AccessInfo instance) =>
    <String, dynamic>{
      'country': instance.country,
      'viewability': instance.viewability,
      'embeddable': instance.embeddable,
      'publicDomain': instance.publicDomain,
      'textToSpeechPermission': instance.textToSpeechPermission,
      'epub': instance.epub,
      'pdf': instance.pdf,
      'webReaderLink': instance.webReaderLink,
      'accessViewStatus': instance.accessViewStatus,
      'quoteSharingAllowed': instance.quoteSharingAllowed,
    };

EpubInfo _$EpubInfoFromJson(Map<String, dynamic> json) => EpubInfo(
  isAvailable: json['isAvailable'] as bool,
  acsTokenLink: json['acsTokenLink'] as String?,
);

Map<String, dynamic> _$EpubInfoToJson(EpubInfo instance) => <String, dynamic>{
  'isAvailable': instance.isAvailable,
  'acsTokenLink': instance.acsTokenLink,
};

PdfInfo _$PdfInfoFromJson(Map<String, dynamic> json) => PdfInfo(
  isAvailable: json['isAvailable'] as bool,
  acsTokenLink: json['acsTokenLink'] as String?,
);

Map<String, dynamic> _$PdfInfoToJson(PdfInfo instance) => <String, dynamic>{
  'isAvailable': instance.isAvailable,
  'acsTokenLink': instance.acsTokenLink,
};

SearchInfo _$SearchInfoFromJson(Map<String, dynamic> json) =>
    SearchInfo(textSnippet: json['textSnippet'] as String?);

Map<String, dynamic> _$SearchInfoToJson(SearchInfo instance) =>
    <String, dynamic>{'textSnippet': instance.textSnippet};
