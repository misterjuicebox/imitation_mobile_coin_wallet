import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:imitation_mob_wallet/account_constants.dart' as Constants;

import '../models/mob_price_response.model.dart';
import 'api.service.dart';

class PriceService {
  Future<ApiService> getMobPrice() async {
    if (Constants.coinMarketCapApiKey == '') {
      var response = Constants.backupMobPrice;
      return ApiService(response: MobPriceResponse.fromJson(response));
    }

    try {
      var response = await http.get(
          Uri.parse('https://pro-api.coinmarketcap.com/v2/cryptocurrency/quotes/latest?slug=mobilecoin'),
          headers: <String, String>{
            'X-CMC_PRO_API_KEY': Constants.coinMarketCapApiKey,
            'Content-Type': 'application/json',
          });

      if (response.statusCode == 200) {
        return ApiService(response: mobPriceResponseFromJson(response.body));
      } else {
        return ApiService(errorResponse: 'Failed to fetch MOB price.');
      }
    } catch (error) {
      return ApiService(errorResponse: 'Failed to fetch MOB price.');
    }
  }
}
