import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:imitation_mob_wallet/models/currency_display.model.dart';

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

// would be better to have different view models for the different relevant models:
// imitation app-wide, transaction, balance, currency, contacts
class Imitation with ChangeNotifier {
  // transaction logs used to show list of transactions
  List<Transaction> _transactionLogs = [];

  List<Transaction> get transactionLogs {
    return [..._transactionLogs];
  }

  setTransactionLogs(List<Transaction> transactionLogs) {
    _transactionLogs = transactionLogs;
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
  BalanceStatus _balanceStatus = BalanceStatus(unspentPmob: '', displayMob: '', accountBlockHeight: '', dollars: '');

  BalanceStatus get balanceStatus {
    return _balanceStatus;
  }

  setBalanceStatus(BalanceStatus balanceStatus) {
    _balanceStatus = balanceStatus;
  }

  // determines which price to show on primary and secondary totals via toggle button
  CurrencyDisplay _currencyDisplay = CurrencyDisplay(currency: Constants.usd);

  CurrencyDisplay get currencyDisplay {
    return _currencyDisplay;
  }

  setCurrencyDisplay(CurrencyDisplay currencyDisplay) {
    _currencyDisplay = currencyDisplay;
    notifyListeners();
  }

  // used to display list of contacts
  List<Contact> _contacts = [];

  List<Contact> get contacts {
    return [..._contacts];
  }

  setContacts(List<Contact> contacts) {
    _contacts = contacts;
  }

  GetBalanceForAccountResponse? _getBalanceForAccountResponse;

  GetBalanceForAccountResponse? get getBalanceForAccountResponse {
    return _getBalanceForAccountResponse;
  }

  setBalanceForAccountResponse(GetBalanceForAccountResponse response) {
    _getBalanceForAccountResponse = response;
  }

  // contains mobPrice via coinmarketcap api
  MobPriceResponse? _mobPrice;

  MobPriceResponse? get mobPrice {
    return _mobPrice;
  }

  setMobPrice(MobPriceResponse mobPrice) {
    _mobPrice = mobPrice;
  }

  // used to show error if data didn't load
  bool _dataLoaded = false;

  bool get dataLoaded {
    return _dataLoaded;
  }

  setDataLoaded(bool dataLoaded) {
    _dataLoaded = dataLoaded;
  }

  Future<void> initImitation() async {
    await getMobPrice();
    await getBalance();
    List<Transaction> transactionLogs = await getTransactionLogs();
    setTransactionLogs(transactionLogs);
    setContacts(Constants.ogContacts);
    setDataLoaded(true);
    notifyListeners();
    setPoll();
  }

  void setPoll() {
    Timer.periodic(Duration(seconds: 5), (timer) async {
      // await getMobPrice(); ideally would run this but my api usage will get capped
      await getBalance(); // consider using same pattern on getBalance as getTransaction log, return balance and set outside of getBalance
      List<Transaction> transactionLogs = [];
      transactionLogs = await getTransactionLogs();

      if (_transactionLogs.length > 0 && _verifyingTransactions.length > 0) {
        clearVerified(transactionLogs);
      }

      // only set transactions if new ones exist so as not to rebuild unnecessarily
      if (transactionLogs.length > _transactionLogs.length) {
        setConfirm(transactionLogs);
        setTransactionLogs(transactionLogs);
      }
      // notify in case data failed to load in some dataPolls and then succeeds with no new transactions
      setDataLoaded(true);
      notifyListeners();
    });
  }

  Future<void> getMobPrice() async {
    final ApiService mobPriceResponse = await PriceService().getMobPrice();
    if (mobPriceResponse.response != null) {
      setMobPrice(mobPriceResponse.response as MobPriceResponse);
    } else {
      setDataLoaded(false);
    }
  }

  Future<void> getBalance() async {
    final ApiService balanceResponse = await TransactionService().getBalanceForAccount();
    if (balanceResponse.response != null) {
      setBalanceForAccountResponse(balanceResponse.response as GetBalanceForAccountResponse);
      setBalanceStatus(BalanceStatus(
          unspentPmob: CurrencyUtil.setMob(getBalanceForAccountResponse?.result.balance.unspentPmob),
          displayMob: getBalanceForAccountResponse?.result.balance.unspentPmob,
          dollars: CurrencyUtil.setDollars(
              getBalanceForAccountResponse?.result.balance.unspentPmob, mobPrice?.data.the7878.quote.usd.price)));
    } else {
      setDataLoaded(false);
    }
  }

  Future<List<Transaction>> getTransactionLogs() async {
    final ApiService txsResponse = await TransactionService().getAllTransactionLogs();

    if (txsResponse.response != null) {
      return await handleTransactionLogResponse(txsResponse.response as GetAllTransactionLogsForAccountResponse);
    } else {
      setDataLoaded(false);
      return [];
    }
  }

  Future<List<Transaction>> handleTransactionLogResponse(GetAllTransactionLogsForAccountResponse response) async {
    List<Transaction> transactionLogs = [];
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
    // not confident this is the right way to clear/confirm a verifying transaction
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
