import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final iexRepositoryProvider = Provider<IEXRepository>(
  (ref) => IEXRepositoryImpl(http.Client()),
);

abstract class IEXRepository {
  Future<double> getStockPrice(String stockSymbol);
  Future<String> getStockCompanyName(String stockSymbol);
}

class IEXRepositoryImpl implements IEXRepository {
  IEXRepositoryImpl(this._httpClient);

  final http.Client _httpClient;

  String get _baseUrl => const String.fromEnvironment('IEX_API_URL');
  String get _apiToken => const String.fromEnvironment('IEX_API_KEY');

  @override
  Future<double> getStockPrice(String stockSymbol) async {
    final url = '$_baseUrl/stock/$stockSymbol/quote/latestPrice?token=$_apiToken';
    final response = await _httpClient.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return double.parse(response.body);
    }
    throw Exception();
  }

  @override
  Future<String> getStockCompanyName(String stockSymbol) async {
    final url = '$_baseUrl/stock/$stockSymbol/quote/companyName?token=$_apiToken';
    final response = await _httpClient.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.body.replaceAll('"', '');
    }
    throw Exception();
  }
}
