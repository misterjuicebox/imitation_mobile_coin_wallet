import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:imitation_mob_wallet/models/responses/build_and_submit_transaction_response.dart';
import 'package:imitation_mob_wallet/models/responses/get_all_transaction_logs_for_account_response.dart';
import 'package:imitation_mob_wallet/view_models/send_transaction.view_model.dart';

import '../account_constants.dart' as AccountConstants;
import '../models/responses/get_balance_for_account_response.dart';
import 'api.service.dart';

class TransactionService {
  Future<http.Response> getTransactionLogsForBlock(String block) async {
    try {
      return http.post(Uri.parse(AccountConstants.PrimaryAccount.fullServiceUrl),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            "method": "get_all_transaction_logs_for_block",
            "params": {"block_index": block},
            "jsonrpc": "2.0",
            "id": 1
          }));
    } catch (error) {
      throw error;
    }
  }

  Future<ApiService> getAllTransactionLogs() async {
    try {
      final http.Response response = await http.post(Uri.parse(AccountConstants.PrimaryAccount.fullServiceUrl),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            "method": "get_all_transaction_logs_for_account",
            "params": {"account_id": AccountConstants.PrimaryAccount.accountId},
            "jsonrpc": "2.0",
            "id": 1
          }));

      if (response.statusCode == 200) {
        return ApiService(response: getAllTransactionLogsForAccountResponseFromJson(response.body));
      } else {
        return ApiService(errorResponse: 'Failed to get all transaction logs.');
      }
    } catch (error) {
      return ApiService(errorResponse: 'Failed to get all transaction logs.');
    }
  }

  Future<ApiService> receiveTransaction(String amount) async {
    try {
      final http.Response response = await http.post(Uri.parse(AccountConstants.SecondaryAccount.fullServiceUrl),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            "method": "build_and_submit_transaction",
            "params": {
              "account_id": AccountConstants.SecondaryAccount.accountId,
              "recipient_public_address": AccountConstants.PrimaryAccount.mainAddress,
              "value_pmob": amount
            },
            "jsonrpc": "2.0",
            "id": 1
          }));

      if (response.statusCode == 200) {
        return ApiService(response: buildAndSubmitTransactionResponseFromJson(response.body));
      } else {
        return ApiService(
            errorResponse: "Failed to receive transaction. Amount from sender likely exceeds unspent pmob.");
      }
    } catch (error) {
      return ApiService(
          errorResponse: "Failed to receive transaction. Amount from sender likely exceeds unspent pmob.");
    }
  }

  Future<ApiService> buildAndSubmitTransaction(SendTransaction transaction) async {
    try {
      final http.Response response = await http.post(Uri.parse(AccountConstants.PrimaryAccount.fullServiceUrl),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            "method": "build_and_submit_transaction",
            "params": {
              "account_id": AccountConstants.PrimaryAccount.accountId,
              "recipient_public_address": transaction.contact.mainAddress,
              "value_pmob": transaction.balanceStatus.unspentPmob
            },
            "jsonrpc": "2.0",
            "id": 1
          }));

      if (response.statusCode == 200) {
        return ApiService(response: buildAndSubmitTransactionResponseFromJson(response.body));
      } else {
        return ApiService(errorResponse: "Failed to build and submit transaction. Amount likely exceeds unspent pmob.");
      }
    } catch (error) {
      return ApiService(errorResponse: "Failed to build and submit transaction. Amount likely exceeds unspent pmob.");
    }
  }

  Future<ApiService> getBalanceForAccount() async {
    try {
      final http.Response response = await http.post(Uri.parse(AccountConstants.PrimaryAccount.fullServiceUrl),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            "method": "get_balance_for_account",
            "params": {"account_id": AccountConstants.PrimaryAccount.accountId},
            "jsonrpc": "2.0",
            "id": 1
          }));
      if (response.statusCode == 200) {
        // experimenting with json_serialization, annotation and build runner
        // GetBalanceForAccount getBalanceForAccount =
        //     GetBalanceForAccount.fromJson(jsonDecode(response.body)['result']['balance']);

        return ApiService(response: getBalanceForAccountResponseFromJson(response.body));
      } else {
        return ApiService(errorResponse: "Failed to fetch balance for account.");
      }
    } catch (error) {
      return ApiService(errorResponse: "Failed to fetch balance for account.");
    }
  }

  Future<http.Response> getAccountBalance() async {
    try {
      return http.post(Uri.parse(AccountConstants.PrimaryAccount.fullServiceUrl),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            "method": "get_balance_for_account",
            "params": {"account_id": AccountConstants.PrimaryAccount.accountId},
            "jsonrpc": "2.0",
            "id": 1
          }));
    } catch (error) {
      throw error;
    }
  }
}
