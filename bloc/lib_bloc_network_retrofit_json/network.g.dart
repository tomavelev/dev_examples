// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RestPortfolioPlatform implements RestPortfolioPlatform {
  _RestPortfolioPlatform(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://programtom.com/Portfolio_Platform/publicDATA/profile';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ProfileQueryResult> getPortfolios() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ProfileQueryResult>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/indexJsonExt_1.php',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ProfileQueryResult.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
