import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'models.dart';
part 'network.g.dart';

@RestApi(baseUrl: "https://programtom.com/Portfolio_Platform/publicDATA/profile")
abstract class RestPortfolioPlatform {
  factory RestPortfolioPlatform(Dio dio, {String baseUrl}) = _RestPortfolioPlatform;

//needed header from the server: Content-Type: application/json; charset=utf-8
  @GET("/indexJsonExt_1.php")
  Future<ProfileQueryResult> getPortfolios();
}
