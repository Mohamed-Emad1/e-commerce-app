import 'package:dartz/dartz.dart';
import 'package:kshk/core/errors/failure.dart';
import 'package:kshk/features/home/domain/entities/item_card_entity.dart';

abstract class ProductRepo {
  Future<Either<Failure, List<ItemCardEntity>>> getProducts();
}
