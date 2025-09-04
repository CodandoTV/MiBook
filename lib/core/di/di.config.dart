// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:mibook/layers/data/api/api_client.dart' as _i721;
import 'package:mibook/layers/data/datasource/search_data_source.dart' as _i400;
import 'package:mibook/layers/data/datasource/search_repository.dart' as _i280;
import 'package:mibook/layers/domain/repository/search_repository.dart'
    as _i303;
import 'package:mibook/layers/domain/usecases/get_book_details.dart' as _i814;
import 'package:mibook/layers/domain/usecases/search_books.dart' as _i663;
import 'package:mibook/layers/presentation/screens/bookdetails/book_details_view_model.dart'
    as _i46;
import 'package:mibook/layers/presentation/screens/booksearch/book_search_view_model.dart'
    as _i688;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i721.IApiClient>(() => _i721.ApiClient());
    gh.factory<_i400.ISearchDataSource>(
      () => _i400.SearchDataSource(gh<_i721.IApiClient>()),
    );
    gh.factory<_i303.ISearchRepository>(
      () => _i280.SearchRepository(gh<_i400.ISearchDataSource>()),
    );
    gh.factory<_i663.ISearchBooks>(
      () => _i663.SearchBooks(gh<_i303.ISearchRepository>()),
    );
    gh.factory<_i814.IGetBookDetails>(
      () => _i814.GetBookDetails(gh<_i303.ISearchRepository>()),
    );
    gh.factoryParam<_i46.BookDetailsViewModel, String?, dynamic>(
      (bookId, _) =>
          _i46.BookDetailsViewModel(gh<_i814.IGetBookDetails>(), bookId),
    );
    gh.factory<_i688.BookSearchViewModel>(
      () => _i688.BookSearchViewModel(gh<_i663.ISearchBooks>()),
    );
    return this;
  }
}
