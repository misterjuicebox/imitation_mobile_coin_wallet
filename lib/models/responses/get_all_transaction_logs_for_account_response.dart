// this was generated by app.quicktype.io, there's lots of tools to map results but this one was quick to implement

import 'dart:convert';

import '../../account_constants.dart';

GetAllTransactionLogsForAccountResponse getAllTransactionLogsForAccountResponseFromJson(String str) =>
    GetAllTransactionLogsForAccountResponse.fromJson(json.decode(str));

class GetAllTransactionLogsForAccountResponse {
  GetAllTransactionLogsForAccountResponse({
    required this.method,
    required this.result,
    required this.jsonrpc,
    required this.id,
  });

  final String method;
  final Result result;
  final String jsonrpc;
  final int id;

  factory GetAllTransactionLogsForAccountResponse.fromJson(Map<String, dynamic> json) =>
      GetAllTransactionLogsForAccountResponse(
        method: json["method"],
        result: Result.fromJson(json["result"]),
        jsonrpc: json["jsonrpc"],
        id: json["id"],
      );

  Map<String?, dynamic>? toJson() => {
        "method": method,
        "result": result.toJson(),
        "jsonrpc": jsonrpc,
        "id": id,
      };
}

String getAllTransactionLogsForAccountResponseToJson(GetAllTransactionLogsForAccountResponse data) =>
    json.encode(data.toJson());

class Result {
  Result({
    required this.transactionLogIds,
    required this.transactionLogMap,
  });

  final List<String> transactionLogIds;
  final Map<String, TransactionLogMap> transactionLogMap;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        transactionLogIds: List<String>.from(json["transaction_log_ids"].map((x) => x)),
        transactionLogMap: Map.from(json["transaction_log_map"])
            .map((k, v) => MapEntry<String, TransactionLogMap>(k, TransactionLogMap.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "transaction_log_ids": List<dynamic>.from(transactionLogIds.map((x) => x)),
        "transaction_log_map": Map.from(transactionLogMap).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };
}

class TransactionLogMap {
  TransactionLogMap({
    required this.object,
    required this.transactionLogId,
    required this.direction,
    required this.isSentRecovered,
    required this.accountId,
    required this.inputTxos,
    required this.outputTxos,
    required this.changeTxos,
    required this.assignedAddressId,
    required this.valuePmob,
    required this.feePmob,
    required this.submittedBlockIndex,
    required this.finalizedBlockIndex,
    required this.status,
    required this.sentTime,
    required this.comment,
    required this.failureCode,
    required this.failureMessage,
  });

  final Object object;
  final String transactionLogId;
  final String direction;
  final dynamic isSentRecovered;
  final AccountId accountId;
  final List<Txo> inputTxos;
  final List<Txo> outputTxos;
  final List<Txo> changeTxos;
  final String? assignedAddressId;
  final String? valuePmob;
  final String? feePmob;
  final String? submittedBlockIndex;
  final String? finalizedBlockIndex;
  final Status status;
  final String? sentTime;
  final String comment;
  final dynamic failureCode;
  final dynamic failureMessage;

  factory TransactionLogMap.fromJson(Map<String, dynamic> json) => TransactionLogMap(
        object: objectValues.map[json["object"]]!,
        transactionLogId: json["transaction_log_id"],
        direction: json["direction"],
        isSentRecovered: json["is_sent_recovered"],
        accountId: accountIdValues.map[json["account_id"]]!,
        inputTxos: List<Txo>.from(json["input_txos"].map((x) => Txo.fromJson(x))),
        outputTxos: List<Txo>.from(json["output_txos"].map((x) => Txo.fromJson(x))),
        changeTxos: List<Txo>.from(json["change_txos"].map((x) => Txo.fromJson(x))),
        assignedAddressId: json["assigned_address_id"] == null ? null : json["assigned_address_id"],
        valuePmob: json["value_pmob"],
        feePmob: json["fee_pmob"] == null ? null : json["fee_pmob"],
        submittedBlockIndex: json["submitted_block_index"] == null ? null : json["submitted_block_index"],
        finalizedBlockIndex: json["finalized_block_index"] == null ? null : json["finalized_block_index"],
        status: statusValues.map[json["status"]]!,
        sentTime: json["sent_time"] == null ? null : json["sent_time"],
        comment: json["comment"],
        failureCode: json["failure_code"],
        failureMessage: json["failure_message"],
      );

  Map<String, dynamic> toJson() => {
        "object": objectValues.reverse![object],
        "transaction_log_id": transactionLogId,
        "direction": directionValues.reverse![direction],
        "is_sent_recovered": isSentRecovered,
        "account_id": accountIdValues.reverse![accountId],
        "input_txos": List<dynamic>.from(inputTxos.map((x) => x.toJson())),
        "output_txos": List<dynamic>.from(outputTxos.map((x) => x.toJson())),
        "change_txos": List<dynamic>.from(changeTxos.map((x) => x.toJson())),
        "assigned_address_id": assignedAddressId == null ? null : assignedAddressId,
        "value_pmob": valuePmob,
        "fee_pmob": feePmob == null ? null : feePmob,
        "submitted_block_index": submittedBlockIndex == null ? null : submittedBlockIndex,
        "finalized_block_index": finalizedBlockIndex == null ? null : finalizedBlockIndex,
        "status": statusValues.reverse![status],
        "sent_time": sentTime == null ? null : sentTime,
        "comment": comment,
        "failure_code": failureCode,
        "failure_message": failureMessage,
      };
}

enum AccountId { ID }

final accountIdValues = EnumValues({PrimaryAccount.accountId: AccountId.ID});

class Txo {
  Txo({
    required this.txoIdHex,
    required this.recipientAddressId,
    required this.valuePmob,
  });

  final String txoIdHex;
  final String recipientAddressId;
  final String valuePmob;

  factory Txo.fromJson(Map<String, dynamic> json) => Txo(
        txoIdHex: json["txo_id_hex"],
        recipientAddressId: json["recipient_address_id"],
        valuePmob: json["value_pmob"],
      );

  Map<String, dynamic> toJson() => {
        "txo_id_hex": txoIdHex,
        "recipient_address_id": recipientAddressId,
        "value_pmob": valuePmob,
      };
}

enum Direction { TX_DIRECTION_RECEIVED, TX_DIRECTION_SENT }

final directionValues = EnumValues(
    {"tx_direction_received": Direction.TX_DIRECTION_RECEIVED, "tx_direction_sent": Direction.TX_DIRECTION_SENT});

enum Object { TRANSACTION_LOG }

final objectValues = EnumValues({"transaction_log": Object.TRANSACTION_LOG});

enum Status { TX_STATUS_SUCCEEDED, TX_STATUS_PENDING }

final statusValues =
    EnumValues({"tx_status_pending": Status.TX_STATUS_PENDING, "tx_status_succeeded": Status.TX_STATUS_SUCCEEDED});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
