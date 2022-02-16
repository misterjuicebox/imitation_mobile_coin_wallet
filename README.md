## Imitation MobileCoin Wallet

This app displays a PrimaryAccount's balance in MOB and USD with toggle, and a Primary Account's transaction history. It also allows a PrimaryAccount to send a small amount of MOB
to a SecondaryAccount. Finally, a SecondaryAccount will send a small amount of MOB to a PrimaryAccount if the user clicks "Receive". Note: there is no indicator after clicking receive, as the app mimics receiving a payment like the official app. However, in theory, an error message will show if the transaction fails.

## Setup

You'll need to run two instances of [Full Service](https://github.com/mobilecoinofficial/full-service/releases) on different ports and different dbs. Here's two commands 
you can run to use testnet:

```
mkdir -p testnet-dbs
RUST_LOG=info,mc_connection=info,mc_ledger_sync=info ./full-service \
--wallet-db ./testnet-dbs/wallet2.db \
--ledger-db ./testnet-dbs/ledger-db/ \
--peer mc://node1.test.mobilecoin.com/ \
--peer mc://node2.test.mobilecoin.com/ \
--tx-source-url https://s3-us-west-1.amazonaws.com/mobilecoin.chain/node1.test.mobilecoin.com/ \
--tx-source-url https://s3-us-west-1.amazonaws.com/mobilecoin.chain/node2.test.mobilecoin.com/ \
--fog-ingest-enclave-css $(pwd)/ingest-enclave.css \
--listen-port 7777
```

```
mkdir -p testnet-dbs
RUST_LOG=info,mc_connection=info,mc_ledger_sync=info ./full-service \
--wallet-db ./testnet-dbs/wallet.db \
--ledger-db ./testnet-dbs/ledger-db/ \
--peer mc://node1.test.mobilecoin.com/ \
--peer mc://node2.test.mobilecoin.com/ \
--tx-source-url https://s3-us-west-1.amazonaws.com/mobilecoin.chain/node1.test.mobilecoin.com/ \
--tx-source-url https://s3-us-west-1.amazonaws.com/mobilecoin.chain/node2.test.mobilecoin.com/ \
--fog-ingest-enclave-css $(pwd)/ingest-enclave.css \
```

You'll also need to rename and fill out the relevant account values for a PrimaryAccount and SecondaryAccount in `account_constants_template.dart` 
Also rename the file by running:

```
mv account_constants_template.dart account_constants.dart
```

Finally, run flutter. Note: this app has only been tested and run on an iPhone 13 simulator. Hopefully, it works on other devices :O)

```
flutter pub get
run flutter
```

That should do it! If you don't have a CoinMarketCap API key, you can leave it blank in the `account_constants.dart` file and the app will use hard-coded data.
