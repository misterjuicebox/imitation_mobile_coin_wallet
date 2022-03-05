import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../constants.dart' as Constants;
import '../models/balance_status.model.dart';
import '../models/build_and_submit_transaction_response.dart';
import '../models/contact.model.dart';
import '../models/get_all_transaction_logs_for_account_response.dart';
import '../models/get_balance_for_account_response.dart';
import '../models/mob_price_response.model.dart';
import '../models/transaction_log.model.dart';
import '../models/verifying_transaction.model.dart';
import '../services/api.service.dart';
import '../services/price.service.dart';
import '../services/transaction.service.dart';
import '../utils/currency.util.dart' as CurrencyUtil;

class Imitation with ChangeNotifier {
  // transaction logs used to show list of transactions
  List<Transaction> _transactionLogs = [];

  List<Transaction> get transactionLogs {
    return [..._transactionLogs];
  }

  setTransactionLogs(List<Transaction> transactionLogs) {
    _transactionLogs = transactionLogs;
    notifyListeners();
  }

  // list of transactions in verifying state after user sends
  List<VerifyingTransaction> _verifyingTransactions = [];

  List<VerifyingTransaction> get verifyingTransactions {
    return [..._verifyingTransactions];
  }

  setVerifyingTransactions(List<VerifyingTransaction> verifyingTransactions) {
    _verifyingTransactions = verifyingTransactions;
    notifyListeners();
  }

  addVerifyingTransaction(VerifyingTransaction verifyingTransaction) {
    _verifyingTransactions.insert(0, verifyingTransaction);
    notifyListeners();
  }

  // displays balance for user in mob and usd
  BalanceStatus _balanceStatus = BalanceStatus.init();

  BalanceStatus get balanceStatus {
    return _balanceStatus;
  }

  setBalanceStatus(BalanceStatus balanceStatus) {
    _balanceStatus = balanceStatus;
    notifyListeners();
  }

  MobPriceResponse? _mobPrice;

  MobPriceResponse? get mobPrice => _mobPrice;

  setMobPrice(MobPriceResponse mobPrice) {
    _mobPrice = mobPrice;
    notifyListeners();
  }

  // used to display list of contacts
  List<Contact> _contacts = [];

  List<Contact> get contacts {
    return [..._contacts];
  }

  setContacts(List<Contact> contacts) {
    _contacts = contacts;
    notifyListeners();
  }

  // used to show error if data didn't load
  // set to true here so it doesn't show each time app boots
  bool _dataLoaded = true;

  bool get dataLoaded {
    return _dataLoaded;
  }

  setDataLoaded(bool dataLoaded) {
    _dataLoaded = dataLoaded;
    notifyListeners();
  }

  Future<void> initImitation() async {
    LoadData? loadData = await getData();

    if (loadData != null) {
      setBalanceStatus(loadData.balanceStatus!);
      setTransactionLogs(loadData.transactionLogs!);
      setContacts(Constants.ogContacts);
      setDataLoaded(true);
    }
    setPoll();
  }

  void setPoll() {
    Timer.periodic(Duration(seconds: 5), (timer) async {
      LoadData? loadData = await getData();

      if (loadData != null) {
        // if data loaded and previous data loaded value was false set to true so that error no longer shows
        // don't set to true everytime because setting to true rebuilds entire transaction list
        // because dataLoaded is a conditional used to display list or not
        if (!_dataLoaded) setDataLoaded(true);
        // check for new transactions, only notify if new exist to prevent unnecessary rebuilds of ui
        int newLength = loadData.transactionLogs?.length ?? 0;
        if (newLength > transactionLogs.length) {
          setBalanceStatus(loadData.balanceStatus!);
          setConfirm(loadData.transactionLogs!);
          setTransactionLogs(loadData.transactionLogs!);
          if (_verifyingTransactions.length > 0) clearVerified(transactionLogs);
        }
      }
    });
  }

  Future<LoadData?> getData() async {
    MobPriceResponse? mobPrice;
    final ApiService mobPriceResponse = await PriceService().getMobPrice();
    if (mobPriceResponse.response != null) {
      mobPrice = mobPriceResponse.response as MobPriceResponse;
      setMobPrice(mobPrice);
    } else {
      setDataLoaded(false);
      return null;
    }

    GetBalanceForAccountResponse? balanceResponse;
    final ApiService getBalanceResponse = await TransactionService().getBalanceForAccount();
    BalanceStatus balance;
    if (getBalanceResponse.response != null) {
      balanceResponse = getBalanceResponse.response as GetBalanceForAccountResponse;
      balance = BalanceStatus(
          balanceResponse.result.balance.unspentPmob,
          CurrencyUtil.convertToDisplayMob(balanceResponse.result.balance.unspentPmob),
          CurrencyUtil.setDollars(balanceResponse.result.balance.unspentPmob, mobPrice.data.the7878.quote.usd.price));
    } else {
      setDataLoaded(false);
      return null;
    }

    final ApiService txsResponse = await TransactionService().getAllTransactionLogs();
    List<Transaction>? transactionLogs;
    if (txsResponse.response != null) {
      transactionLogs = handleTransactionLogResponse(txsResponse.response as GetAllTransactionLogsForAccountResponse);
    } else {
      setDataLoaded(false);
      return null;
    }

    return LoadData(balance, transactionLogs);
  }

  List<Transaction>? handleTransactionLogResponse(GetAllTransactionLogsForAccountResponse response) {
    List<Transaction> transactionLogs = [];
    if (response.result.transactionLogMap.length < 1) {
      setDataLoaded(false);
      return null;
    }
    response.result.transactionLogMap.forEach((transactionLogId, transactionLog) {
      if (Transaction.verify(transactionLog)) {
        transactionLogs.insert(
            0,
            Transaction(
                id: transactionLogId,
                direction: transactionLog.direction,
                sentTime: transactionLog.sentTime ?? DateTime.now().toString(),
                // how do we get received sent_time? went through full-service api and could not determine
                // must come from somewhere because when i restore wallet on official app it has the times for received transactions
                valuePmob: transactionLog.valuePmob!,
                feePmob: transactionLog.feePmob,
                finalizedBlockIndex: transactionLog.finalizedBlockIndex!));
      }
    });
    return transactionLogs;
  }

  Future<void> finishTransaction(Transaction tx) async {
    await Future.delayed(Duration(seconds: 3), () => setFinish(tx));
  }

  void setFinish(Transaction tx) {
    tx.confirm = false;
    notifyListeners();
  }

  void clearVerified(List<Transaction> transactionLogs) {
    // what is the right way to clear/confirm a transaction that's been sent
    // after studying full service docs for sometime, this is the best i got
    if (transactionLogs[0].finalizedBlockIndex == _verifyingTransactions[0].submittedBlockIndex) {
      setVerifyingTransactions([]);
    }
  }

  void setConfirm(List<Transaction> transactionLogs) {
    for (var i = 0; i < (transactionLogs.length - _transactionLogs.length); i++) {
      transactionLogs[i].confirm = true;
      finishTransaction(transactionLogs[i]);
    }
  }

  void buildAndSetVerifyingTransaction(BuildAndSubmitTransactionResponse response) {
    String totalPmob = CurrencyUtil.addFee(response.result.transactionLog.valuePmob);

    VerifyingTransaction verifyingTransaction = VerifyingTransaction(
        contact: Constants.ogContacts[Random().nextInt(6)],
        pmob: totalPmob,
        sentTime: DateTime.now().toString(),
        submittedBlockIndex: response.result.transactionLog.submittedBlockIndex);
    addVerifyingTransaction(verifyingTransaction);
  }
}

class LoadData {
  BalanceStatus? balanceStatus;
  List<Transaction>? transactionLogs;

  LoadData(this.balanceStatus, this.transactionLogs);
}
