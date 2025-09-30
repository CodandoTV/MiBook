// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart'
    as _i847;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:mibook/core/di/app_module.dart' as _i516;
import 'package:mibook/layers/data/api/api_client.dart' as _i721;
import 'package:mibook/layers/data/datasource/reading_data_source.dart' as _i44;
import 'package:mibook/layers/data/datasource/search_data_source.dart' as _i400;
import 'package:mibook/layers/data/repository/reading_repository.dart' as _i600;
import 'package:mibook/layers/data/repository/search_repository.dart' as _i967;
import 'package:mibook/layers/domain/repository/reading_repository.dart'
    as _i649;
import 'package:mibook/layers/domain/repository/search_repository.dart'
    as _i303;
import 'package:mibook/layers/domain/usecases/get_book_details.dart' as _i814;
import 'package:mibook/layers/domain/usecases/search_books.dart' as _i663;
import 'package:mibook/layers/domain/usecases/start_reading.dart' as _i369;
import 'package:mibook/layers/presentation/screens/bookdetails/book_details_ui.dart'
    as _i66;
import 'package:mibook/layers/presentation/screens/bookdetails/book_details_view_model.dart'
    as _i46;
import 'package:mibook/layers/presentation/screens/booksearch/book_search_view_model.dart'
    as _i688;
import 'package:mibook/layers/presentation/screens/startreading/start_reading_view_model.dart'
    as _i35;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    gh.lazySingleton<_i847.EncryptedSharedPreferences>(
      () => appModule.encryptedSharedPreferences,
    );
    gh.factory<_i721.IApiClient>(() => _i721.ApiClient());
    gh.factory<_i44.IReadingDataSource>(
      () => _i44.ReadingDataSource(gh<_i847.EncryptedSharedPreferences>()),
    );
    gh.factory<_i400.ISearchDataSource>(
      () => _i400.SearchDataSource(gh<_i721.IApiClient>()),
    );
    gh.factory<_i649.IReadingRepository>(
      () => _i600.ReadingRepository(gh<_i44.IReadingDataSource>()),
    );
    gh.factory<_i303.ISearchRepository>(
      () => _i967.SearchRepository(gh<_i400.ISearchDataSource>()),
    );
    gh.factory<_i369.IStartReading>(
      () => _i369.StartReading(gh<_i649.IReadingRepository>()),
    );
    gh.factory<_i663.ISearchBooks>(
      () => _i663.SearchBooks(gh<_i303.ISearchRepository>()),
    );
    gh.factory<_i814.IGetBookDetails>(
      () => _i814.GetBookDetails(gh<_i303.ISearchRepository>()),
    );
    gh.factoryParam<_i46.BookDetailsViewModel, String?, dynamic>(
      (bookId, _) => _i46.BookDetailsViewModel(
        gh<_i814.IGetBookDetails>(),
        gh<_i369.IStartReading>(),
        bookId,
      ),
    );
    gh.factoryParam<_i35.StartReadingViewModel, _i66.BookDetailsUI, dynamic>(
      (book, _) => _i35.StartReadingViewModel(gh<_i369.IStartReading>(), book),
    );
    gh.factory<_i688.BookSearchViewModel>(
      () => _i688.BookSearchViewModel(gh<_i663.ISearchBooks>()),
    );
    return this;
  }
}

class _$AppModule extends _i516.AppModule {}
