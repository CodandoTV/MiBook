import 'package:injectable/injectable.dart';
import 'package:mibook/layers/domain/repository/favorite_repository.dart';

abstract class IGetFavorite {
  Future<bool> call(String id);
}

@Singleton(as: IGetFavorite)
class GetFavorite implements IGetFavorite {
  final IFavoriteRepository _favoriteRepository;

  GetFavorite(this._favoriteRepository);

  @override
  Future<bool> call(String id) async =>
      await _favoriteRepository.getFavoriteStatus(id);
}
