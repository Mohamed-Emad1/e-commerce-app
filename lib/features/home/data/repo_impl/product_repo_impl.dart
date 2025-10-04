import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:kshk/core/Services/database_service.dart';
import 'package:kshk/core/errors/failure.dart';
import 'package:kshk/core/utils/backend_endpoints.dart';
import 'package:kshk/features/home/data/models/product_model.dart';
import 'package:kshk/features/home/domain/entities/item_card_entity.dart';
import 'package:kshk/features/home/domain/repo/product_repo.dart';

class ProductRepoImpl implements ProductRepo{
  final DatabaseService databaseService;

  ProductRepoImpl({required this.databaseService});
  @override
  Future<Either<Failure, List<ItemCardEntity>>> getProducts() async{
   try{
    // log('Fetching products from Firestore...');
      var result = await databaseService.getData(path: BackendEndpoints.products) ;
      //  log('Raw data received: $result');

      if (result == null) {
        log('Error: data is null');
        return Left(ServerFailure('No data returned from server'));
      }

      
      List<ProductModel> products = [];
      for (var element in result) {
        products.add(ProductModel.fromJson(element));
      }

    List<ItemCardEntity> items = [];
      for(var product in products){
         log('Processing item: $product');
        items.add(product.toEntity());
      }
      log('Successfully fetched ${products.length} products');
       return Right(items);

    }catch(e){
       log('Exception in fetchProducts: $e');
     return Left(ServerFailure(e.toString()));
      
   } 
  }
}